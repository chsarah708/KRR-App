# Deployment Checklist ✅

## Before You Start

### ☑️ Prerequisites
- [ ] Node.js 18+ installed
- [ ] Python 3.10+ installed
- [ ] Git repository initialized
- [ ] Groq API key ready

### ☑️ CLI Tools
- [ ] Vercel CLI: `npm install -g vercel`
- [ ] Railway CLI: `npm install -g @railway/cli`

### ☑️ Project Files
- [ ] Frontend dependencies installed (`cd frontend && npm install`)
- [ ] Backend dependencies installed (`cd backend && pip install -r requirements.txt`)

## Deployment Steps

### Step 1: Frontend to Vercel
- [ ] Run `vercel login`
- [ ] Run `cd frontend && vercel --prod`
- [ ] Copy the Vercel URL (e.g., `https://your-app.vercel.app`)
- [ ] Update `vercel.json` with your Vercel URL
- [ ] Run `vercel --prod` again

### Step 2: Backend to Railway
- [ ] Run `railway login`
- [ ] Run `railway init`
- [ ] Run `railway up`
- [ ] Copy the Railway URL (e.g., `https://your-app.railway.app`)

### Step 3: Environment Variables
- [ ] In Railway dashboard, set:
  - `GROQ_API_KEY`: Your actual Groq API key
  - `SECRET_KEY`: Generate with `openssl rand -base64 32`
  - `CORS_ORIGINS`: Add your Vercel URL
- [ ] In Vercel dashboard, set:
  - `VITE_API_URL`: Your Railway URL

### Step 4: Final Testing
- [ ] Access frontend at your Vercel URL
- [ ] Access API docs at Railway URL + `/docs`
- [ ] Test login with `test@gmail.com` / `test123`
- [ ] Upload a PDF to test the full flow

## Common Issues & Fixes

### Issue: Frontend won't build
- Fix: Run `npm install` in frontend directory

### Issue: Backend import error
- Fix: Ensure all requirements are installed

### Issue: CORS errors
- Fix: Add Vercel URL to `CORS_ORIGINS` in Railway

### Issue: Database connection fails
- Fix: Railway should auto-provision PostgreSQL

## Success Indicators

- [ ] Frontend loads without errors
- [ ] API docs are accessible
- [ ] Login works
- [ ] File upload works
- [ ] Review generation works