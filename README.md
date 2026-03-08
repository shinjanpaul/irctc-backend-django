# 🚂 IRCTC Mini Backend System

A simplified backend system inspired by IRCTC, built using **Django** and **Django REST Framework**. The project supports user authentication, train search, seat booking with Razorpay payments, and analytics.

> 🔗 **Live Frontend:** [https://irctc-backend-django.vercel.app](https://irctc-backend-django.vercel.app)
> 🔗 **Live Backend:** [https://irctc-backend-django-1.onrender.com](https://irctc-backend-django-1.onrender.com)

---

## 🚀 Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | Django, Django REST Framework |
| Authentication | JWT (SimpleJWT) |
| Transactional DB | MySQL (Filess.io – Cloud) |
| Analytics DB | MongoDB (MongoDB Atlas – Cloud) |
| Payments | Razorpay |
| Backend Hosting | Render |
| Frontend Hosting | Vercel |
| Frontend | Next.js |

---

## 📦 Features

- User registration & login (JWT-based)
- Role-based access (Admin / User)
- Train creation (Admin only)
- Train search with MongoDB logging
- Seat booking with Razorpay payment integration
- Transaction-safe seat booking
- Analytics API for most searched routes

---

## 🛠️ Local Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/shinjanpaul/irctc-backend-django
cd irctc-backend-django
```

### 2️⃣ Create and Activate Virtual Environment

```bash
python -m venv venv
venv\Scripts\activate       # Windows
# source venv/bin/activate  # Mac/Linux
```

### 3️⃣ Install Dependencies

```bash
pip install -r requirements.txt
```

### 4️⃣ Environment Variables Setup

A template file `.env.example` is provided. Create your `.env` file by copying it:

```bash
cp .env.example .env
```

Fill in your `.env` with the following values:

```env
SECRET_KEY=your-secret-key
DEBUG=True

# MySQL Database (local)
DB_NAME=irctc_db
DB_USER=root
DB_PASSWORD=your_local_password
DB_HOST=localhost
DB_PORT=3306

# MongoDB (used for logging & analytics)
MONGO_URI=your_mongodb_atlas_uri
MONGO_DB_NAME=irctc_logs

# Razorpay
RAZORPAY_KEY_ID=your_razorpay_key_id
RAZORPAY_KEY_SECRET=your_razorpay_key_secret
```

### 5️⃣ Run Database Migrations

```bash
python manage.py makemigrations
python manage.py migrate
```

### 6️⃣ Create Admin User

```bash
python manage.py createsuperuser
```

### 7️⃣ Run the Server

```bash
python manage.py runserver
```

---

## ☁️ Cloud Database Setup

### MySQL — Filess.io (Free Cloud MySQL)

This project uses [Filess.io](https://filess.io) for free cloud-hosted MySQL in production.

- Free forever, no credit card required
- Supports MySQL 5.7+
- 10MB storage, 2 databases, unlimited traffic

Set the following environment variables on your hosting platform (e.g., Render):

```
DB_NAME=your_filess_db_name
DB_USER=your_filess_db_user
DB_PASSWORD=your_filess_db_password
DB_HOST=your_filess_db_host
DB_PORT=3306
```

### MongoDB — MongoDB Atlas (Free Cloud MongoDB)

This project uses [MongoDB Atlas](https://www.mongodb.com/atlas) for logging train searches and analytics.

Set:

```
MONGO_URI=mongodb+srv://<user>:<password>@cluster.mongodb.net/?...
MONGO_DB_NAME=irctc_logs
```

---

## 🔐 Authentication

JWT authentication is used. On login/register, you receive an `access` token and a `refresh` token.

All protected APIs require the following header:

```
Authorization: Bearer <access_token>
```

---

## 📡 API Reference

### Auth APIs

**Register User**
```
POST /api/register/
```
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Login User**
```
POST /api/login/
```
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

---

### Train APIs

**Create Train** *(Admin only)*
```
POST /api/trains/
Authorization: Bearer <admin_token>
```
```json
{
  "train_number": "12345",
  "name": "Rajdhani Express",
  "source": "Delhi",
  "destination": "Kolkata",
  "total_seats": 100,
  "available_seats": 100
}
```

**Search Trains**
```
GET /api/trains/search/?source=Delhi&destination=Kolkata
```

---

### 🎫 Booking APIs

**Create Razorpay Order**
```
POST /api/bookings/create-order/
Authorization: Bearer <user_token>
```
```json
{
  "train_id": 1,
  "class_id": 1,
  "seats": 1,
  "travel_date": "2026-04-01"
}
```

**Verify Payment & Confirm Booking**
```
POST /api/bookings/verify-payment/
Authorization: Bearer <user_token>
```
```json
{
  "razorpay_order_id": "order_xxx",
  "razorpay_payment_id": "pay_xxx",
  "razorpay_signature": "signature_xxx",
  "train_id": 1,
  "class_id": 1,
  "seats": 1,
  "travel_date": "2026-04-01"
}
```

**View My Bookings**
```
GET /api/bookings/my/
Authorization: Bearer <user_token>
```

---

### 📊 Analytics API

**Top Searched Routes** *(Logged in MongoDB)*
```
GET /api/analytics/top-routes/
```

**Response:**
```json
[
  {
    "source": "Delhi",
    "destination": "Kolkata",
    "count": 3
  }
]
```

---

## 🚢 Deployment Guide

### Backend — Render

1. Push your code to GitHub
2. Go to [render.com](https://render.com) → New → Web Service → connect your repo
3. Set **Build Command:**
   ```bash
   pip install -r requirements.txt && python manage.py migrate
   ```
4. Set **Start Command:**
   ```bash
   gunicorn irctc_backend.wsgi
   ```
5. Add the following **Environment Variables** in Render dashboard:

| Key | Value |
|-----|-------|
| `SECRET_KEY` | your-django-secret-key |
| `DEBUG` | False |
| `ALLOWED_HOSTS` | your-app.onrender.com |
| `DB_NAME` | your filess.io db name |
| `DB_USER` | your filess.io db user |
| `DB_PASSWORD` | your filess.io db password |
| `DB_HOST` | your filess.io db host |
| `DB_PORT` | 3306 |
| `MONGO_URI` | your MongoDB Atlas URI |
| `MONGO_DB_NAME` | irctc_logs |
| `RAZORPAY_KEY_ID` | your razorpay key id |
| `RAZORPAY_KEY_SECRET` | your razorpay secret key |

### Frontend — Vercel

1. Go to [vercel.com](https://vercel.com) → Add New Project
2. Import your GitHub repo (set **Root Directory** to `irctc-frontend` if frontend is in a subfolder)
3. Add **Environment Variable:**

| Key | Value |
|-----|-------|
| `NEXT_PUBLIC_API_URL` | https://irctc-backend-django-1.onrender.com |
| `NEXT_PUBLIC_RAZORPAY_KEY_ID` | your razorpay key id |

4. Click **Deploy**

---

## 🏗️ Architecture

```
Vercel (Next.js Frontend)
        ↓ HTTPS API calls
Render (Django Backend)
     ↓               ↓
Filess.io        MongoDB Atlas
(MySQL Cloud)    (Analytics Logs)
        ↓
   Razorpay API
  (Payments)
```

---

## ⚠️ Important Notes

- The Render free tier **spins down after 15 minutes of inactivity**. The first request after inactivity may take 30–60 seconds to respond. Open the backend URL before any demo to warm it up.
- Never commit your `.env` file — ensure it is listed in `.gitignore`.
- The Razorpay secret key must **only** be on the backend (Render). Never expose it on the frontend.
- Filess.io free plan allows **2 databases** with **10MB storage** — sufficient for development and college-level projects.

---

## 📁 Project Structure

```
irctc-backend-django/
├── irctc_backend/        # Django project settings
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── accounts/             # User auth app
├── trains/               # Train management app
├── bookings/             # Booking & payment app
├── analytics/            # MongoDB analytics app
├── irctc-frontend/       # Next.js frontend
│   └── src/
│       ├── app/
│       └── components/
├── requirements.txt
├── manage.py
└── .env.example
```

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License

This project is for educational purposes.
