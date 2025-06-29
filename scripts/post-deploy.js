#!/usr/bin/env node

/**
 * Post-deployment script for Deploy to Cloudflare
 * This runs database migrations after resources are provisioned
 */

const { execSync } = require("child_process");

console.log("🔄 Running post-deployment setup...");

try {
  // Run database migrations on the remote production database
  console.log("📊 Running database migrations...");
  execSync("npx wrangler d1 migrations apply expo-update-server --remote", {
    stdio: "inherit",
  });

  console.log("✅ Post-deployment setup completed successfully!");
  console.log("");
  console.log("🎉 Your Expo Updates Server is ready!");
  console.log("");
  console.log("📝 Next steps:");
  console.log("1. Visit your Worker URL to access the dashboard");
  console.log("2. Register your first app");
  console.log("3. (Optional) Set up code signing certificates");
  console.log("4. Start uploading Expo updates!");
  console.log("");
  console.log("🔒 Optional: Set up authentication keys:");
  console.log("   npx wrangler secret put UPLOAD_SECRET_KEY");
  console.log("   npx wrangler secret put CODE_SIGNING_PRIVATE_KEY");
} catch (error) {
  console.error("❌ Post-deployment setup failed:", error.message);
  console.log("");
  console.log("💡 You can run migrations manually:");
  console.log(
    "   npx wrangler d1 migrations apply expo-update-server --remote"
  );
  process.exit(1);
}
