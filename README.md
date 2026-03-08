🚂 IRCTC Mini: Full-Stack Railway Management SystemA high-performance, full-stack railway booking application inspired by IRCTC. This project demonstrates a hybrid database architecture, secure JWT authentication, and real-time payment integration.🔗 Live DeploymentFrontend (Vercel): https://irctc-backend-django.vercel.app/Backend API (Render): https://irctc-backend-django-1.onrender.com🏗️ System ArchitectureThis project utilizes a Polyglot Persistence strategy to handle different data requirements:Relational (MySQL): Handles ACID-compliant transactions for user accounts, train schedules, and seat bookings.NoSQL (MongoDB): Managed via Atlas for high-speed logging of search queries and system analytics.🚀 Tech StackFrontendFramework: Next.js (React)Styling: Tailwind CSSHTTP Client: AxiosDeployment: VercelBackendFramework: Django & Django REST Framework (DRF)Authentication: JWT (SimpleJWT)Task Logic: Atomic transactions for seat locking.Deployment: RenderDatabase & ServicesPrimary DB: MySQL (Hosted via Filess.io)Logging DB: MongoDB AtlasPayments: Razorpay API Integration📦 Core FeaturesUser Management: Secure Sign-up/Login with encrypted passwords and JWT tokens.Advanced Train Search: Filter by source, destination, and date with automatic search logging.Smart Booking: Real-time seat availability check with atomic transaction safety to prevent overbooking.Payment Gateway: Integrated Razorpay "Test Mode" for simulated ticket purchases.Admin Dashboard: Role-based access to add trains and manage schedules.Analytics: Dedicated endpoint for viewing "Top Searched Routes" powered by MongoDB.🛠️ Environment VariablesTo run this project locally, ensure you have a .env file with the following keys:Backend (/irctc-backend-django/)Code snippetDEBUG=True
SECRET_KEY=your_secret_key

# MySQL Credentials
DB_NAME=myapp_db_elephantme
DB_USER=myapp_db_elephantme
DB_PASSWORD=your_filess_io_password
DB_HOST=zyre84.h.filess.io
DB_PORT=61002

# MongoDB Credentials
MONGO_URI=your_mongodb_atlas_uri
MONGO_DB_NAME=irctc_logs

# Razorpay
RAZORPAY_KEY_ID=rzp_test_2EpPSCTb8XHFCk
RAZORPAY_KEY_SECRET=jHxKaISFIwGZ1byoWqtzldAB
Frontend (/irctc-frontend/)Code snippetNEXT_PUBLIC_API_URL=https://irctc-backend-django-1.onrender.com
NEXT_PUBLIC_RAZORPAY_KEY_ID=rzp_test_2EpPSCTb8XHFCk
📡 API EndpointsCategoryEndpointMethodDescriptionAuth/api/accounts/register/POSTRegister a new userAuth/api/accounts/login/POSTLogin & receive JWTTrains/api/trains/search/GETSearch for trains (Logs to Mongo)Booking/api/bookings/create-order/POSTInitialize Razorpay OrderBooking/api/bookings/verify-payment/POSTConfirm payment & reserve seatLogs/api/analytics/top-routes/GETRetrieve route search statistics📝 Deployment Notes[!IMPORTANT]Performance Note: Since the backend is hosted on Render's Free Tier, the server "sleeps" after 15 minutes of inactivity. The first request after a break may take 30-50 seconds to boot up. Please wait for the spinner to finish during the first load!👥 CreditsDeveloped by: Shinjan Paul
