# KRR App - Deployment Ready

Your AI Literature Review System is now fully prepared for deployment on Render!

## 🚀 Quick Start

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Ready for Render deployment"
   git push origin main
   ```

2. **Deploy to Render**
   - Go to [https://render.com](https://render.com)
   - Create New Web Service
   - Select your repository
   - Use the configurations from `render.yaml`

## 📁 Deployment Files Created

- `render.yaml` - Complete Render service configuration
- `build.sh` - Build script for backend
- `.env.production` - Production environment template
- `DEPLOYMENT_GUIDE.md` - Detailed deployment guide
- `QUICK_DEPLOY.md` - Quick deployment steps
- `DEPLOYMENT_CHECKLIST.md` - Deployment checklist

## 🔧 Key Features

### Backend (Python + FastAPI)
- Automatic admin creation: `admin@krr.com` / `admin123`
- Gunicorn with Uvicorn workers for production
- PostgreSQL database integration
- Redis for rate limiting
- Health check endpoint: `/health`
- Prometheus metrics: `/metrics`

### Frontend (React 19 + Vite)
- Production build optimized
- Environment-aware API URLs
- Responsive design with Tailwind CSS

## 📋 Required Environment Variables

### Backend
```env
ENVIRONMENT=production
GROQ_API_KEY=your_groq_api_key
SECRET_KEY=generated_secret_key
DATABASE_URL=postgresql://...
REDIS_URL=redis://...
CORS_ORIGINS=["https://your-frontend-url.com"]
```

### Frontend
```env
NODE_ENV=production
VITE_API_URL=https://krr-backend.onrender.com
VITE_API_BASE_URL=https://krr-backend.onrender.com
```

## 🎯 After Deployment

1. Your app will be live at:
   - Frontend: `https://krr-frontend.onrender.com`
   - Backend: `https://krr-backend.onrender.com`

2. Default login:
   - Email: `admin@krr.com`
   - Password: `admin123`

3. Test the workflow:
   - Upload a PDF paper
   - View AI analysis
   - Compare papers
   - Generate literature review

## 🔍 Monitoring

- Check service logs in Render dashboard
- Monitor health at `/health`
- Track metrics at `/metrics` (if Prometheus enabled)

## 💡 Tips

- Free plan services sleep after 15 minutes of inactivity
- First request after sleep may take longer (cold start)
- Consider paid plans for better performance
- Set up custom domain for production

---

**Need help?** Check `DEPLOYMENT_GUIDE.md` for detailed instructions!