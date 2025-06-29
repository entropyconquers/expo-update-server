#!/usr/bin/env node

const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

console.log("🚀 Building frontend...");

const frontendDir = path.join(__dirname, "..", "frontend");

try {
  // Change to frontend directory
  process.chdir(frontendDir);

  // Check if node_modules exists, if not install dependencies
  if (!fs.existsSync("node_modules")) {
    console.log("📦 Installing frontend dependencies...");
    execSync("npm install", { stdio: "inherit" });
  }

  // Build the frontend
  console.log("🔨 Building frontend...");
  execSync("npm run build", { stdio: "inherit" });

  console.log("✅ Frontend build completed successfully!");
  console.log(`📁 Static files are in: ${path.join(frontendDir, "dist")}`);
} catch (error) {
  console.error("❌ Frontend build failed:", error.message);
  process.exit(1);
}
