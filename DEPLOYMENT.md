# KRR Project Deployment Guide

This guide explains how to deploy the KRR (Knowledge Representation & Reasoning) project on Vercel (frontend) and Railway (backend).

## Prerequisites

1. **Node.js 18+**
2. **Python 3.10+**
3. **Vercel CLI**: `npm install -g vercel`
4. **Railway CLI**: `npm install -g @railway/cli`
5. **Groq API Key**: Get from [Groq Console](https://console.groq.com/)

## Quick Deployment

### Option 1: Using Deploy Script (Recommended)

```bash
# Run the automated deployment script
./deploy.sh
```

### Option 2: Manual Deployment

#### Frontend (Vercel)

1. **Install Vercel CLI**:
   ```bash
   npm install -g vercel
   vercel login
   ```

2. **Deploy Frontend**:
   ```bash
   cd frontend
   vercel --prod
   ```

3. **Note the URL** (e.g., `https://your-app.vercel.app`)

#### Backend (Railway)

1. **Install Railway CLI**:
   ```bash
   npm install -g @railway/cli
   railway login
   ```

2. **Initialize Railway**:
   ```bash
   railway init
   ```

3. **Deploy Backend**:
   ```bash
   railway up
   ```

## Environment Variables

### Vercel (Frontend)

Set these in Vercel dashboard:
- `VITE_API_URL`: Your Railway backend URL

### Railway (Backend)

Set these in Railway dashboard:
1. `GROQ_API_KEY`: Your Groq API key
2. `SECRET_KEY`: Generate with `openssl rand -base64 32`
3. `DATABASE_URL`: Railway will provide this automatically
4. `CORS_ORIGINS`: Add your Vercel URL (e.g., `["https://your-app.vercel.app"]`)

## Post-Deployment Steps

1. **Update Vercel**:
   - Edit `vercel.json` and replace `your-railway-app` with your actual Railway URL
   - Run `vercel --prod` again

2. **Test the Application**:
   - Frontend: Your Vercel URL
   - Backend API: Railway URL + `/docs`

3. **Login Credentials**:
   - Email: `test@gmail.com`
   - Password: `test123`

## Troubleshooting

### Frontend Issues
- "Module not found": Run `npm install` in frontend directory
- CORS errors: Ensure `CORS_ORIGINS` is set in Railway

### Backend Issues
- Database errors: Railway should automatically provision PostgreSQL
- Import errors: Ensure all requirements are installed
- API key errors: Verify `GROQ_API_KEY` is set correctly

### Common Commands

```bash
# Check running processes
lsof -i :8000  # Backend
lsof -i :5173  # Frontend

# Kill processes
pkill -f uvicorn
pkill -f vite

# View logs
tail -f logs/backend.log
tail -f logs/frontend.log
```

## Free Tier Limits

- **Vercel**: 100GB bandwidth, 10 projects
- **Railway**: 500 hours/month, 1GB RAM

Both platforms should be sufficient for development and small-scale production use.