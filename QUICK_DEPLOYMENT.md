# 🚀 KRR Project - Quick Deployment Guide

## ⚠️ Note: PyMuPDF Installation Issue
PyMuPDF (fitz) is having installation issues on this system. For now, we'll deploy without PDF functionality and fix it later.

## Prerequisites
- Node.js 18+
- Python 3.10+
- Groq API Key (get from [Groq Console](https://console.groq.com/))

## Step 1: Install CLI Tools
```bash
# Install Vercel CLI
npm install -g vercel

# Install Railway CLI
npm install -g @railway/cli
```

## Step 2: Deploy Frontend (Vercel)
```bash
cd frontend
vercel login
vercel --prod
```
Save the URL (e.g., `https://your-app.vercel.app`)

## Step 3: Deploy Backend (Railway)
```bash
cd ../backend

# Login to Railway
railway login

# Initialize Railway
railway init

# Create railway.toml with this content:
echo '[build]
command = "pip install fastapi uvicorn groq python-jose passlib python-multipart sqlalchemy psycopg2-binary python-dotenv uuid"

[deploy]
startCommand = "uvicorn app.main:app --host 0.0.0.0 --port 8000"

[env]
GROQ_API_KEY = ""
SECRET_KEY = ""' > railway.toml

# Deploy
railway up
```

## Step 4: Set Environment Variables

### Railway Dashboard
1. Go to your Railway project
2. Settings > Variables
3. Add:
   - `GROQ_API_KEY`: Your actual Groq API key
   - `SECRET_KEY`: Generate with `openssl rand -base64 32`
   - `CORS_ORIGINS`: `["https://your-app.vercel.app"]`

### Vercel Dashboard
1. Go to your Vercel project
2. Settings > Environment Variables
3. Add:
   - `VITE_API_URL`: Your Railway URL

## Step 5: Update vercel.json
```json
{
  "version": 2,
  "builds": [
    {
      "src": "frontend/package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ],
  "env": {
    "VITE_API_URL": "https://your-railway-app.railway.app"
  }
}
```

## Step 6: Redeploy Vercel
```bash
cd frontend
vercel --prod
```

## What Works Now
- ✅ Frontend (React app)
- ✅ Backend API (without PDF upload)
- ✅ Authentication
- ✅ Literature review generation
- ❌ PDF upload (requires PyMuPDF fix)

## Fixing PyMuPDF Later
When PyMuPDF installation is fixed, add it to Railway's requirements:
```bash
# In railway.toml, update the build command:
[build]
command = "pip install fastapi uvicorn groq python-jose passlib python-multipart sqlalchemy psycopg2-binary python-dotenv uuid PyMuPDF"
```

## Testing
- Frontend: Your Vercel URL
- Backend API: Railway URL + `/docs`
- Login: `test@gmail.com` / `test123`

## For Website Deployment
Use the same steps but go to vercel.com and railway.app instead of using CLI tools.