# One-Click Deployment Guide

This guide shows how to deploy the complete Expo Updates Server with the frontend dashboard in a single command.

## 🚀 Quick Start (One-Click Deployment)

### Prerequisites

1. **Cloudflare Account**: Sign up at [dash.cloudflare.com](https://dash.cloudflare.com)
2. **Node.js 18+**: Install from [nodejs.org](https://nodejs.org)
3. **Wrangler CLI**: Install and authenticate

```bash
npm install -g wrangler
wrangler login
```

### One-Click Deploy to Production

```bash
# Clone and deploy everything in one command
git clone <your-repo-url>
cd quickpush-x
npm install
npm run deploy:prod
```

This single command will:

- ✅ Create D1 database (`expo-updates-db`)
- ✅ Create R2 bucket (`expo-updates-storage`)
- ✅ Create KV namespace (`CACHE`)
- ✅ Run database migrations
- ✅ Build the TypeScript worker
- ✅ Build the Next.js frontend with correct API URLs
- ✅ Deploy everything as a single Cloudflare Worker
- ✅ Serve both API and dashboard from the same domain

### Environment-Specific Deployments

```bash
# Deploy to staging
npm run deploy:staging

# Deploy to development
npm run deploy:dev

# Deploy to production (same as deploy:prod)
npm run deploy
```

## 🔧 Configuration

### Update Your Domain URLs

Before deploying, update the URLs in `wrangler.toml`:

```toml
[env.production.vars]
PUBLIC_URL = "https://your-custom-domain.com"
FRONTEND_API_URL = "https://your-custom-domain.com"

[env.production]
routes = [
  { pattern = "your-custom-domain.com/*", zone_name = "your-custom-domain.com" }
]
```

### Environment Variables

The frontend automatically uses the correct API paths:

- **Development**: API calls go to `http://localhost:8787/api/*` (worker dev server)
- **Production/Staging**: API calls use relative paths `/api/*` (same domain)

## 📁 Project Structure After Deployment

```
Your Worker serves:
├── /                    → Frontend Dashboard (Next.js)
├── /apps               → App Management UI
├── /settings           → Settings UI
├── /api/*              → API endpoints
├── /upload             → Expo update upload
├── /release/:id        → Release management
├── /manifest           → Expo manifest endpoint
├── /assets             → Static asset serving
└── /health             → Health check
```

## 🛠️ Development Workflow

### Local Development (Full-Stack)

```bash
# Run both worker and frontend simultaneously
npm run dev:full-stack
```

This starts:

- **Worker**: `http://localhost:8787` (API)
- **Frontend**: `http://localhost:3000` (Dashboard)

### Building for Deployment

```bash
# Build frontend (auto-detects environment)
npm run build:frontend

# Build complete full-stack
npm run build:full-stack

# Development (no build needed)
npm run dev:full-stack
```

## 🔄 Update Process

When you make changes:

```bash
# Quick redeploy (production)
npm run deploy:prod

# With specific environment
npm run deploy:staging
```

## 🌐 Access Your Deployment

After deployment, you can access:

- **Dashboard**: `https://your-worker.workers.dev/`
- **API**: `https://your-worker.workers.dev/api/*`
- **Health Check**: `https://your-worker.workers.dev/health`

## 🎯 Key Features

### ✅ **Single Worker Deployment**

- Both frontend and API served from same domain
- No CORS issues
- Simplified deployment and management

### ✅ **Environment-Aware Building**

- Automatic API path detection (relative `/api/*` in production)
- Single build works for all environments
- No manual configuration needed

### ✅ **Global Edge Distribution**

- Static assets served from Cloudflare's global network
- API runs on Cloudflare Workers edge
- Ultra-low latency worldwide

### ✅ **Zero Configuration**

- Database, storage, and cache automatically provisioned
- Environment variables automatically configured
- Ready to use immediately after deployment

## 🔒 Security Setup

After deployment, configure your secrets:

```bash
# Set upload authentication key
wrangler secret put UPLOAD_SECRET_KEY --env production

# Set code signing private key (optional)
wrangler secret put CODE_SIGNING_PRIVATE_KEY --env production
```

## 📊 Monitoring

Check your deployment:

```bash
# View logs
wrangler tail --env production

# Check health
curl https://your-worker.workers.dev/health
```

## 🚨 Troubleshooting

### Build Issues

```bash
# Clean and rebuild
rm -rf frontend/dist frontend/node_modules
npm run build:full-stack
```

### Deployment Issues

```bash
# Check wrangler status
wrangler whoami

# Re-authenticate if needed
wrangler login
```

This deployment approach gives you a production-ready, globally distributed Expo Updates server with a modern web dashboard, all deployed with a single command!
