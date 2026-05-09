# Deploying KRR Application on Render

## 🚀 Complete Render Deployment Guide

Render is a great hosting platform that supports both frontend and backend applications. Here's how to deploy your KRR application:

## 📁 Prerequisites

Make sure you have:
- A Render account
- Git repository with your code 
- Environment variables set up

## 🛠️ Backend Deployment (Python/FastAPI)

### 1. Prepare Backend for Render

First, you'll need to update your backend configuration:

**Update `backend/app/core/config.py`:**
```python
from pydantic_settings import BaseSettings
import os

class Settings(BaseSettings):
    # ... existing settings ...
    
    # Render-specific settings
    DATABASE_URL: str = os.getenv("DATABASE_URL", "postgresql://user:password@localhost:5432/krr_db")
    
    class Config:
        env_file = ".env"
```

### 2. Create Render Configuration Files

**Create `render.yaml` in project root:**
```yaml
services:
  - type: web
    name: krr-backend
    env: python
    buildCommand: pip install -r requirements.txt
    startCommand: uvicorn app.main:app --host 0.0.0.0 --port $PORT
    envVars:
      - key: DATABASE_URL
        sync: false
      - key: GROQ_API_KEY
        sync: false
      - key: SECRET_KEY
        sync: false
    autoDeploy: true

  - type: web
    name: krr-frontend
    env: static
    buildCommand: cd frontend && npm install && npm run build
    startCommand: serve -s dist
    envVars:
      - key: VITE_API_URL
        value: https://your-backend-url.onrender.com
    autoDeploy: true
```

## 🛠️ Alternative: Manual Render Setup

### Backend Setup Steps:
1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click "New" → "Web Service"
3. Connect your GitHub repository
4. Set build settings:
   - Build Command: `pip install -r requirements.txt`  
   - Start Command: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
   - Runtime: Python 3.11+
5. Add Environment Variables in the "Environment" section:
   - `DATABASE_URL` (provided by Render PostgreSQL service)
   - `GROQ_API_KEY` (your Groq API key)
   - `SECRET_KEY` (generate secure secret)

### Database Setup (PostgreSQL):
1. Click "New" → "Database"
2. Choose "PostgreSQL"
3. Select "Development" tier (free)
4. Add the provided DATABASE_URL to your ENV VARs

### Frontend Setup:
1. Go to "New" → "Web Service"
2. Choose your repository
3. Set build settings:
   - Build Command: `cd frontend && npm install && npm run build`
   - Start Command: `serve -s dist`
   - Runtime: Static Site 

## ⚙️ Environment Variables Needed

### For Backend:
```
DATABASE_URL=postgresql://user:password@host:port/database  
GROQ_API_KEY=your_groq_api_key_here
SECRET_KEY=your_very_secure_secret_key_here
```

### For Frontend (in Vite config):
```
VITE_API_URL=https://your-backend-url.onrender.com
```

## 🔧 Specific Render Settings

### Backend Service Settings:
- **Runtime**: Python 3.11
- **Build Command**: `pip install -r requirements.txt`
- **Start Command**: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
- **Region**: Choose closest to your users (US East/West)

### PostgreSQL Database Settings:
- **Plan**: Free tier (Development)
- **Username**: krr_user 
- **Database Name**: krr_db
- **Password**: krr_pass (securely set in Render)

## 🚨 Important Notes

1. **Environment Variables**: 
   - Set all required ENV vars in Render dashboard
   - Never commit secrets to your repository

2. **Database Connection**:
   - Use Render's PostgreSQL instance
   - Update DATABASE_URL in your settings

3. **Port Configuration**:
   - Use `$PORT` environment variable instead of hardcoded port

4. **Build Optimization**:
   - Set `NODE_ENV=production` for frontend builds

5. **Health Checks**:
   - Render will automatically check `/health` endpoint for backend

## ✅ Verification Steps

1. **After deployment**:
   - Check backend logs in Render dashboard
   - Test API endpoints at `https://your-backend-url.onrender.com/docs`
   - Verify frontend loads properly at `https://your-frontend-url.onrender.com`

2. **Debugging**:
   - View logs in Render console
   - Check environment variables
   - Verify database connectivity

## 🔄 Updating After Changes

1. Push to your git repository
2. Render will automatically detect changes
3. Manual deployment available: 
   - Go to service in Render dashboard
   - Click "Deploy" to redeploy

## 📊 Monitoring

Render provides:
- Automatic scaling
- Health monitoring
- Logs viewer
- Performance metrics
- SSL certificates (automatic for custom domains)