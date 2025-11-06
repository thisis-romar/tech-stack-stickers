#!/usr/bin/env node
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { execSync } from 'node:child_process';
import sharp from 'sharp';
import * as simpleIcons from 'simple-icons';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const ROOT = path.resolve(__dirname, '..');
const DATA = path.join(ROOT, 'data', 'tech-list.json');
const CATEGORY_MAPPINGS = path.join(ROOT, 'data', 'category-mappings.json');
const OUT_SVG = path.join(ROOT, 'assets', 'svg');
const OUT_PNG = {
  small: path.join(ROOT, 'assets', 'png', 'small'),
  medium: path.join(ROOT, 'assets', 'png', 'medium'),
  large: path.join(ROOT, 'assets', 'png', 'large'),
};
const OUT_CATALOG = path.join(ROOT, 'data', 'catalog.json');

const PNG_SIZES = { small: 375, medium: 525, large: 750 };

// Detect current git branch
function getCurrentBranch() {
  try {
    return execSync('git branch --show-current', { encoding: 'utf8' }).trim();
  } catch {
    return 'main';
  }
}

// Load category mappings for current branch
async function loadCategoryMappings() {
  const branch = getCurrentBranch();
  console.log(`Detected branch: ${branch}`);
  
  const raw = await fs.readFile(CATEGORY_MAPPINGS, 'utf8');
  const allMappings = JSON.parse(raw);
  const mapping = allMappings[branch] || {};
  
  if (Object.keys(mapping).length === 0) {
    console.log('No category mapping for this branch - using flat structure');
    return null;
  }
  
  // Invert mapping: slug → category
  const slugToCategory = new Map();
  for (const [category, slugs] of Object.entries(mapping)) {
    for (const slug of slugs) {
      slugToCategory.set(slug, category);
    }
  }
  
  console.log(`Loaded ${Object.keys(mapping).length} categories for ${branch}`);
  return slugToCategory;
}

let categoryMapping = null;

// Build slug → icon map from all simple-icons exports
const iconsBySlug = new Map();
for (const [key, value] of Object.entries(simpleIcons)) {
  if (key.startsWith('si') && value?.slug) {
    iconsBySlug.set(value.slug, value);
  }
}

console.log(`Loaded ${iconsBySlug.size} icons from simple-icons`);

async function ensureDirs() {
  if (!categoryMapping) {
    // Flat structure
    await fs.mkdir(OUT_SVG, { recursive: true });
    await Promise.all(Object.values(OUT_PNG).map((d) => fs.mkdir(d, { recursive: true })));
  } else {
    // Categorized structure - create category subdirectories
    const categories = new Set(categoryMapping.values());
    for (const category of categories) {
      await fs.mkdir(path.join(OUT_SVG, category), { recursive: true });
      for (const pngDir of Object.values(OUT_PNG)) {
        await fs.mkdir(path.join(pngDir, category), { recursive: true });
      }
    }
  }
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
  const category = categoryMapping?.get(slug);
  const out = category
    ? path.join(OUT_SVG, category, `${slug}.svg`)
    : path.join(OUT_SVG, `${slug}.svg`);
  await fs.writeFile(out, coloredSvg, 'utf8');
}

async function writePNGs(slug, coloredSvg, sizes = PNG_SIZES) {
  const category = categoryMapping?.get(slug);
  const svgBuffer = Buffer.from(coloredSvg);
  await Promise.all(
    Object.entries(sizes).map(async ([label, px]) => {
      const out = category
        ? path.join(OUT_PNG[label], category, `${slug}.png`)
        : path.join(OUT_PNG[label], `${slug}.png`);
      // Render colored SVG to PNG at specified width
      await sharp(svgBuffer, { density: 300 })
        .resize({ width: px, withoutEnlargement: false })
        .png({ compressionLevel: 9 })
        .toFile(out);
    })
  );
}

async function main() {
  categoryMapping = await loadCategoryMappings();
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
    const category = categoryMapping?.get(slug) || null;
    
    await writeSVG(slug, coloredSvg);
    await writePNGs(slug, coloredSvg);
    
    catalog.push({ slug, title, hex, category, source, guidelines, license });
    ok += 1;
    process.stdout.write(`\rGenerated: ${ok}/${slugs.length} (${title})${category ? ` [${category}]` : ''}`);
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
  if (categoryMapping) {
    const categories = new Set(categoryMapping.values());
    console.log(`✓ Organized into ${categories.size} categories`);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
