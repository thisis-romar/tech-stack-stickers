import sharp from 'sharp';
import { readFile } from 'fs/promises';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const projectRoot = join(__dirname, '..');

// Image dimensions
const WIDTH = 1280;
const HEIGHT = 640;
const ICON_SIZE = 100;
const GRID_COLS = 4;
const GRID_ROWS = 4;
const ICON_PADDING = 30;

// Featured icons (16 popular tech stack logos)
const featuredIcons = [
  'react',
  'nodedotjs',
  'python',
  'docker',
  'kubernetes',
  'typescript',
  'vuedotjs',
  'angular',
  'postgresql',
  'mongodb',
  'redis',
  'github',
  'javascript',
  'tailwindcss',
  'go',
  'rust'
];

async function generateSocialPreview() {
  console.log('🎨 Generating social preview image...\n');

  // Create dark background
  const background = sharp({
    create: {
      width: WIDTH,
      height: HEIGHT,
      channels: 4,
      background: { r: 26, g: 26, b: 26, alpha: 1 } // #1a1a1a
    }
  });

  // Load and prepare icon overlays
  const composites = [];
  
  // Calculate grid layout
  const gridWidth = (GRID_COLS * ICON_SIZE) + ((GRID_COLS - 1) * ICON_PADDING);
  const gridHeight = (GRID_ROWS * ICON_SIZE) + ((GRID_ROWS - 1) * ICON_PADDING);
  const startX = Math.floor((WIDTH - gridWidth) / 2);
  const startY = Math.floor((HEIGHT - gridHeight) / 2);

  for (let i = 0; i < featuredIcons.length; i++) {
    const iconSlug = featuredIcons[i];
    const iconPath = join(projectRoot, 'assets', 'svg', `${iconSlug}.svg`);
    
    try {
      // Load SVG and resize to icon size
      const iconBuffer = await readFile(iconPath);
      const resizedIcon = await sharp(iconBuffer)
        .resize(ICON_SIZE, ICON_SIZE, {
          fit: 'contain',
          background: { r: 0, g: 0, b: 0, alpha: 0 }
        })
        .toBuffer();

      // Calculate position in grid
      const col = i % GRID_COLS;
      const row = Math.floor(i / GRID_COLS);
      const left = startX + (col * (ICON_SIZE + ICON_PADDING));
      const top = startY + (row * (ICON_SIZE + ICON_PADDING));

      composites.push({
        input: resizedIcon,
        left,
        top
      });

      console.log(`✓ Loaded ${iconSlug}.svg at position (${left}, ${top})`);
    } catch (error) {
      console.warn(`⚠️  Could not load ${iconSlug}.svg:`, error.message);
    }
  }

  // Create title text as SVG
  const titleSvg = `
    <svg width="${WIDTH}" height="150">
      <defs>
        <style>
          @import url('https://fonts.googleapis.com/css2?family=Inter:wght@700;900&amp;display=swap');
          .title { 
            font-family: 'Inter', 'Arial', sans-serif; 
            font-weight: 900; 
            font-size: 56px; 
            fill: #ffffff;
            text-anchor: middle;
          }
          .subtitle { 
            font-family: 'Inter', 'Arial', sans-serif; 
            font-weight: 700; 
            font-size: 24px; 
            fill: #a0a0a0;
            text-anchor: middle;
          }
        </style>
      </defs>
      <text x="${WIDTH / 2}" y="60" class="title">Tech Stack Stickers</text>
      <text x="${WIDTH / 2}" y="100" class="subtitle">123 Full-Color Logos for Conference Networking</text>
    </svg>
  `;

  const titleBuffer = Buffer.from(titleSvg);
  
  composites.unshift({
    input: titleBuffer,
    left: 0,
    top: 30
  });

  // Composite everything together
  console.log(`\n🔄 Compositing ${composites.length} elements...`);
  
  const outputPath = join(projectRoot, 'social-preview.png');
  
  await background
    .composite(composites)
    .png({ quality: 90, compressionLevel: 9 })
    .toFile(outputPath);

  // Get file stats
  const stats = await sharp(outputPath).metadata();
  const fileSize = (await readFile(outputPath)).length;
  const fileSizeKB = (fileSize / 1024).toFixed(2);

  console.log('\n✅ Social preview image generated successfully!');
  console.log(`📏 Dimensions: ${stats.width}x${stats.height}px`);
  console.log(`📦 File size: ${fileSizeKB} KB`);
  console.log(`📁 Output: ${outputPath}`);
  
  if (fileSize > 1024 * 1024) {
    console.warn(`⚠️  Warning: File size exceeds 1MB (${fileSizeKB} KB)`);
  }
}

// Run the generator
generateSocialPreview().catch(error => {
  console.error('❌ Error generating social preview:', error);
  process.exit(1);
});
