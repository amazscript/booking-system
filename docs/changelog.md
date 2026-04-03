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

### Email System

**Translated Emails (13 languages)**
- Confirmation, admin notification, D-1 reminder, and cancellation emails translated
- Locale saved per booking and used for email rendering
- RTL support for Arabic emails
- Dates formatted per locale

**Custom Fields in Emails**
- All custom field values included in every email (confirmation, notification, reminder, cancellation)
- Type-aware formatting: select/radio labels resolved, checkbox as Yes/No translated, multi-select as comma-separated labels, file as clickable link, address formatted, color with swatch, video/URL as links
- Hidden fields excluded from emails

**Cancellation Notification**
- Admin receives an email when a client cancels via the email link

---

### Public Booking Page

- New `/` home page for clients (resource selector, date picker, slot picker, booking form, confirmation)
- Calendar moved behind auth guard at `/admin/calendar`
- Admin navbar: Calendar link added
- Hamburger menu updated with calendar link

---

### Security

- **Helmet**: 10+ secure HTTP headers (CSP, HSTS, X-Frame-Options, X-Content-Type-Options, etc.)
- **Rate limiting**: login (5 attempts/15min), uploads (20/15min), global API (500/15min)
- **CORS**: restricted to configured origins (`CORS_ORIGINS` or `BASE_URL`)
- **Role verification**: `requireAdmin` middleware on all admin routes
- **JWT secret warning**: console warning if using default secret
- **Auto-logout**: axios interceptor redirects to `/login` on 401/403
- **Request guard**: admin requests verify token in localStorage before sending
- **Token validation**: on app startup, token is verified against the API

---

### Bug Fixes

- Multi-select validation: supports both JSON arrays and comma-separated values
- Options format parsing: `Label|duration|price` correctly separated
- No more `|||` artifacts when editing fields without duration/price
- Select/radio display: modal shows option label instead of raw value
- Multi-select display: blue tags with label resolution
- Timeline drag-to-move: cancelled when dropped outside valid area
- Timeline drag offset: accounts for cursor position relative to event start
- Week/day drag offset: same cursor offset fix
- Optimistic updates: move and resize update locally before API call (no visual jump)
- Event action icons: enlarged and properly centered in timeline view
- Image URL detection: supports picsum.photos, unsplash.com, etc.
- Mobile "undefined" fix: client_name checked before display
- Calendar month fetch: includes padding days (previous/next month visible in grid)
- Timezone fix: ±1 day padding on API queries to handle UTC offset for midnight events
- Resize constrained to same column in week view
- Timeline event overflow: events clipped to 24h when crossing midnight
- Date picker: click calendar title to jump to any date
- Popover resourceDayGrid: shows correct resource's events
- Resource selector: flex-wrap on desktop, no overflow
- Debounced resize listener: prevents multiple refetch during window resize

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
