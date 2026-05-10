# 🚀 KRR Project - Complete Deployment Guide

## Table of Contents
1. [Local Development Setup](#local-development-setup)
2. [Website Deployment (Vercel + Railway)](#website-deployment-vercel-railway)
3. [Troubleshooting](#troubleshooting)
4. [Post-Deployment](#post-deployment)

---

## Local Development Setup

### Prerequisites
- Node.js 18+ 
- Python 3.10+
- Git
- Groq API Key (get from [Groq Console](https://console.groq.com/))

### Step 1: Clone & Navigate
```bash
git clone <your-repo-url>
cd KRR_project
```

### Step 2: Install Dependencies

#### Frontend Dependencies
```bash
cd frontend
npm install
cd ..
```

#### Backend Dependencies
```bash
# Create virtual environment
python3 -m venv backend/venv
source backend/venv/bin/activate

# Install Python packages
pip install -r requirements.txt
```

### Step 3: Configure Environment
```bash
# Copy environment template
cp .env.example .env

# Edit .env and add your GROQ_API_KEY
nano .env
```

Add this to your .env file:
```env
GROQ_API_KEY=your_actual_groq_api_key_here
SECRET_KEY=your_secret_key_here
```

### Step 4: Start Locally
```bash
# Use the start script
./start.sh
```

Access:
- Frontend: http://localhost:5173
- Backend API: http://localhost:8000/docs

---

## Website Deployment (Vercel + Railway)

### Option 1: Automated Deployment (Recommended)

```bash
# Run the automated deployment script
./deploy.sh
```

### Option 2: Manual Deployment

#### Step 1: Install CLI Tools
```bash
# Install Vercel CLI
npm install -g vercel

# Install Railway CLI
npm install -g @railway/cli
```

#### Step 2: Login to Services
```bash
# Login to Vercel
vercel login

# Login to Railway  
railway login
```

#### Step 3: Deploy Frontend to Vercel

```bash
cd frontend
vercel --prod
```

After deployment, Vercel will give you a URL like:
`https://your-app-name.vercel.app`

#### Step 4: Deploy Backend to Railway

```bash
cd ../backend

# Initialize Railway (first time only)
railway init

# Deploy the backend
railway up
```

After deployment, Railway will give you a URL like:
`https://your-app.railway.app`

#### Step 5: Set Environment Variables

**In Railway Dashboard:**
1. Go to your Railway project
2. Settings > Variables
3. Add these variables:
   - `GROQ_API_KEY`: Your actual Groq API key
   - `SECRET_KEY`: Generate with `openssl rand -base64 32`
   - `CORS_ORIGINS`: Add your Vercel URL (e.g., `["https://your-app.vercel.app"]`)

**In Vercel Dashboard:**
1. Go to your Vercel project
2. Settings > Environment Variables
3. Add:
   - `VITE_API_URL`: Your Railway backend URL

#### Step 6: Update Configuration

Update `vercel.json` in the project root:
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
    "VITE_API_URL": "https://your-actual-railway-app.railway.app"
  }
}
```

Redeploy Vercel:
```bash
cd frontend
vercel --prod
```

#### Step 7: Test Your Application

- **Frontend**: Your Vercel URL
- **Backend API**: Railway URL + `/docs`
- **Login**: `test@gmail.com` / `test123`

---

## Website Deployment Through Web Interface

### Deploying to Vercel (Web Interface)

1. **Go to [vercel.com](https://vercel.com)**
2. **Sign up/Login** with your account
3. **New Project** > **Import Git Repository**
4. **Select your KRR repository**
5. **Configure Settings**:
   - Framework Preset: **Other**
   - Build Command: `npm run build` (or empty)
   - Output Directory: `dist`
   - Install Command: `npm install`
6. **Environment Variables**:
   - Add `VITE_API_URL` with your Railway URL
7. **Deploy** button

### Deploying to Railway (Web Interface)

1. **Go to [railway.app](https://railway.app)**
2. **Sign up/Login** with your account
3. **New Project** > **Deploy from GitHub Repository**
4. **Select your KRR repository**
5. **Configure Service**:
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `uvicorn app.main:app --host 0.0.0.0 --port 8000`
6. **Environment Variables**:
   - Add `GROQ_API_KEY`, `SECRET_KEY`, `CORS_ORIGINS`
7. **Deploy** button

---

## Troubleshooting

### Common Issues

#### Frontend Issues
- **Module not found**: Run `npm install` in frontend directory
- **CORS errors**: Ensure `CORS_ORIGINS` includes your Vercel URL in Railway
- **Build errors**: Check package.json and dependencies

#### Backend Issues
- **Import errors**: Ensure all Python packages are installed
- **Database errors**: Railway auto-provisions PostgreSQL, but wait 2-3 minutes after deployment
- **API key errors**: Verify `GROQ_API_KEY` is correct

### Useful Commands

```bash
# Check if ports are in use
lsof -i :8000  # Backend
lsof -i :5173  # Frontend

# Kill processes
pkill -f uvicorn
pkill -f vite

# View logs
tail -f logs/backend.log
tail -f logs/frontend.log

# Test API endpoint
curl http://localhost:8000/health
```

---

## Post-Deployment

### 1. Configure Custom Domain (Optional)
- In Vercel: Settings > Domains
- In Railway: Settings > Domains

### 2. Set Up Analytics (Optional)
- Add Vercel Analytics to Vercel project
- Use Railway's built-in metrics

### 3. Backup Strategy
- Railway automatically backs up PostgreSQL
- Consider adding a CI/CD pipeline for automated deployments

### 4. Scaling
- Vercel: Upgrade to Pro plan for more bandwidth
- Railway: Upgrade for more compute hours

---

## Success Checklist

- [ ] Frontend loads without errors
- [ ] API docs are accessible at Railway URL + `/docs`
- [ ] Login works with `test@gmail.com` / `test123`
- [ ] PDF upload works
- [ ] Review generation works
- [ ] Comparison feature works

## Support

If you encounter issues:
1. Check the logs in Vercel/Railway dashboards
2. Verify environment variables are set correctly
3. Ensure API keys are valid
4. Test endpoints individually

Happy deploying! 🎉