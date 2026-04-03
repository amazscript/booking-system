# Booking System

A full-featured, multilingual booking/reservation system with a custom calendar, drag-and-drop, and dynamic custom fields.

## Features

- **Custom Calendar** with 6 views: Month, Week, Day, Timeline, Resource Month, Resource Grid
- **Drag & Drop**: move, resize, and create bookings by dragging
- **Swipe navigation** on mobile (prev/next day/month)
- **Dynamic Custom Fields**: text, textarea, number, select, multi-select, radio, date, time, datetime, email, phone, url, color, range, file/image, checkbox, hidden, address, video
- **File Upload** to MinIO (S3-compatible) with image preview and resizing controls
- **Multi-resource support**: manage multiple bookable entities (rooms, practitioners, equipment...)
- **Unavailability Blocks**: block time ranges per resource with hatched visual indicators across all views
- **Responsive Design**: mobile-first with hamburger menu, bottom sheets, tap-to-create, touch targets
- **13 Languages**: EN, FR, DE, ES, IT, PT, NL, PL, RU, AR, JA, ZH, TR
- **Email Notifications**: booking confirmation + J-1 reminders via SMTP
- **Print Support**: print-friendly calendar layout

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Vue.js 3, Tailwind CSS v4, Pinia, Vue Router |
| Backend | Node.js, Express.js, Sequelize ORM |
| Database | PostgreSQL 16 |
| Storage | MinIO (S3-compatible) |
| Email | Nodemailer + Mailpit (dev) |
| Infra | Docker Compose |

## Quick Start

### With Docker (recommended)

```bash
# Fresh install (everything from scratch: MinIO, PostgreSQL, API, Frontend, seed data)
make fresh

# Or step by step:
make up           # Start all services (PostgreSQL, API, Frontend, Mailpit, MinIO)
make seed         # Basic seed (admin + 3 resources)
make seed-demo    # Rich demo data (6 resources, 31 custom fields, 25 bookings)
```

Services:
- **Frontend**: http://localhost:5173
- **API**: http://localhost:3000
- **MinIO** (file storage): http://localhost:9001
- **Mailpit** (email UI): http://localhost:8025
- **PostgreSQL**: localhost:5433

### Local Development (without Docker)

```bash
# Install dependencies
make install

# Start API + Frontend
make dev
```

Requires PostgreSQL on localhost:5433. MinIO is started automatically by `make up`.

## Admin Access

```
Email:    admin@booking.local
Password: admin123
```

## Project Structure

```
booking/
  api/                    # Express.js REST API
    config/               # Database, storage (MinIO) config
    middleware/            # Auth (JWT), validation
    models/               # Sequelize models (Resource, Booking, CustomField, etc.)
    routes/               # API routes (admin, bookings, resources, upload)
    services/             # Email service, reminder cron
    utils/                # Sanitize, validation helpers
    seed.js               # Basic seed (admin + 3 resources)
    seed-demo.js          # Rich demo seed (6 resources, 25 bookings, images)
    server.js             # Express app entry point
  frontend/               # Vue.js 3 SPA
    src/
      components/         # Reusable components
        CalendarView.vue  # Custom calendar (2400+ lines, 6 views, drag & drop)
        BookingForm.vue   # Booking form with dynamic custom fields
        EventActions.vue  # Event action buttons (view, edit, delete)
        SlotPicker.vue    # Time slot selection grid
        ConfirmModal.vue  # Confirmation dialog
        AddressField.vue  # Address autocomplete
      views/              # Page components
        BookingCalendar   # Main booking page (calendar + form + modals)
        AdminDashboard    # Bookings management table
        AdminResources    # Resources + custom fields management
        AdminBlocks       # Unavailability blocks management
        AdminSettings     # App settings (name, color, SMTP, logo)
        AdminLogin        # JWT authentication
        CancelBooking     # Public cancellation page
      stores/             # Pinia stores (auth, admin, bookings, resources)
      i18n/               # 13 language files (en, fr, de, es, it, pt, nl, pl, ru, ar, ja, zh, tr)
      style.css           # Calendar grid styles + responsive breakpoints
    nginx.conf            # Production nginx config with API proxy
  docker-compose.yml      # PostgreSQL, API, Frontend, Mailpit
  Makefile                # Development commands
```

## API Endpoints

### Public
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/resources` | List active resources |
| GET | `/api/resources/:id/fields` | Custom fields for a resource |
| GET | `/api/resources/:id/slots` | Time slots for a resource |
| POST | `/api/bookings` | Create a booking |
| GET | `/api/bookings/cancel/:token` | Cancel a booking |
| POST | `/api/upload` | Upload a file (image, PDF, doc) |
| GET | `/api/settings/public` | Public settings (name, color, logo) |

### Admin (JWT required)
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/login` | Login, get JWT |
| GET | `/api/admin/bookings` | List bookings (filters, pagination) |
| POST | `/api/admin/bookings` | Create booking (admin) |
| PUT | `/api/admin/bookings/:id` | Update booking |
| DELETE | `/api/admin/bookings/:id` | Cancel booking (soft delete) |
| DELETE | `/api/admin/bookings/:id/permanent` | Permanently delete booking |
| GET | `/api/admin/booking-values/:id` | Custom field values for a booking |
| GET/POST/PUT/DELETE | `/api/admin/resources/*` | CRUD resources |
| POST | `/api/admin/resources/:id/slots` | Set time slots |
| GET/POST/PUT/DELETE | `/api/admin/custom-fields/*` | CRUD custom fields |
| GET/POST/PUT/DELETE | `/api/admin/blocks/*` | CRUD unavailability blocks |
| GET/PUT | `/api/admin/settings` | App settings |

## Custom Field Types

| Type | Input | Storage |
|------|-------|---------|
| text, textarea, number, email, tel, url | Standard HTML input | String |
| select, radio | Dropdown / radio buttons with options (`Label\|duration\|price`) | Option value |
| multi-select | Checkbox group with options (`Label\|duration\|price`) | Comma-separated values |
| date, time, datetime-local | Date/time pickers | ISO string |
| color | Color picker | Hex code |
| range | Slider | Number |
| file | File upload to MinIO | JSON `{"url","w","h"}` |
| checkbox | Toggle | `true` / `false` |
| address | Autocomplete (LocationIQ/Nominatim) | JSON `{"street","city","postcode","country"}` |
| video | YouTube/Dailymotion/Vimeo URL | URL string |
| hidden | Not visible to user | String |

## Makefile Commands

```
make help           # Show all commands
make up             # Start all services (Docker + MinIO)
make down           # Stop all services (Docker + MinIO)
make build          # Rebuild Docker images
make logs           # View all logs
make seed           # Basic seed (admin + 3 resources)
make seed-demo      # Rich demo seed (6 resources, 25 bookings)
make reset-demo     # Full reset + both seeds
make db-shell       # PostgreSQL shell
make dev            # Local dev (API + Frontend)
make install        # Install dependencies
make test           # Run API tests
make fresh          # Full reset like a fresh clone (stop + clean + rebuild + MinIO + seed)
make clean          # Remove Docker volumes
make clean-all      # Remove everything (images, volumes, node_modules)
make mail           # Open Mailpit in browser
```

## Environment Variables

### API (`api/.env`)
```env
API_PORT=3000
JWT_SECRET=change-me-to-a-random-string
DB_HOST=localhost
DB_PORT=5433
DB_NAME=booking
DB_USER=booking
DB_PASS=booking123
SMTP_HOST=localhost
SMTP_PORT=1025
SMTP_FROM=noreply@booking.local
ADMIN_EMAIL=admin@booking.local
BASE_URL=http://localhost:5173
LOCATIONIQ_KEY=              # Optional, uses Nominatim if empty
MINIO_HOST=localhost         # MinIO connection
MINIO_PORT=9000
MINIO_ACCESS_KEY=hotelbot
MINIO_SECRET_KEY=hotelbot_secret
MINIO_BUCKET=booking-uploads
MINIO_PUBLIC_HOST=http://localhost:9000
```

### Frontend (`frontend/.env`)
```env
VITE_API_URL=                # Defaults to /api (proxied by Vite/nginx)
```

## Responsive Design

| Breakpoint | Behavior |
|-----------|----------|
| < 640px (phone) | Hamburger menu, month dots + bottom sheet, day view only, tap-to-create, swipe navigation |
| 640-1023px (tablet) | All 6 views, touch drag support |
| >= 1024px (desktop) | Full mouse drag & drop, all features |

## Security

- **Helmet**: secure HTTP headers (CSP, HSTS, X-Frame-Options, etc.)
- **Rate limiting**: 5 login attempts/15min, 20 uploads/15min, 500 API requests/15min
- **CORS**: restricted to configured origins
- **JWT**: HS256, 24h expiration, bcrypt password hashing
- **Role verification**: admin role required for all admin endpoints
- **Auto-logout**: invalid/expired tokens trigger automatic redirect to login

## License

Private project.
