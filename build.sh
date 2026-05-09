#!/bin/bash

# KRR Project Production Build Script
# Creates optimized builds for deployment

set -e

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║         🚀 KRR Project Production Build Script               ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ── Check if we're in the right directory ─────────────────────────
if [ ! -f "package.json" ] || [ ! -d "frontend" ] || [ ! -d "backend" ]; then
    echo -e "${RED}❌ Error: Please run this script from the project root directory${NC}"
    exit 1
fi

echo -e "${BLUE}📋 Starting production build process...${NC}"
echo ""

# ── Build Frontend ──────────────────────────────────────────────
echo -e "${YELLOW}📦 Building frontend...${NC}"
echo ""

cd frontend
if [ -f "package.json" ]; then
    echo "Installing frontend dependencies..."
    npm install --production

    echo "Building frontend for production..."
    npm run build

    echo -e "${GREEN}✅ Frontend built successfully${NC}"
else
    echo -e "${RED}❌ Error: frontend/package.json not found${NC}"
    exit 1
fi
cd ..

# ── Build Backend ───────────────────────────────────────────────
echo ""
echo -e "${YELLOW}📦 Building backend...${NC}"
echo ""

cd backend
if [ -f "requirements.txt" ]; then
    echo "Installing backend dependencies..."
    pip install --no-cache-dir -r requirements.txt

    echo -e "${GREEN}✅ Backend dependencies installed${NC}"
else
    echo -e "${RED}❌ Error: backend/requirements.txt not found${NC}"
    exit 1
fi
cd ..

echo ""
echo -e "${BLUE}🎉 Production build complete!${NC}"
echo ""
echo "📁 Files created:"
echo "   - frontend/dist/: Built frontend assets"
echo "   - backend/requirements.txt: Production dependencies"
echo ""
echo "💡 To deploy:"
echo "   - Use Railway for backend"
echo "   - Use Vercel for frontend"