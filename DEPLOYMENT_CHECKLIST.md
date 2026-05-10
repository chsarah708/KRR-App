# Deployment Checklist - KRR App on Render

## Before Deployment ☑

### Repository Setup
- [ ] Code pushed to GitHub repository
- [ ] `.gitignore` updated to exclude sensitive files
- [ ] `render.yaml` in root directory
- [ ] `build.sh` is executable (`chmod +x build.sh`)

### Environment Variables
- [ ] Create `.env.production` with all required variables
- [ ] Get Groq API key from https://console.groq.com/keys
- [ ] Generate SECRET_KEY: `python -c "import secrets; print(secrets.token_urlsafe(32))"`

### Build Testing
- [ ] Run `python test_build.py` (if created)
- [ ] Test frontend build: `npm run build`
- [ ] Verify all imports work correctly

## During Deployment ☑

### 1. Backend Service
- [ ] **Runtime**: Python
- [ ] **Build Command**: `./build.sh`
- [ ] **Start Command**: `gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:$PORT`
- [ ] **Environment Variables**:
  ```
  ENVIRONMENT=production
  GROQ_API_KEY=your_key_here
  ```

### 2. Database Service
- [ ] **Type**: PostgreSQL (Private Service)
- [ ] **Name**: krr-db
- [ ] **Plan**: Free or Starter
- [ ] Note the connection string

### 3. Redis Service
- [ ] **Type**: Redis (Private Service)
- [ ] **Name**: krr-redis
- [ ] **Plan**: Free

### 4. Frontend Service
- [ ] **Runtime**: Node
- [ ] **Build Command**: `npm install && npm run build`
- [ ] **Start Command**: `npm run preview`
- [ ] **Environment Variables**:
  ```
  NODE_ENV=production
  VITE_API_URL=https://krr-backend.onrender.com
  ```

## After Deployment ☑

### Service Connections
- [ ] Update backend with DATABASE_URL from PostgreSQL service
- [ ] Update backend with REDIS_URL from Redis service
- [ ] Update backend CORS_ORIGINS with frontend URL
- [ ] Verify all services are running

### Testing
- [ ] Access frontend URL
- [ ] Login with admin credentials:
  - Email: `admin@krr.com`
  - Password: `admin123`
- [ ] Upload a test PDF
- [ ] Test comparison feature
- [ ] Test literature review generation

## Monitoring
- [ ] Check service logs in Render dashboard
- [ ] Monitor for any build errors
- [ ] Verify database connections
- [ ] Check Redis connections

## Common Issues
- [ ] Build fails → Check Python dependencies
- [ ] Import error → Verify relative imports
- [ ] CORS error → Update CORS_ORIGINS
- [ ] Database error → Verify connection string

## Post-Deployment Optimizations
- [ ] Consider upgrading to paid plans for better performance
- [ ] Set up custom domain
- [ ] Configure SSL certificates
- [ ] Set up monitoring and alerts
- [ ] Regular backups of database

---

✅ All checklist items completed? Your app is ready!