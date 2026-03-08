"use client";

import { useState } from "react";
import axios from "axios";
import { useRouter } from "next/navigation";
import Link from "next/link";

export default function Register() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState(false);
  const router = useRouter();

  const handleRegister = async () => {
    setError("");

    if (!name || !email || !password) {
      setError("Please fill in all fields.");
      return;
    }

    if (password.length < 6) {
      setError("Password must be at least 6 characters.");
      return;
    }

    setLoading(true);
    try {
      await axios.post(
        `${process.env.NEXT_PUBLIC_API_URL || "http://127.0.0.1:8000"}/api/register/`,
        { name, email, password }
      );

      setSuccess(true);
      setTimeout(() => router.push("/login"), 1800);
    } catch (err) {
      const data = err.response?.data;
      if (data?.email) setError(`Email: ${data.email[0]}`);
      else if (data?.password) setError(`Password: ${data.password[0]}`);
      else setError("Registration failed. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="form-container" style={{ paddingTop: "3rem" }}>
      <div className="page-header" style={{ textAlign: "center", marginBottom: "2rem" }}>
        <div style={{ fontSize: "2.5rem", marginBottom: "0.75rem" }}>🎫</div>
        <h1 className="page-title">Create Account</h1>
        <p className="page-subtitle">Join RailConnect and start booking</p>
      </div>

      <div className="form-card animate-in">
        {error && (
          <div className="alert alert-error">
            <span>⚠️</span> {error}
          </div>
        )}

        {success && (
          <div className="alert alert-success">
            <span>✅</span> Account created! Redirecting to login…
          </div>
        )}

        <div className="form-group">
          <label className="form-label">Full Name</label>
          <input
            className="form-input"
            placeholder="Rahul Sharma"
            value={name}
            onChange={(e) => setName(e.target.value)}
            autoComplete="name"
          />
        </div>

        <div className="form-group">
          <label className="form-label">Email Address</label>
          <input
            className="form-input"
            type="email"
            placeholder="you@example.com"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            autoComplete="email"
          />
        </div>

        <div className="form-group">
          <label className="form-label">Password</label>
          <input
            className="form-input"
            type="password"
            placeholder="Min. 6 characters"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            autoComplete="new-password"
          />
        </div>

        <button
          className="submit-btn"
          onClick={handleRegister}
          disabled={loading || success}
        >
          {loading ? "Creating account…" : "Create Account →"}
        </button>

        <div className="divider-text">
          <span>Already have an account?</span>
        </div>

        <div style={{ textAlign: "center" }}>
          <Link href="/login" className="text-link">
            Sign in instead
          </Link>
        </div>
      </div>
    </div>
  );
}