#!/usr/bin/env node
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import sharp from 'sharp';
import * as simpleIcons from 'simple-icons';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const ROOT = path.resolve(__dirname, '..');
const DATA = path.join(ROOT, 'data', 'tech-list.json');
const OUT_SVG = path.join(ROOT, 'assets', 'svg');
const OUT_PNG = {
  small: path.join(ROOT, 'assets', 'png', 'small'),
  medium: path.join(ROOT, 'assets', 'png', 'medium'),
  large: path.join(ROOT, 'assets', 'png', 'large'),
};
const OUT_CATALOG = path.join(ROOT, 'data', 'catalog.json');

const PNG_SIZES = { small: 375, medium: 525, large: 750 };

// Build slug → icon map from all simple-icons exports
const iconsBySlug = new Map();
for (const [key, value] of Object.entries(simpleIcons)) {
  if (key.startsWith('si') && value?.slug) {
    iconsBySlug.set(value.slug, value);
  }
}

console.log(`Loaded ${iconsBySlug.size} icons from simple-icons`);

async function ensureDirs() {
  await fs.mkdir(OUT_SVG, { recursive: true });
  await Promise.all(Object.values(OUT_PNG).map((d) => fs.mkdir(d, { recursive: true })));
}

function getIconBySlug(slug) {
  return iconsBySlug.get(slug) || null;
}

function colorizeIcon(svg, hex) {
  // Inject fill color into all <path> elements
  // Simple Icons SVGs have one or more <path> tags without fill attribute
  return svg.replace(/<path /g, `<path fill="#${hex}" `);
}

async function writeSVG(slug, coloredSvg) {
  const out = path.join(OUT_SVG, `${slug}.svg`);
  await fs.writeFile(out, coloredSvg, 'utf8');
}

async function writePNGs(slug, coloredSvg, sizes = PNG_SIZES) {
  const svgBuffer = Buffer.from(coloredSvg);
  await Promise.all(
    Object.entries(sizes).map(async ([label, px]) => {
      const out = path.join(OUT_PNG[label], `${slug}.png`);
      // Render colored SVG to PNG at specified width
      await sharp(svgBuffer, { density: 300 })
        .resize({ width: px, withoutEnlargement: false })
        .png({ compressionLevel: 9 })
        .toFile(out);
    })
  );
}

async function main() {
  await ensureDirs();
  const raw = await fs.readFile(DATA, 'utf8');
  const slugs = JSON.parse(raw);

  const missing = [];
  const catalog = [];
  let ok = 0;

  for (const slug of slugs) {
    const icon = getIconBySlug(slug);
    if (!icon) {
      missing.push(slug);
      continue;
    }
    const { svg, hex, title, source, guidelines, license } = icon;
    const coloredSvg = colorizeIcon(svg, hex);
    
    await writeSVG(slug, coloredSvg);
    await writePNGs(slug, coloredSvg);
    
    catalog.push({ slug, title, hex, source, guidelines, license });
    ok += 1;
    process.stdout.write(`\rGenerated: ${ok}/${slugs.length} (${title})`);
  }
  process.stdout.write('\n');

  await fs.writeFile(OUT_CATALOG, JSON.stringify(catalog, null, 2), 'utf8');
  console.log(`\n✓ Wrote catalog for ${catalog.length} icons to catalog.json`);

  if (missing.length) {
    console.warn(`\n⚠ Missing ${missing.length} icons (check slugs):`);
    for (const m of missing) console.warn('  -', m);
    const missPath = path.join(ROOT, 'data', 'missing-slugs.txt');
    await fs.writeFile(missPath, missing.join('\n'), 'utf8');
    console.warn(`  Wrote missing list to missing-slugs.txt`);
  }

  console.log('\n✓ Done! All stickers exported in FULL COLOR (SVG + 3 PNG sizes)');
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
