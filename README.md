# IRCTC Mini Backend System

A simplified backend system inspired by IRCTC, built using Django and Django REST Framework.  
The project supports user authentication, train search, seat booking, and analytics.

---

## 🚀 Tech Stack

- Backend: Django, Django REST Framework
- Authentication: JWT (SimpleJWT)
- Database:
  - MySQL – transactional data (users, trains, bookings)
  - MongoDB – analytics & API logs

---

## 📦 Features

- User registration & login (JWT-based)
- Role-based access (Admin / User)
- Train creation (Admin only)
- Train search with MongoDB logging
- Seat booking with transaction safety
- Analytics API for most searched routes

---

## 🛠️ Setup Instructions

### 1️⃣ Clone the repository
```bash
git clone <https://github.com/shinjanpaul/irctc-backend-django>
cd irctc-backend
2️⃣ Create and activate virtual environment
python -m venv venv
venv\Scripts\activate
3️⃣ Install dependencies
pip install -r requirements.txt
4️⃣ Environment variables setup

A template file .env.example is provided.

Create a .env file by copying:

cp .env.example .env
5️⃣ Run database migrations
python manage.py makemigrations
python manage.py migrate
6️⃣ Create admin user
python manage.py createsuperuser
7️⃣ Run the server
python manage.py runserver
🔐 Authentication

JWT authentication is used.

On login/register, you receive:

access token

refresh token

All protected APIs require:

Authorization: Bearer <access_token>


Register User
POST /api/register/


Body

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}



Login User
POST /api/login/


Body

{
  "email": "john@example.com",
  "password": "password123"
}



Train APIs
Create Train (Admin only)
POST /api/trains/


Headers

Authorization: Bearer <admin_token>
Body

{
  "train_number": "12345",
  "name": "Rajdhani Express",
  "source": "Delhi",
  "destination": "Kolkata",
  "total_seats": 100,
  "available_seats": 100
}


Search Trains
GET /api/trains/search/?source=Delhi&destination=Kolkata



🎫 Booking APIs
Book Seat
POST /api/bookings/


Headers

Authorization: Bearer <user_token>


Body

{
  "train_id": 1,
  "seats": 2
}



View My Bookings
GET /api/bookings/my/




Analytics API
Top Searched Routes
GET /api/analytics/top-routes/


Response

[
  {
    "source": "Delhi",
    "destination": "Kolkata",
    "count": 3
  }
]