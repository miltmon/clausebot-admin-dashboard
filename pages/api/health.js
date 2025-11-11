// pages/api/health.js
export default function handler(req, res) {
  const now = new Date().toISOString();
  const health = {
    status: "ok",
    timestamp: now,
    version: process.env.NEXT_PUBLIC_VERSION || "v10",
    uptime: process.uptime ? Math.round(process.uptime()) : null,
    environment: process.env.NODE_ENV || "development"
  };
  
  // No-cache headers for real-time health checks
  res.setHeader("Cache-Control", "no-store, max-age=0");
  return res.status(200).json(health);
}

