"use client";

import { useState } from "react";
import axios from "axios";

const API = process.env.NEXT_PUBLIC_API_URL || "http://127.0.0.1:8000";

export default function PaymentQR({ trainId, classId, price, travelDate, onBookingSuccess }) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const loadRazorpayScript = () =>
    new Promise((resolve) => {
      if (document.getElementById("razorpay-script")) return resolve(true);
      const script = document.createElement("script");
      script.id = "razorpay-script";
      script.src = "https://checkout.razorpay.com/v1/checkout.js";
      script.onload = () => resolve(true);
      script.onerror = () => resolve(false);
      document.body.appendChild(script);
    });

  const handlePayment = async () => {
    if (!travelDate) {
      setError("Please select a travel date.");
      return;
    }

    setLoading(true);
    setError("");

    const scriptLoaded = await loadRazorpayScript();
    if (!scriptLoaded) {
      setError("Failed to load Razorpay. Check your internet connection.");
      setLoading(false);
      return;
    }

    try {
      const token = localStorage.getItem("access");

      // Step 1: Create order
      const { data } = await axios.post(
        `${API}/api/bookings/create-order/`,
        { train_id: trainId, class_id: classId, seats: 1, travel_date: travelDate },
        { headers: { Authorization: `Bearer ${token}` } }
      );

      // Step 2: Open Razorpay
      const options = {
        key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID,
        amount: data.amount,
        currency: data.currency,
        order_id: data.order_id,
        name: "RailConnect",
        description: `Travel Date: ${travelDate}`,
        theme: { color: "#ff6b2b" },

        handler: async function (response) {
          try {
            const token = localStorage.getItem("access");

            await axios.post(
              `${API}/api/bookings/verify-payment/`,
              {
                razorpay_order_id: response.razorpay_order_id,
                razorpay_payment_id: response.razorpay_payment_id,
                razorpay_signature: response.razorpay_signature,
                train_id: trainId,
                class_id: classId,
                seats: 1,
                travel_date: travelDate,
              },
              { headers: { Authorization: `Bearer ${token}` } }
            );

            if (onBookingSuccess) onBookingSuccess();

            alert("🎫 Booking Confirmed!");
          } catch (err) {
            setError("Payment done but booking failed. Contact support.");
          }
        },

        prefill: {
          name: "Passenger",
          email: "passenger@railconnect.in",
        },

        modal: {
          ondismiss: () => {
            setLoading(false);
            setError("Payment cancelled.");
          },
        },
      };

      const rzp = new window.Razorpay(options);
      rzp.open();

    } catch (err) {
      setError(err.response?.data?.error || "Something went wrong.");
      setLoading(false);
    }
  };

  return (
    <div style={{ display: "flex", flexDirection: "column", alignItems: "flex-end", gap: "0.5rem" }}>

      <button
        className="book-btn"
        onClick={handlePayment}
        disabled={loading}
        style={{ opacity: loading ? 0.7 : 1 }}
      >
        {loading ? "Opening Payment…" : "🎫 Book Seat"}
      </button>

      {error && (
        <div
          style={{
            background: "rgba(239,68,68,0.1)",
            border: "1px solid rgba(239,68,68,0.25)",
            color: "#fca5a5",
            borderRadius: "10px",
            padding: "0.6rem 1rem",
            fontSize: "0.82rem",
          }}
        >
          ⚠️ {error}
        </div>
      )}
    </div>
  );
}