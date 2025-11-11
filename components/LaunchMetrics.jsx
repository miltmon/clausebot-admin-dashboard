// components/LaunchMetrics.jsx
import React from "react";

export default function LaunchMetrics({ 
  date = "Nov 10, 2025", 
  smokeTests = "10/10", 
  avgLatency = "536ms", 
  pilotSeats = 25,
  activeUsers = 0,
  apiCalls = 0 
}) {
  return (
    <section 
      className="launch-metrics" 
      style={{ 
        padding: 16, 
        borderRadius: 8, 
        background: "#f6fffb", 
        border: "1px solid #e6f4ea", 
        marginTop: 12 
      }}
    >
      <h3 style={{ margin: 0, fontSize: 18, color: "#137333" }}>
        🚀 Launch Day — {date} ✅
      </h3>
      <div style={{ marginTop: 12, display: "grid", gridTemplateColumns: "1fr 1fr", gap: 8 }}>
        <div>
          <span style={{ color: "#5f6368" }}>Smoke tests:</span>{" "}
          <strong style={{ color: "#137333" }}>{smokeTests}</strong>
        </div>
        <div>
          <span style={{ color: "#5f6368" }}>Avg latency:</span>{" "}
          <strong style={{ color: "#137333" }}>{avgLatency}</strong>
        </div>
        <div>
          <span style={{ color: "#5f6368" }}>Pilot seats:</span>{" "}
          <strong style={{ color: "#137333" }}>{pilotSeats}</strong>
        </div>
        <div>
          <span style={{ color: "#5f6368" }}>Active users:</span>{" "}
          <strong style={{ color: activeUsers > 0 ? "#137333" : "#80868b" }}>
            {activeUsers}
          </strong>
        </div>
        <div style={{ gridColumn: "1 / -1" }}>
          <span style={{ color: "#5f6368" }}>API calls (24h):</span>{" "}
          <strong style={{ color: apiCalls > 0 ? "#137333" : "#80868b" }}>
            {apiCalls.toLocaleString()}
          </strong>
        </div>
      </div>
    </section>
  );
}

