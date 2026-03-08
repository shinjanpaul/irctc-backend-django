"use client";

import { useEffect, useState } from "react";
import { useRouter, usePathname } from "next/navigation";
import Link from "next/link";
import { Syne, DM_Sans } from "next/font/google";
import "./globals.css";

const syne = Syne({
  subsets: ["latin"],
  weight: ["400", "600", "700", "800"],
  variable: "--font-syne",
});

const dmSans = DM_Sans({
  subsets: ["latin"],
  weight: ["300", "400", "500", "600"],
  variable: "--font-dm-sans",
});

export default function RootLayout({ children }) {
  const router = useRouter();
  const pathname = usePathname();
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);

  useEffect(() => {
    const token = localStorage.getItem("access");
    setIsLoggedIn(!!token);
  }, [pathname]);

  const handleLogout = () => {
    localStorage.removeItem("access");
    localStorage.removeItem("refresh");
    setIsLoggedIn(false);
    router.push("/login");
  };

  const navLinks = isLoggedIn
    ? [
        { href: "/search", label: "Search Trains" },
        { href: "/bookings", label: "My Bookings" },
        { href: "/analytics", label: "Analytics" },
      ]
    : [];

  return (
    <html lang="en" className={`${syne.variable} ${dmSans.variable}`}>
      <body>
        <nav className="navbar">
          <Link href="/" className="navbar-brand">
            <span className="brand-icon">🚆</span>
            <span className="brand-text">RailConnect</span>
          </Link>

          <div className={`nav-links ${menuOpen ? "open" : ""}`}>
            {navLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className={`nav-link ${pathname === link.href ? "active" : ""}`}
                onClick={() => setMenuOpen(false)}
              >
                {link.label}
              </Link>
            ))}

            {/* Auth buttons inside mobile menu */}
            <div className="mobile-auth-section">
              {isLoggedIn ? (
                <button className="btn-logout mobile-full" onClick={handleLogout}>
                  Logout
                </button>
              ) : (
                <>
                  <Link href="/login" className="btn-ghost mobile-full" onClick={() => setMenuOpen(false)}>Login</Link>
                  <Link href="/register" className="btn-primary mobile-full" onClick={() => setMenuOpen(false)}>Register</Link>
                </>
              )}
            </div>
          </div>

          <div className="nav-actions">
            {isLoggedIn ? (
              <button className="btn-logout" onClick={handleLogout}>
                Logout
              </button>
            ) : (
              <>
                <Link href="/login" className="btn-ghost">Login</Link>
                <Link href="/register" className="btn-primary">Register</Link>
              </>
            )}
          </div>

          <button className="hamburger" onClick={() => setMenuOpen(!menuOpen)}>
            <span /><span /><span />
          </button>
        </nav>

        <main className="main-content">{children}</main>

        <footer className="footer">
          <p>© 2025 RailConnect · Built with Next.js & Django</p>
        </footer>
      </body>
    </html>
  );
}