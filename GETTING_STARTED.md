# 🎉 Your Expo Updates Server is Live!

Congratulations! You've successfully deployed your own Expo Updates server on Cloudflare Workers. Here's how to get started:

## 📍 Your Deployment

- **Dashboard**: `https://expo-update-server.your-subdomain.workers.dev`
- **API**: `https://expo-update-server.your-subdomain.workers.dev/api/`
- **Health Check**: `https://expo-update-server.your-subdomain.workers.dev/api/health`

## 🚀 Quick Start

### 1. **Access Your Dashboard**

Visit your Worker URL to see the modern web interface for managing your Expo apps and updates.

### 2. **Register Your First App**

1. Click "Register New App" in the dashboard
2. Enter your app's slug (e.g., `my-expo-app`)
3. Optionally add name, description, and contact email
4. Copy the provided manifest URL for your Expo app

### 3. **Configure Your Expo App**

Update your `app.json` or `app.config.js`:

```json
{
  "expo": {
    "updates": {
      "url": "https://your-worker.workers.dev/manifest?project=my-expo-app&channel=production"
    }
  }
}
```

### 4. **Upload Your First Update**

Use your existing `expo export` workflow or EAS Update with your new server:

```bash
# Export your app
expo export --platform all

# Upload to your server (example with curl)
curl -X POST https://your-worker.workers.dev/api/upload \
  -H "project: my-expo-app" \
  -H "version: 1.0.0" \
  -H "release-channel: production" \
  -F "uri=@dist.zip"
```

### 5. **Release Your Update**

In the dashboard, find your uploaded update and click "Release" to make it available to users.

## 🔐 Optional: Set Up Code Signing

For enhanced security, set up code signing certificates:

1. **Generate a certificate** using the provided script in your repository
2. **Upload via dashboard** or API
3. **Update your Expo config** to reference the certificate

## ⚙️ Advanced Configuration

### Environment Variables / Secrets

Set these in your Cloudflare dashboard or via Wrangler:

```bash
# Optional: Upload authentication key
wrangler secret put UPLOAD_SECRET_KEY

# Optional: Code signing private key
wrangler secret put CODE_SIGNING_PRIVATE_KEY
```

### Custom Domain

Connect a custom domain in your Cloudflare dashboard under "Workers Routes".

## 📚 Learn More

- **Repository**: Your forked repository contains all source code and documentation
- **API Documentation**: Check the README for complete API reference
- **Dashboard Features**: Explore app management, certificate upload, and update tracking

## 🛠️ Development

To develop locally:

```bash
git clone your-forked-repo
cd your-repo
npm install
npm run dev:full-stack
```

This starts both the Worker (port 8787) and frontend (port 3000) for local development.

## 🆘 Need Help?

- Check the repository README for detailed documentation
- Review the API endpoints in your dashboard
- Verify your Expo app configuration
- Test your endpoints at `/api/health`

Happy updating! 🚀
