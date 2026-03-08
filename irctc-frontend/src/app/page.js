"use client";

import Link from "next/link";
import { useEffect, useState } from "react";

export default function Home() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  useEffect(() => {
    setIsLoggedIn(!!localStorage.getItem("access"));
  }, []);

  return (
    <div>
      <section className="hero">
        <div className="hero-eyebrow animate-in">India's Railway Booking Platform</div>

        <h1 className="hero-title animate-in delay-1">
          Book Your Journey<br />
          <span>Across India</span>
        </h1>

        <p className="hero-desc animate-in delay-2">
          Search trains, check seat availability, and book tickets seamlessly.
          Fast, reliable, and built for every traveler.
        </p>

        <div className="hero-actions animate-in delay-3">
          {isLoggedIn ? (
            <Link href="/search" className="btn-primary" style={{ fontSize: "1rem", padding: "0.75rem 2rem" }}>
              Search Trains →
            </Link>
          ) : (
            <>
              <Link href="/register" className="btn-primary" style={{ fontSize: "1rem", padding: "0.75rem 2rem" }}>
                Get Started →
              </Link>
              <Link href="/login" className="btn-ghost" style={{ fontSize: "1rem", padding: "0.75rem 2rem" }}>
                Sign In
              </Link>
            </>
          )}
        </div>
      </section>

      <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(220px, 1fr))", gap: "1rem", maxWidth: "800px", margin: "0 auto", padding: "0 1rem 4rem" }}>
        {[
          { icon: "🚄", title: "Fast Search", desc: "Instantly find trains between any two stations across India." },
          { icon: "🎫", title: "Easy Booking", desc: "Book seats in seconds with a simple, secure checkout flow." },
          { icon: "📊", title: "Analytics", desc: "Track your travel history and discover popular routes." },
          { icon: "🔐", title: "Secure Login", desc: "JWT-based auth keeps your account and bookings safe." },
        ].map((feature, i) => (
          <div key={i} className={`card animate-in delay-${i + 1}`} style={{ textAlign: "center" }}>
            <div style={{ fontSize: "2.2rem", marginBottom: "0.75rem" }}>{feature.icon}</div>
            <div className="card-title" style={{ fontSize: "1rem" }}>{feature.title}</div>
            <p style={{ color: "var(--gray-500)", fontSize: "0.85rem", marginTop: "0.4rem" }}>{feature.desc}</p>
          </div>
        ))}
      </div>
    </div>
  );
}