"use client";

import { useEffect, useState } from "react";
import axios from "axios";
import { useRouter } from "next/navigation";
import Link from "next/link";

const API = process.env.NEXT_PUBLIC_API_URL || "http://127.0.0.1:8000";

const CLASS_LABELS = {
  GEN:  { label: "General",        icon: "🪑" },
  SL:   { label: "Sleeper",        icon: "🛏️" },
  "3A": { label: "AC 3 Tier",      icon: "❄️" },
  "2A": { label: "AC 2 Tier",      icon: "❄️❄️" },
  "1A": { label: "AC First Class", icon: "👑" },
};

const formatDate = (dateStr, withTime = false) => {
  if (!dateStr) return "";
  const date = new Date(withTime ? dateStr : dateStr + "T00:00:00");
  return date.toLocaleDateString("en-IN", { day: "numeric", month: "short", year: "numeric" });
};

export default function MyBookings() {
  const [bookings, setBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [totalSeats, setTotalSeats] = useState(0);
  const router = useRouter();

  useEffect(() => {
    if (!localStorage.getItem("access")) {
      router.push("/login");
      return;
    }
    fetchBookings();
  }, []);

  const fetchBookings = async () => {
    setLoading(true);
    try {
      const token = localStorage.getItem("access");
      const response = await axios.get(`${API}/api/bookings/my/`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const data = response.data;
      setBookings(data);
      setTotalSeats(data.reduce((sum, b) => sum + b.seats_booked, 0));
    } catch (err) {
      if (err.response?.status === 401) {
        router.push("/login");
      } else {
        setError("Failed to load bookings. Please try again.");
      }
    } finally {
      setLoading(false);
    }
  };

  const uniqueTrains = new Set(bookings.map((b) => b.train.id)).size;

  return (
    <div>
      <div className="page-header animate-in">
        <h1 className="page-title">My <span>Bookings</span></h1>
        <p className="page-subtitle">Your travel history and upcoming journeys</p>
      </div>

      {/* Stats */}
      {!loading && bookings.length > 0 && (
        <div className="stats-grid animate-in delay-1">
          <div className="stat-card">
            <span className="stat-label">Total Trains</span>
            <span className="stat-value orange">{uniqueTrains}</span>
          </div>
          <div className="stat-card">
            <span className="stat-label">Total Seats</span>
            <span className="stat-value">{totalSeats}</span>
          </div>
          <div className="stat-card">
            <span className="stat-label">Total Bookings</span>
            <span className="stat-value">{bookings.length}</span>
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
          <p className="loading-text">Loading your bookings…</p>
        </div>
      )}

      {!loading && bookings.length === 0 && (
        <div className="empty-state animate-in">
          <div className="empty-icon">🎫</div>
          <p className="empty-title">No bookings yet</p>
          <p className="empty-desc">Search for trains and book your first journey.</p>
          <Link href="/search" className="btn-primary"
            style={{ marginTop: "0.5rem", display: "inline-block", textDecoration: "none", padding: "0.65rem 1.5rem" }}>
            Search Trains →
          </Link>
        </div>
      )}

      {!loading && bookings.length > 0 && (
        <div style={{ display: "flex", flexDirection: "column", gap: "1rem" }}>
          {bookings.map((booking, i) => {
            const cls = booking.train_class;
            const clsInfo = cls ? CLASS_LABELS[cls.class_type] : null;

            return (
              <div key={booking.id} className={`card animate-in delay-${Math.min(i + 1, 5)}`}>
                <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", flexWrap: "wrap", gap: "1rem" }}>

                  {/* Left — train info */}
                  <div style={{ display: "flex", alignItems: "center", gap: "1rem" }}>
                    <div style={{
                      width: "48px", height: "48px",
                      background: "rgba(255,107,43,0.12)",
                      border: "1px solid rgba(255,107,43,0.2)",
                      borderRadius: "12px", display: "flex",
                      alignItems: "center", justifyContent: "center",
                      fontSize: "1.4rem", flexShrink: 0,
                    }}>
                      🚆
                    </div>
                    <div>
                      <div className="card-title">{booking.train.name}</div>
                      <div className="card-meta" style={{ marginTop: "0.3rem" }}>
                        <span>{booking.train.source}</span>
                        <span className="route-arrow">→</span>
                        <span>{booking.train.destination}</span>
                      </div>

                      {/* Badges row */}
                      <div style={{ display: "flex", gap: "0.5rem", marginTop: "0.5rem", flexWrap: "wrap" }}>

                        {/* Class badge */}
                        {clsInfo && (
                          <span style={{
                            fontSize: "0.75rem", color: "#ff8c55",
                            background: "rgba(255,107,43,0.1)",
                            border: "1px solid rgba(255,107,43,0.2)",
                            borderRadius: "6px", padding: "0.2rem 0.6rem",
                            fontWeight: 600,
                          }}>
                            {clsInfo.icon} {clsInfo.label}
                          </span>
                        )}

                        {/* Price badge */}
                        {cls && (
                          <span style={{
                            fontSize: "0.75rem", color: "#86efac",
                            background: "rgba(34,197,94,0.08)",
                            border: "1px solid rgba(34,197,94,0.2)",
                            borderRadius: "6px", padding: "0.2rem 0.6rem",
                            fontWeight: 600,
                          }}>
                            ₹{cls.price}
                          </span>
                        )}

                        {/* Travel date badge */}
                        {booking.travel_date && (
                          <span style={{
                            fontSize: "0.75rem", color: "#a78bfa",
                            background: "rgba(167,139,250,0.08)",
                            border: "1px solid rgba(167,139,250,0.2)",
                            borderRadius: "6px", padding: "0.2rem 0.6rem",
                            fontWeight: 600,
                          }}>
                            🚆 Travel: {formatDate(booking.travel_date)}
                          </span>
                        )}

                        {/* Booked on date */}
                        <span style={{ fontSize: "0.75rem", color: "#6b7a94" }}>
                          🗓️ Booked: {formatDate(booking.booked_at, true)}
                        </span>

                      </div>
                    </div>
                  </div>

                  {/* Right — badges */}
                  <div style={{ display: "flex", gap: "0.75rem", alignItems: "center" }}>
                    <span className="badge badge-blue">
                      {booking.seats_booked} seat{booking.seats_booked !== 1 ? "s" : ""} booked
                    </span>
                    <span className="badge badge-green">Confirmed</span>
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