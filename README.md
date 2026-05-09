# KRR - AI Literature Review System

This is a Knowledge Representation & Reasoning application for analyzing academic papers using AI.

## 🚀 Deployment Ready

This application is now ready for deployment:
- Backend: FastAPI with PostgreSQL and Redis support
- Frontend: React/Vite with Tailwind CSS
- Deployment targets: Railway (backend), Vercel (frontend)

## 📦 Deployment Requirements

### Backend (Railway)
- Python 3.11+
- PostgreSQL database
- Redis for rate limiting
- Groq API key for AI functionality

### Frontend (Vercel)
- Node.js 18+
- Modern browser support

## 🔧 Deployment Process

### 1. Environment Setup

Copy environment files:
```bash
cp .env.example .env
cp .env.railway.example .env.railway
```

Edit these files with your actual secrets:

### 2. Deploy to Railway (Backend)

```bash
# Navigate to backend directory
cd backend  
railway up
```

### 3. Deploy to Vercel (Frontend)

```bash
# Navigate to frontend directory
cd frontend
vercel --prod
```

### 4. Automated Deployment

You can use the included deployment script:
```bash
./deploy.sh
```

## 🛠️ Build Process

For production builds:
```bash
./build.sh
```

## 📁 Repository Structure

```
/
├── backend/        # FastAPI backend
│   ├── app/        # Application code
│   ├── tests/      # Test suite
│   └── requirements.txt  # Dependencies
├── frontend/       # React frontend
│   ├── src/        # Source code
│   └── package.json  # Frontend dependencies
├── deploy.sh       # Deployment script
├── build.sh        # Build script
├── railway.toml    # Railway configuration
└── vercel.json     # Vercel configuration
```

## 🛡️ Security Considerations

### Environment Variables
- Never commit secrets to the repository
- Use `.env` for local development
- Use platform-specific environment variables for production deployments

### Production Best Practices
- Use strong secrets for JWT tokens
- Enable HTTPS in production
- Configure CORS properly for your deployment
- Monitor API usage with rate limiting

## 🎯 Usage

1. Start the application locally with:
```bash
./start.sh
```

2. Visit `http://localhost:5173` for the frontend
3. Backend API is available at `http://localhost:8000`

4. API Documentation is at `http://localhost:8000/docs`

## 🆘 Troubleshooting

### Common Issues

**CORS Errors**: Make sure `CORS_ORIGINS` includes your frontend URL.

**Database Connection**: Verify DATABASE_URL is properly configured in Railway.

**Missing Secrets**: Ensure `.env` has all required environment variables.

### Debugging

Check logs:
```bash
tail -f logs/*.log
```

## 📄 License

MIT License - see LICENSE for details.

## 👥 Contributing

Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.
