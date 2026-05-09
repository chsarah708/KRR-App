#!/bin/bash

# KRR Project Deployment Script
# Deploys to Vercel (frontend) and Railway (backend)

set -e

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║         🚀 KRR Project Deployment Script                     ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Check if we're in the right directory
if [ ! -f "package.json" ] || [ ! -d "frontend" ] || [ ! -d "backend" ]; then
    echo -e "${RED}❌ Error: Please run this script from the project root directory${NC}"
    exit 1
fi

echo -e "${BLUE}📋 Starting deployment process...${NC}"
echo ""

# ── Step 1: Install dependencies ────────────────────────────────────
echo -e "${YELLOW}📦 Installing dependencies...${NC}"
echo ""

# Frontend dependencies
echo "Installing frontend dependencies..."
cd frontend
npm install
cd ..

# Backend dependencies
echo "Installing backend dependencies..."
cd backend
pip install -r requirements.txt
cd ..

echo -e "${GREEN}✅ Dependencies installed${NC}"
echo ""

# ── Step 2: Deploy Frontend to Vercel ──────────────────────────────
echo -e "${YELLOW}🌐 Deploying frontend to Vercel...${NC}"
echo ""

if command -v vercel >/dev/null 2>&1; then
    echo "Vercel CLI found. Deploying..."
    cd frontend
    vercel --prod
    cd ..
    echo -e "${GREEN}✅ Frontend deployed to Vercel${NC}"
else
    echo -e "${RED}❌ Vercel CLI not found. Install it first:${NC}"
    echo "   npm install -g vercel"
    echo "   Then run: vercel login"
    exit 1
fi

echo ""

# ── Step 3: Deploy Backend to Railway ───────────────────────────────
echo -e "${YELLOW}🚂 Deploying backend to Railway...${NC}"
echo ""

if command -v railway >/dev/null 2>&1; then
    echo "Railway CLI found. Deploying..."
    cd backend
    railway up
    cd ..
    echo -e "${GREEN}✅ Backend deployed to Railway${NC}"
else
    echo -e "${RED}❌ Railway CLI not found. Install it first:${NC}"
    echo "   npm install -g @railway/cli"
    echo "   Then run: railway login"
    exit 1
fi

echo ""

# ── Step 4: Final Setup ──────────────────────────────────────────
echo -e "${YELLOW}📝 Final setup steps:${NC}"
echo ""
echo "1. Get your Railway backend URL from the Railway dashboard"
echo "2. Update vercel.json with your Railway URL:"
echo "   - Edit the VITE_API_URL field"
echo "   - Replace 'your-railway-app' with your actual Railway app name"
echo "3. Redeploy Vercel:"
echo "   cd frontend && vercel --prod"
echo ""
echo -e "${BLUE}🎉 Deployment complete!${NC}"
echo ""
echo -e "${CYAN}Access your app:${NC}"
echo "   Frontend: https://your-vercel-app.vercel.app"
echo "   Backend:  https://your-railway-app.railway.app"
echo "   API Docs: https://your-railway-app.railway.app/docs"