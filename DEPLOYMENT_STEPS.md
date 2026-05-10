# 🚀 Complete Deployment Guide: Railway + Vercel

**Status**: Your application is now **production-ready** ✅

This guide walks you through deploying the backend on **Railway** and frontend on **Vercel**.

---

## 📋 Table of Contents
1. [Prerequisites](#prerequisites)
2. [Backend Deployment (Railway)](#backend-deployment-railway)
3. [Frontend Deployment (Vercel)](#frontend-deployment-vercel)
4. [Connecting Backend & Frontend](#connecting-backend--frontend)
5. [Testing Your Deployment](#testing-your-deployment)
6. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Install These Tools
```bash
# Required for all steps
- GitHub account (with your code pushed)
- Railway account (https://railway.app)
- Vercel account (https://vercel.com)

# For generating SECRET_KEY
- Python 3.8+ installed locally
```

### Generate Your SECRET_KEY
**Do this NOW before deployment:**
```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```
Copy the output. You'll need this in Railway environment variables.

### Get Your Groq API Key
1. Visit https://console.groq.com/keys
2. Sign up or log in
3. Create an API key
4. Copy it (you'll need this for Railway)

---

## Backend Deployment (Railway)

### Step 1: Create Railway Project

1. Go to https://railway.app
2. Click **"New Project"**
3. Click **"Deploy from GitHub"**
4. Select your **KRR_project** repository
5. Railway will auto-detect `railway.toml` configuration ✅
6. Click **"Deploy"**

### Step 2: Create PostgreSQL Database

1. In your Railway project, click **"+ New Service"**
2. Select **"Database"** → **"PostgreSQL"**
3. Wait for it to initialize (2-3 minutes)
4. Click on PostgreSQL service
5. Go to **"Variables"** tab
6. Copy the **DATABASE_URL** value (looks like `postgresql://user:password@host:port/database`)

### Step 3: Set Environment Variables in Railway

1. Click on your **FastAPI backend service**
2. Go to **"Variables"** tab
3. Click **"New Variable"** and add these **exactly**:

| Key | Value | Where to Get |
|-----|-------|-------------|
| `GROQ_API_KEY` | `gsk_xxxxx...` | From https://console.groq.com/keys |
| `SECRET_KEY` | Output from python command above | Generated in Prerequisites |
| `DATABASE_URL` | Copied from PostgreSQL service | From PostgreSQL Variables tab |
| `ENVIRONMENT` | `production` | Literal text |

4. After adding all variables, Railway **automatically redeploys**
5. Watch the **Deploy** tab - you'll see logs as it:
   - Installs dependencies
   - Runs database migrations (`alembic upgrade head`)
   - Starts the FastAPI server

### Step 4: Verify Backend Deployment

1. In Railway, click your **FastAPI service**
2. Go to **"Deployments"** tab
3. Look for green checkmark ✅ (means it's running)
4. Copy your **Railway domain** (shown in service header, looks like `https://your-app-name.railway.app`)

**Test your backend:**
```bash
# Replace YOUR_RAILWAY_URL with your actual Railway domain
curl https://YOUR_RAILWAY_URL/api/v1/health

# Should return: {"status": "ok"}
```

**If it doesn't work:**
- Check "Logs" tab in Railway for errors
- See [Troubleshooting](#troubleshooting) section

---

## Frontend Deployment (Vercel)

### Step 1: Push Your Code to GitHub

If you haven't already:
```bash
git add .
git commit -m "Production deployment configuration"
git push origin main
```

### Step 2: Connect to Vercel

1. Go to https://vercel.com
2. Click **"Add New..."** → **"Project"**
3. Select **"Import Git Repository"**
4. Find and select your **KRR_project** repository
5. Click **"Import"**

### Step 3: Configure Environment Variables

1. Vercel shows **"Environment Variables"** form
2. Add this variable:

| Name | Value | What It Is |
|------|-------|-----------|
| `VITE_API_URL` | `https://YOUR_RAILWAY_URL` | Your Railway backend domain from Step 4 above |

**Example:**
```
VITE_API_URL=https://krr-backend-prod.railway.app
```

3. Click **"Deploy"**

### Step 4: Verify Frontend Deployment

1. Vercel shows deployment progress
2. When complete, you get a **Vercel URL** (looks like `https://your-project.vercel.app`)
3. Click it to open your application ✅

---

## Connecting Backend & Frontend

Your frontend now knows where your backend is because of the `VITE_API_URL` environment variable you set in Vercel.

**How it works:**
- Frontend code uses `VITE_API_URL` to make API calls
- All requests go to your Railway backend
- Database operations happen on Railway PostgreSQL

---

## Testing Your Deployment

### Test 1: Frontend Loads
```
Visit: https://your-vercel-app.vercel.app
Expected: You see the login page ✅
```

### Test 2: Authentication Works
```
1. Enter any email on login page
2. Enter any password
3. Click "Login"
4. Expected: You get logged in and see the dashboard ✅
```

### Test 3: API Communication Works
Open browser console (F12) and check:
```
- No CORS errors (red messages about cross-origin)
- Network tab shows API requests to your Railway domain ✅
```

### Test 4: Upload Papers
```
1. Click "Upload PDF"
2. Select a PDF file
3. Click upload
4. Expected: File uploads and processes ✅
```

---

## Troubleshooting

### ❌ Frontend Loads But Can't Connect to Backend

**Symptom:**
- Frontend loads fine
- But login fails or network errors appear

**Solutions:**
1. **Check `VITE_API_URL` in Vercel:**
   - Go to Vercel project settings
   - Check "Environment Variables"
   - Verify `VITE_API_URL` is set correctly
   - Redeploy: Click three dots → **"Redeploy"**

2. **Check Railway backend is running:**
   - Go to Railway project
   - Click FastAPI service
   - Check "Deployments" tab for green ✅
   - Check "Logs" tab for errors

3. **Check CORS configuration:**
   - Railway backend auto-includes your Vercel domain in CORS
   - If issues persist, verify `backend/app/core/config.py` has your Vercel domain

### ❌ Backend Deployment Fails

**Symptom:**
- Railway shows red ❌ in deployments
- Logs show errors

**Common causes:**

**Database migration failed:**
```
Check Railway PostgreSQL is created and DATABASE_URL is set correctly
```

**Missing environment variables:**
```
Verify all 4 required variables are set:
- GROQ_API_KEY
- SECRET_KEY  
- DATABASE_URL
- ENVIRONMENT
```

**Check logs in Railway:**
1. Click FastAPI service
2. Go to "Logs" tab
3. Read bottom (newest logs)
4. Look for error messages

### ❌ Vercel Shows Build Errors

**Symptom:**
- Vercel deployment shows red ❌
- Build failed message

**Solutions:**
1. Check "Deployments" tab in Vercel
2. Click the failed deployment
3. Read the build logs
4. Common issues:
   - Missing npm packages: `npm install` locally and push again
   - Environment variables not set: Add them in Vercel settings

### ❌ Login Page Shows But Can't Login

**Symptom:**
- Frontend loads
- Login button doesn't work

**Check:**
1. Open browser console (F12)
2. Go to "Network" tab
3. Try to login
4. Look for failed API requests
5. Check the request URL matches your Railway domain

---

## Environment Variables Reference

### Railway Backend Requires
```
GROQ_API_KEY     = Your Groq API key from console.groq.com
SECRET_KEY       = Generated with: python -c "import secrets; print(secrets.token_urlsafe(32))"
DATABASE_URL     = PostgreSQL URL from Railway PostgreSQL service
ENVIRONMENT      = "production"
```

### Vercel Frontend Requires
```
VITE_API_URL     = https://YOUR_RAILWAY_DOMAIN (e.g., https://krr-backend.railway.app)
```

---

## ✅ Success Checklist

- [ ] Railway PostgreSQL database is created
- [ ] Railway environment variables are all set (4 variables)
- [ ] Railway FastAPI service is deployed (green ✅)
- [ ] You copied your Railway domain
- [ ] Vercel project is created
- [ ] Vercel `VITE_API_URL` environment variable is set
- [ ] Vercel frontend is deployed (green ✅)
- [ ] You can visit Vercel URL and see login page
- [ ] You can click buttons (no JS errors)
- [ ] You can make an API call from frontend (check Network tab)

---

## Need More Help?

**Check these files for configuration details:**
- Backend config: `backend/app/core/config.py`
- Frontend API client: `frontend/src/api/client.js`
- Railway config: `railway.toml`
- Vercel config: `vercel.json`
- Example env: `.env.example`

**Documentation:**
- Railway Docs: https://docs.railway.app
- Vercel Docs: https://vercel.com/docs
- FastAPI Docs: https://fastapi.tiangolo.com
- Vite Docs: https://vitejs.dev

---

**Your app is production-ready! 🎉**

Follow each step in order. If you get stuck on any step, check the Troubleshooting section above.
