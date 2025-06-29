#!/bin/bash

# Expo Updates Server - Quick Setup Script
# This script sets up and deploys the complete full-stack application

set -e

echo "🚀 Expo Updates Server - Quick Setup"
echo "===================================="
echo ""
echo "💡 TIP: For the easiest deployment, use the Deploy to Cloudflare button"
echo "   in the README instead of this manual setup script!"
echo ""

# Check prerequisites
echo "📋 Checking prerequisites..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ from https://nodejs.org"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d 'v' -f 2 | cut -d '.' -f 1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version 18+ is required. Current version: $(node -v)"
    exit 1
fi

echo "✅ Node.js $(node -v) found"

# Check npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed"
    exit 1
fi

echo "✅ npm $(npm -v) found"

# Check wrangler
if ! command -v wrangler &> /dev/null; then
    echo "⚠️  Wrangler CLI not found. Installing..."
    npm install -g wrangler
fi

echo "✅ Wrangler CLI found"

# Check if user is logged into Cloudflare
if ! wrangler whoami &> /dev/null; then
    echo "🔐 Please login to Cloudflare:"
    wrangler login
fi

echo "✅ Cloudflare authentication verified"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Ask for deployment environment
echo ""
echo "🎯 Choose deployment environment:"
echo "1) Production"
echo "2) Staging" 
read -p "Enter choice (1-2) [default: 1]: " CHOICE

case $CHOICE in
    2)
        ENV="staging"
        COMMAND="deploy:staging"
        ;;
    *)
        ENV="production"
        COMMAND="deploy:prod"
        ;;
esac

echo "📡 Deploying to $ENV environment..."

# Deploy
npm run $COMMAND

echo ""
echo "🎉 Deployment completed successfully!"
echo "=================================="

# Get the worker URL
WORKER_URL=$(wrangler subdomain 2>/dev/null || echo "your-worker.workers.dev")

echo "🌐 Your Expo Updates Server is now live:"
echo "   Dashboard: https://$WORKER_URL"
echo "   API: https://$WORKER_URL/api/"
echo "   Health: https://$WORKER_URL/health"
echo ""
echo "📝 Next steps:"
echo "   1. Visit the dashboard to register your first app"
echo "   2. Configure code signing certificates (optional)"
echo "   3. Start uploading your Expo updates!"
echo ""
echo "📚 Documentation:"
echo "   - README.md - Complete project documentation"
echo "   - DEPLOYMENT.md - Detailed deployment guide"
echo "   - frontend/FEATURES.md - Dashboard features"
echo ""
echo "🔧 Useful commands:"
echo "   npm run dev:full-stack  - Local development"
echo "   npm run deploy:prod     - Redeploy to production"
echo "   wrangler tail          - View logs"
echo ""
echo "Happy coding! 🚀" 