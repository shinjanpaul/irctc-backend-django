"use client";

import { useEffect, useState } from "react";
import axios from "axios";
import { useRouter } from "next/navigation";

const API = process.env.NEXT_PUBLIC_API_URL || "http://127.0.0.1:8000";

export default function Analytics() {
  const [routes, setRoutes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const router = useRouter();

  useEffect(() => {
    if (!localStorage.getItem("access")) {
      router.push("/login");
      return;
    }
    fetchAnalytics();
  }, []);

  const fetchAnalytics = async () => {
    setLoading(true);
    try {
      const token = localStorage.getItem("access");
      const response = await axios.get(`${API}/api/analytics/top-routes/`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      setRoutes(response.data);
    } catch (err) {
      if (err.response?.status === 401) {
        router.push("/login");
      } else {
        setError("Failed to load analytics. Please try again.");
      }
    } finally {
      setLoading(false);
    }
  };

  const maxCount = routes.length > 0 ? Math.max(...routes.map((r) => r.count)) : 1;

  return (
    <div>
      <div className="page-header animate-in">
        <h1 className="page-title">Route <span>Analytics</span></h1>
        <p className="page-subtitle">Most searched train routes on the platform</p>
      </div>

      {/* Stats */}
      {!loading && routes.length > 0 && (
        <div className="stats-grid animate-in delay-1">
          <div className="stat-card">
            <span className="stat-label">Top Routes</span>
            <span className="stat-value orange">{routes.length}</span>
          </div>
          <div className="stat-card">
            <span className="stat-label">Total Searches</span>
            <span className="stat-value">{routes.reduce((acc, r) => acc + r.count, 0)}</span>
          </div>
          <div className="stat-card">
            <span className="stat-label">Most Popular</span>
            <span className="stat-value" style={{ fontSize: "1rem", marginTop: "0.25rem", color: "var(--orange-400)" }}>
              {routes[0] ? `${routes[0].source} → ${routes[0].destination}` : "—"}
            </span>
          </div>
        </div>
      )}

      {error && (
        <div className="alert alert-error animate-in">
          <span>⚠️</span> {error}
        </div>
      )}

      {loading && (
        <div className="loading-container">
          <div className="spinner" />
          <p className="loading-text">Loading analytics…</p>
        </div>
      )}

      {!loading && routes.length === 0 && (
        <div className="empty-state animate-in">
          <div className="empty-icon">📊</div>
          <p className="empty-title">No data yet</p>
          <p className="empty-desc">Route analytics will appear once users start searching for trains.</p>
        </div>
      )}

      {!loading && routes.length > 0 && (
        <div style={{ display: "flex", flexDirection: "column", gap: "0.85rem" }}>
          {routes.map((route, index) => {
            const pct = Math.round((route.count / maxCount) * 100);
            const rankClass = index === 0 ? "rank-1" : index === 1 ? "rank-2" : index === 2 ? "rank-3" : "rank-other";

            return (
              <div key={index} className={`card animate-in delay-${Math.min(index + 1, 5)}`}>
                <div style={{ display: "flex", alignItems: "center", gap: "1rem" }}>
                  <div className={`rank-badge ${rankClass}`}>
                    {index + 1}
                  </div>

                  <div style={{ flex: 1, minWidth: 0 }}>
                    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "0.6rem" }}>
                      <div className="card-meta" style={{ fontSize: "1rem", color: "var(--white)", fontWeight: 600 }}>
                        <span>{route.source}</span>
                        <span className="route-arrow">→</span>
                        <span>{route.destination}</span>
                      </div>
                      <span className="badge badge-orange" style={{ flexShrink: 0, marginLeft: "0.5rem" }}>
                        {route.count} search{route.count !== 1 ? "es" : ""}
                      </span>
                    </div>

                    <div className="progress-bar-wrapper">
                      <div className="progress-bar-track">
                        <div
                          className="progress-bar-fill"
                          style={{ width: `${pct}%` }}
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}