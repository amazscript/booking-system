# CHANGELOG — Booking System

Version change history.

---

## V1.1 — April 2026

### Sprint 08: Custom Fields, i18n, File Uploads

**Internationalization (i18n)**
- Support for 13 languages: en, fr, de, es, it, pt, nl, pl, ru, ar, ja, zh, tr
- All frontend strings translated, including upload error messages

**19 Custom Field Types**
- Available types: `text`, `textarea`, `number`, `select`, `multi-select`, `radio`, `date`, `time`, `datetime-local`, `email`, `tel`, `url`, `color`, `range`, `file`, `checkbox`, `hidden`, `address`, `video`
- Each resource can have its own custom fields configured via the admin panel (AdminResources)

**File and Image Uploads**
- Upload to MinIO (S3-compatible) with real-time preview
- Width (W) and height (H) controls for images
- Size limit: 10 MB per file
- Restricted file types (configurable list)
- Error messages translated into all 13 languages: file too large, file type not allowed
- Nginx configuration: `client_max_body_size` set to `10m` to support uploads

**Value Display in the Detail Modal**
- Image preview (with URL detection: common extensions, picsum.photos, unsplash, etc.)
- Video embed
- Address formatting
- Color swatch
- Multi-select formatting
- Yes/No translation for checkboxes

**Fixes and Improvements**
- Fixed multi-select validation: support for JSON arrays and comma-separated values
- Improved image URL detection (supports picsum.photos, unsplash, etc.)

**Demo Data**
- `seed-demo.js`: rich data (6 resources, 31 custom fields, 25 bookings with Lorem Picsum images)
- Makefile commands: `make seed-demo`, `make reset-demo`

---

### Sprint 09: Responsive Design

**Responsive Breakpoints**
- `isMobile`: < 640px (phone)
- `isTablet`: 640-1023px (tablet)
- Desktop: >= 1024px

**Toolbar**
- View selector as a dropdown `<select>` on mobile (replaces buttons)
- Compact navigation buttons
- Print button hidden on mobile

**Calendar Views on Mobile**
- Only Month and Day views are available on phone
- Automatic switching: week, timeline, and resourceTimeGrid views redirect to Day view on mobile
- Single-letter day names on mobile (M, T, W, T, F, S, S)

**Month View on Mobile**
- Colored dots instead of event pills
- Bottom sheet on day tap to display details

**Day View on Mobile**
- Tap on an event = display details (modal)
- Tap on an empty cell = create a 1-hour booking

**Event Pills**
- Larger text, client name displayed on mobile
- `EventActions` hidden on mobile (`hidden sm:inline-flex`)

**Touch Navigation**
- Swipe left/right to navigate between periods (previous/next)
- Drag disabled on mobile, replaced by tap-to-create
- Touch drag support for tablets (`addDragListeners`/`removeDragListeners` with touch events)
- `getPointerCoords()` normalizes mouse and touch events

**Forms and Modals**
- `BookingForm`: date/time grid in single column on mobile, reduced padding
- Detail modal: single column on mobile
- Resource selector: horizontal scroll on mobile
- Action buttons: stacked vertically on mobile
- Image size controls (W/H sliders): stacked vertically on mobile

**Hamburger Menu**
- Hamburger menu in the `App.vue` navbar

**Responsive Admin Pages**
- `AdminDashboard`: hidden columns, horizontally scrollable table
- `AdminResources`: responsive modals and grids
- `AdminBlocks`: scrollable and responsive form
- `AdminSettings`: reduced padding
- `AdminLogin`: adaptive margins

**CSS**
- `month-cell`: min-height 56px
- `day-hour`: 44px width
- `event-pill`: min-height 22px
- Reduced timeline labels
- `scrollbar-hide` utility

---

### Sprint 10: Blocks and Bug Fixes

**Block Update Endpoint**
- New endpoint: `PUT /api/admin/blocks/:id`
- `updateBlock()` method added to the admin store

**Block Editing in the Interface**
- Edit button in `AdminBlocks`
- Pre-filled modal for editing an existing block

**Timezone Fix**
- Blocks are now saved with correct local-to-UTC conversion (`toLocalISO`)

**Improved Block Display**
- Multi-day blocks display the hatched pattern on ALL covered days (not just the start day)
- Blocks are rendered in ALL calendar views:
  - Month view: red indicator bar
  - Week and Day views: hatching
  - Timeline view: horizontal hatching
  - ResourceTimeGrid and ResourceDayGrid views: hatching

**Drag & Drop Fixes**
- Timeline drag-to-move: cancellation if the drop occurs outside a valid cell (`overValidCell` check)

**Visual Improvements**
- `EventActions`: icons enlarged to `w-3.5 h-3.5`, min-width/min-height 14px
- Timeline event pills: content centered with `justify-center`

---

### Sprint 11: Pagination, Search, Admin Improvements

**Pagination (API + Frontend)**
- `GET /api/admin/bookings`: already paginated (limit/offset)
- `GET /api/admin/blocks`: paginated with `findAndCountAll` (limit/offset)
- `GET /api/admin/resources`: paginated when `page` param is provided, backward-compatible (returns all without `page`)
- URL persistence for all admin pages: filters, search, and page number saved in query params

**AdminDashboard**
- Filters and pagination persisted in URL (`?status=confirmed&resource_id=18&page=2`)
- Restored on page refresh
- **Restore button**: cancelled bookings can be set back to `confirmed`
- **Delete button**: permanent deletion of a booking (removes booking, custom field values, and MinIO files)
- New API endpoint: `DELETE /api/admin/bookings/:id/permanent`

**AdminBlocks**
- Resource filter dropdown
- Pagination (20 per page) with Prev/Next buttons
- URL persistence (`?resource_id=18&page=2`)

**AdminResources**
- Search bar (filters by name, `iLike` on API)
- Pagination (20 per page) with Prev/Next buttons
- URL persistence (`?search=hair&page=2`)

**Translations**
- `admin.restore` added in 13 languages
- `resources.search` added in 13 languages

---

## V1.0 — March 2026

Initial release. Sprints 01 through 07:

| Sprint | Content |
|---|---|
| Sprint 01 | Public calendar (month/week/day views, navigation) |
| Sprint 02 | Client booking flow (form, validation, cancellation by token, 409 conflict detection) |
| Sprint 03 | Admin dashboard (JWT auth, resource CRUD, time slots) |
| Sprint 04 | SMTP email notifications (confirmation, admin notification) + block management |
| Sprint 05 | Settings page (name, logo, colors, SMTP, iframe widget) + D-1 reminder |
| Sprint 06 | Premium calendar (3 resource views, drag-to-select/move/resize, multi-day, overlap, EventActions) |
| Sprint 07 | Docker infrastructure (PostgreSQL 16, Mailpit, nginx, Makefile, seed) |
