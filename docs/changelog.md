# CHANGELOG — Booking System

---

## V1.1 — April 2026

### Custom Fields, Internationalization & File Uploads

**13 Languages**
- en, fr, de, es, it, pt, nl, pl, ru, ar, ja, zh, tr
- All UI strings translated, including error messages

**19 Custom Field Types**
- text, textarea, number, select, multi-select, radio, date, time, datetime-local, email, tel, url, color, range, file, checkbox, hidden, address, video
- Each resource can have its own custom fields
- Options format: `Label|duration|price` for select, multi-select, radio

**File & Image Uploads**
- Upload to MinIO (S3-compatible) with real-time preview
- Width and height controls for images
- Size limit: 10 MB per file
- Translated error messages (file too large, type not allowed)

**Booking Detail Modal**
- Image preview with lightbox
- Video embed (YouTube, Vimeo, Dailymotion)
- Address formatting
- Color swatch display
- Multi-select displayed as blue tags
- Checkbox displayed as Yes/No (translated)
- Select/Radio displays option label instead of raw value

---

### Responsive Design

**Mobile (< 640px)**
- Hamburger menu navigation
- Calendar: only Month and Day views
- Month view: colored dots + bottom sheet on tap
- Day view: tap event = view details, tap empty cell = create booking
- Swipe left/right to navigate
- Drag disabled, replaced by tap interactions
- Single-letter day names (M, T, W...)
- Forms and modals in single column layout
- Image size sliders stacked vertically

**Tablet (640-1023px)**
- All 6 calendar views available
- Touch drag & drop support

**Desktop (>= 1024px)**
- Full mouse drag & drop (create, move, resize)
- All features enabled

**Responsive Admin Pages**
- Dashboard: hidden columns on mobile, scrollable table
- Resources: responsive modals and grids
- Blocks: scrollable table, responsive form
- Settings & Login: adaptive padding and margins

---

### Unavailability Blocks

- Edit blocks (previously create/delete only)
- Multi-day blocks display hatched pattern on ALL covered days
- Blocks visible in ALL calendar views (month, week, day, timeline, resource grids)
- Correct timezone handling (local time → UTC conversion)

---

### Admin Improvements

**Pagination**
- Bookings, blocks, and resources paginated server-side (20 per page)
- Filters and page number persisted in URL (restored on refresh)

**Booking Management**
- Restore button: set cancelled bookings back to confirmed
- Permanent delete: removes booking, custom field values, and uploaded files

**Resource Search**
- Search bar filters resources by name

**Block Management**
- Resource filter dropdown
- Edit button with pre-filled form

---

### Bug Fixes

- Multi-select validation: supports both JSON arrays and comma-separated values
- Options format parsing: `Label|duration|price` correctly separated
- No more `|||` artifacts when editing fields without duration/price
- Timeline drag-to-move: cancelled when dropped outside valid area
- Event action icons: enlarged and properly centered in timeline view
- Image URL detection: supports picsum.photos, unsplash.com, etc.

---

## V1.0 — March 2026

Initial release:

- Custom calendar with 6 views (month, week, day, timeline, resource month, resource grid)
- Full drag & drop (create, move, resize bookings)
- Multi-day events with continuation bars
- Overlap side-by-side display
- "+N more" popover in month view
- Client booking flow with conflict detection (409)
- Email notifications (confirmation, admin notification, D-1 reminder)
- Admin dashboard with filters and pagination
- Resource CRUD with time slot configuration
- Unavailability block management
- Settings page (name, logo, colors, SMTP, iframe widget)
- JWT authentication
- Docker infrastructure (PostgreSQL 16, Mailpit, nginx)
- Makefile with all commands
- Demo seed data
