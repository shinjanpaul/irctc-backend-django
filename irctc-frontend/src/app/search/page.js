"use client";
import PaymentQR from "@/components/PaymentQR";
import { useState, useEffect } from "react";
import axios from "axios";
import { useRouter } from "next/navigation";

const API = process.env.NEXT_PUBLIC_API_URL || "http://127.0.0.1:8000";

const CLASS_LABELS = {
  GEN: { label: "General", icon: "🪑" },
  SL:  { label: "Sleeper", icon: "🛏️" },
  "3A": { label: "AC 3 Tier", icon: "❄️" },
  "2A": { label: "AC 2 Tier", icon: "❄️❄️" },
  "1A": { label: "AC First", icon: "👑" },
};

const today = new Date().toISOString().split("T")[0];
const maxDate = new Date(Date.now() + 90 * 24 * 60 * 60 * 1000).toISOString().split("T")[0];

export default function Search() {
  const [source, setSource] = useState("");
  const [destination, setDestination] = useState("");
  const [travelDate, setTravelDate] = useState("");
  const [trains, setTrains] = useState([]);
  const [loading, setLoading] = useState(false);
  const [searched, setSearched] = useState(false);
  const [error, setError] = useState("");
  const [toastMsg, setToastMsg] = useState("");
  const [selectedClass, setSelectedClass] = useState({});
  const router = useRouter();

  useEffect(() => {
    if (!localStorage.getItem("access")) router.push("/login");
  }, []);

  const showToast = (msg) => {
    setToastMsg(msg);
    setTimeout(() => setToastMsg(""), 3000);
  };

  const searchTrains = async () => {
    if (!source.trim() || !destination.trim()) {
      setError("Please enter both source and destination.");
      return;
    }
    if (!travelDate) {
      setError("Please select a travel date.");
      return;
    }
    setError("");
    setLoading(true);
    setSearched(false);
    setSelectedClass({});

    try {
      const token = localStorage.getItem("access");
      const response = await axios.get(
        `${API}/api/trains/search/?source=${source}&destination=${destination}&date=${travelDate}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      setTrains(response.data);
      setSearched(true);

      const autoSelect = {};
      response.data.forEach((train) => {
        if (train.classes?.length > 0) {
          autoSelect[train.id] = train.classes[0];
        }
      });
      setSelectedClass(autoSelect);

    } catch (err) {
      if (err.response?.status === 401) {
        router.push("/login");
      } else {
        setError("Failed to fetch trains. Please try again.");
      }
    } finally {
      setLoading(false);
    }
  };

  const handleKeyDown = (e) => {
    if (e.key === "Enter") searchTrains();
  };

  const swapStations = () => {
    const temp = source;
    setSource(destination);
    setDestination(temp);
  };

  return (
    <div>
      {/* Toast */}
      {toastMsg && (
        <div style={{
          position: "fixed", bottom: "2rem", right: "2rem",
          background: toastMsg.startsWith("❌") ? "rgba(239,68,68,0.15)" : "rgba(34,197,94,0.15)",
          border: `1px solid ${toastMsg.startsWith("❌") ? "rgba(239,68,68,0.3)" : "rgba(34,197,94,0.3)"}`,
          color: toastMsg.startsWith("❌") ? "#fca5a5" : "#86efac",
          padding: "0.9rem 1.5rem", borderRadius: "12px",
          fontWeight: 600, fontSize: "0.92rem", zIndex: 999,
          backdropFilter: "blur(12px)", boxShadow: "0 8px 30px rgba(0,0,0,0.4)",
        }}>
          {toastMsg}
        </div>
      )}

      <div className="page-header animate-in">
        <h1 className="page-title">Search <span>Trains</span></h1>
        <p className="page-subtitle">Find available trains between stations</p>
      </div>

      {/* Search Bar */}
      <div className="search-bar animate-in delay-1">
        <div className="search-field">
          <label className="form-label">From</label>
          <input
            className="form-input"
            placeholder="e.g. Howrah"
            value={source}
            onChange={(e) => setSource(e.target.value)}
            onKeyDown={handleKeyDown}
          />
        </div>

        <button onClick={swapStations} style={{
          background: "rgba(255,107,43,0.12)", border: "1px solid rgba(255,107,43,0.25)",
          color: "var(--orange-400)", borderRadius: "50%", width: "42px", height: "42px",
          fontSize: "1.1rem", cursor: "pointer", flexShrink: 0,
          transition: "all 0.2s", alignSelf: "flex-end",
        }} title="Swap stations">⇄</button>

        <div className="search-field">
          <label className="form-label">To</label>
          <input
            className="form-input"
            placeholder="e.g. New Delhi"
            value={destination}
            onChange={(e) => setDestination(e.target.value)}
            onKeyDown={handleKeyDown}
          />
        </div>

        {/* Date Field */}
        <div className="search-field">
          <label className="form-label">Date</label>
          <input
            type="date"
            className="form-input"
            value={travelDate}
            min={today}
            max={maxDate}
            onChange={(e) => setTravelDate(e.target.value)}
            style={{ colorScheme: "dark" }}
          />
        </div>

        <button className="btn-primary" onClick={searchTrains} disabled={loading}
          style={{ height: "44px", padding: "0 1.75rem", fontSize: "0.95rem", alignSelf: "flex-end", flexShrink: 0 }}>
          {loading ? "Searching…" : "Search →"}
        </button>
      </div>

      {error && (
        <div className="alert alert-error animate-in" style={{ maxWidth: "600px" }}>
          <span>⚠️</span> {error}
        </div>
      )}

      {loading && (
        <div className="loading-container">
          <div className="spinner" />
          <p className="loading-text">Searching for trains…</p>
        </div>
      )}

      {!loading && searched && trains.length === 0 && (
        <div className="empty-state animate-in">
          <div className="empty-icon">🚉</div>
          <p className="empty-title">No trains found</p>
          <p className="empty-desc">Try different source or destination stations.</p>
        </div>
      )}

      {!loading && trains.length > 0 && (
        <>
          <div style={{ marginBottom: "1rem", color: "var(--gray-500)", fontSize: "0.88rem" }}>
            {trains.length} train{trains.length !== 1 ? "s" : ""} found for{" "}
            <strong style={{ color: "var(--white)" }}>{source}</strong>
            {" → "}
            <strong style={{ color: "var(--white)" }}>{destination}</strong>
            {" on "}
            <strong style={{ color: "var(--white)" }}>
              {new Date(travelDate).toLocaleDateString("en-IN", { day: "numeric", month: "short", year: "numeric" })}
            </strong>
          </div>

          <div className="results-grid">
            {trains.map((train, i) => {
              const chosen = selectedClass[train.id];

              return (
                <div key={train.id} className={`card animate-in delay-${Math.min(i + 1, 5)}`}>

                  {/* Train Header */}
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: "1rem" }}>
                    <div>
                      <div className="card-title">{train.name}</div>
                      <div className="card-meta" style={{ marginTop: "0.3rem" }}>
                        <span>{train.source}</span>
                        <span className="route-arrow">→</span>
                        <span>{train.destination}</span>
                      </div>
                      <div style={{ fontSize: "0.8rem", color: "var(--gray-500)", marginTop: "0.2rem" }}>
                        🕐 {train.departure_time} → {train.arrival_time}
                      </div>
                    </div>
                  </div>

                  {/* Class Selector */}
                  {train.classes?.length > 0 ? (
                    <>
                      <div style={{ marginBottom: "0.6rem", fontSize: "0.75rem", color: "var(--gray-500)", letterSpacing: "0.05em" }}>
                        SELECT CLASS
                      </div>
                      <div style={{ display: "flex", flexWrap: "wrap", gap: "0.5rem", marginBottom: "1rem" }}>
                        {train.classes.map((cls) => {
                          const isSelected = chosen?.id === cls.id;
                          // ✅ use available_for_date (date-specific seats)
                          const seatsLeft = cls.available_for_date ?? cls.total_seats;
                          const isFull = seatsLeft === 0;

                          return (
                            <button
                              key={cls.id}
                              onClick={() => !isFull && setSelectedClass((prev) => ({ ...prev, [train.id]: cls }))}
                              disabled={isFull}
                              style={{
                                padding: "0.45rem 0.75rem", borderRadius: "8px",
                                border: isSelected ? "1px solid rgba(255,107,43,0.7)" : "1px solid rgba(255,255,255,0.1)",
                                background: isSelected ? "rgba(255,107,43,0.15)" : "rgba(255,255,255,0.04)",
                                color: isFull ? "#4b5563" : isSelected ? "#ff8c55" : "#b0bcd0",
                                fontSize: "0.78rem", fontWeight: isSelected ? 700 : 500,
                                cursor: isFull ? "not-allowed" : "pointer",
                                transition: "all 0.2s", textAlign: "center",
                              }}
                            >
                              <div>{CLASS_LABELS[cls.class_type]?.icon} {CLASS_LABELS[cls.class_type]?.label || cls.class_type}</div>
                              <div style={{ fontSize: "0.72rem", marginTop: "0.15rem" }}>
                                {isFull ? "Full" : `₹${cls.price} · ${seatsLeft} left`}
                              </div>
                            </button>
                          );
                        })}
                      </div>

                      {/* Selected class summary */}
                      {chosen && (
                        <div style={{
                          background: "rgba(255,107,43,0.07)", border: "1px solid rgba(255,107,43,0.2)",
                          borderRadius: "10px", padding: "0.6rem 1rem",
                          display: "flex", justifyContent: "space-between",
                          alignItems: "center", marginBottom: "1rem",
                        }}>
                          <span style={{ fontSize: "0.82rem", color: "#b0bcd0" }}>
                            {CLASS_LABELS[chosen.class_type]?.label} · {chosen.available_for_date ?? chosen.total_seats} seats left
                          </span>
                          <span style={{ fontWeight: 800, color: "#ff8c55", fontSize: "1.1rem" }}>
                            ₹{chosen.price}
                          </span>
                        </div>
                      )}
                    </>
                  ) : (
                    <div style={{ fontSize: "0.82rem", color: "#6b7a94", marginBottom: "1rem" }}>
                      No classes available for this train.
                    </div>
                  )}

                  {/* Footer */}
                  <div style={{
                    borderTop: "1px solid rgba(255,255,255,0.06)", paddingTop: "1rem",
                    display: "flex", justifyContent: "space-between", alignItems: "center",
                  }}>
                    <div style={{ fontSize: "0.8rem", color: "var(--gray-500)" }}>
                      Train #{train.id}
                    </div>
                    {chosen && (chosen.available_for_date ?? chosen.total_seats) > 0 ? (
                      <PaymentQR
                        trainId={train.id}
                        classId={chosen.id}
                        price={chosen.price}
                        travelDate={travelDate}
                        onBookingSuccess={() => {
                          showToast("🎫 Booking confirmed!");
                          searchTrains();
                        }}
                      />
                    ) : (
                      <span style={{ fontSize: "0.82rem", color: "#6b7a94" }}>
                        Select a class to book
                      </span>
                    )}
                  </div>

                </div>
              );
            })}
          </div>
        </>
      )}
    </div>
  );
}