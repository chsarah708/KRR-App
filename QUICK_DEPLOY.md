# Quick Deployment Guide - KRR App on Render

## 1. Before You Start

- **GitHub Account**: Push your code to GitHub
- **Groq API Key**: Get from [https://console.groq.com/keys](https://console.groq.com/keys)
- **Render Account**: Sign up at [https://render.com](https://render.com)

## 2. Deploy Backend

1. **New Web Service**
   - Connect your GitHub repo
   - **Runtime**: Python
   - **Build Command**: `./build.sh`
   - **Start Command**: `gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:$PORT`

2. **Environment Variables**
   ```
   ENVIRONMENT=production
   GROQ_API_KEY=your_groq_api_key_here
   ```

## 3. Deploy Database

1. **New Private Service**
   - **Service Type**: PostgreSQL
   - **Name**: krr-db
   - **Plan**: Free
   - Leave other settings default

2. **Note the connection string** for next step

## 4. Deploy Redis

1. **New Private Service**
   - **Service Type**: Redis
   - **Name**: krr-redis
   - **Plan**: Free

## 5. Update Backend Environment Variables

Add these to your backend service:
```
DATABASE_URL=postgresql://krr_user:password@krr-db:5432/krr_db
REDIS_URL=redis://:password@krr-redis:6379
CORS_ORIGINS=["https://your-frontend-url.onrender.com"]
```

## 6. Deploy Frontend

1. **New Web Service**
   - **Runtime**: Node
   - **Build Command**: `npm install && npm run build`
   - **Start Command**: `npm run preview`

2. **Environment Variables**
   ```
   NODE_ENV=production
   VITE_API_URL=https://krr-backend.onrender.com
   VITE_API_BASE_URL=https://krr-backend.onrender.com
   ```

## 7. Done!

Your app will be at:
- Frontend: https://krr-frontend.onrender.com
- Backend: https://krr-backend.onrender.com

**Login Credentials**:
- Email: admin@krr.com
- Password: admin123

## Important Notes

- Services may take 2-5 minutes to start
- First upload may be slow (cold start)
- Check logs in Render dashboard if issues arise
- Free plan services sleep after 15 minutes of inactivity