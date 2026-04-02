# API Reference — Booking System

Complete documentation for all REST API endpoints (V1.1).

**Base URL**: `http://localhost:3000/api`

**Authentication**: Admin endpoints require a JWT token in the `Authorization: Bearer <token>` header.

---

## Public Endpoints (No Authentication Required)

### GET /api/health

Server health check.

**Response**: `200 OK`

```json
{ "status": "ok" }
```

---

### GET /api/resources

List of active resources.

**Response**: `200 OK`

```json
[
  {
    "id": 1,
    "name": "Meeting Room A",
    "description": "10-seat room with projector",
    "capacity": 10,
    "color": "#3B82F6",
    "active": true
  }
]
```

---

### GET /api/resources/:id/slots

Available time slots for a resource on a given date.

**Query Parameters**:

| Parameter | Type | Required | Description |
|---|---|---|---|
| `date` | string | Yes | Date in `YYYY-MM-DD` format |

**Example**: `GET /api/resources/1/slots?date=2026-04-15`

**Response**: `200 OK`

```json
[
  { "start": "09:00", "end": "10:00" },
  { "start": "10:00", "end": "11:00" },
  { "start": "14:00", "end": "15:00" }
]
```

---

### GET /api/resources/:id/fields

Custom fields for a resource (for the booking form).

**Example**: `GET /api/resources/1/fields`

**Response**: `200 OK`

```json
[
  {
    "id": 1,
    "resource_id": 1,
    "label": "Number of adults",
    "type": "number",
    "required": true,
    "options": null,
    "placeholder": "E.g.: 2",
    "sort_order": 1
  },
  {
    "id": 2,
    "resource_id": 1,
    "label": "Breakfast",
    "type": "checkbox",
    "required": false,
    "options": null,
    "placeholder": "",
    "sort_order": 2
  }
]
```

---

### GET /api/resources/bookings/public

Public bookings (without client personal data).

**Query Parameters**:

| Parameter | Type | Required | Description |
|---|---|---|---|
| `date_from` | string | Yes | Start date (YYYY-MM-DD) |
| `date_to` | string | Yes | End date (YYYY-MM-DD) |

**Example**: `GET /api/resources/bookings/public?date_from=2026-04-01&date_to=2026-04-30`

**Response**: `200 OK`

```json
[
  {
    "id": 1,
    "resource_id": 1,
    "start_at": "2026-04-15T09:00:00.000Z",
    "end_at": "2026-04-15T10:00:00.000Z",
    "status": "confirmed",
    "color": "#3B82F6"
  }
]
```

---

### GET /api/resources/blocks/public

Public blocks/unavailabilities.

**Query Parameters**:

| Parameter | Type | Required | Description |
|---|---|---|---|
| `date_from` | string | Yes | Start date (YYYY-MM-DD) |
| `date_to` | string | Yes | End date (YYYY-MM-DD) |

**Response**: `200 OK`

```json
[
  {
    "id": 1,
    "resource_id": 1,
    "start_at": "2026-04-20T00:00:00.000Z",
    "end_at": "2026-04-22T23:59:00.000Z",
    "reason": "Holiday"
  }
]
```

---

### POST /api/bookings

Create a booking (client form).

**Request Body**:

```json
{
  "resource_id": 1,
  "client_name": "John Doe",
  "email": "john@example.com",
  "phone": "0612345678",
  "start_at": "2026-04-15T09:00:00",
  "end_at": "2026-04-15T10:00:00",
  "notes": "First visit",
  "color": "",
  "custom_values": [
    { "field_id": 1, "value": "2" },
    { "field_id": 2, "value": "true" }
  ]
}
```

**Success Response**: `201 Created`

```json
{
  "id": 1,
  "resource_id": 1,
  "client_name": "John Doe",
  "email": "john@example.com",
  "phone": "0612345678",
  "start_at": "2026-04-15T09:00:00.000Z",
  "end_at": "2026-04-15T10:00:00.000Z",
  "token": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "status": "confirmed",
  "notes": "First visit"
}
```

**Conflict Response**: `409 Conflict`

```json
{ "error": "This time slot is already booked for this resource" }
```

---

### DELETE /api/bookings/:token

Cancel a booking via the unique token (email link).

**Example**: `DELETE /api/bookings/a1b2c3d4-e5f6-7890-abcd-ef1234567890`

**Response**: `200 OK`

```json
{ "message": "Booking successfully cancelled" }
```

---

### POST /api/auth/login

Administrator login.

**Request Body**:

```json
{
  "email": "admin@booking.com",
  "password": "admin123"
}
```

**Response**: `200 OK`

```json
{
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": 1,
    "email": "admin@booking.com",
    "role": "admin"
  }
}
```

---

### GET /api/settings/public

Public settings (name, logo, colors).

**Response**: `200 OK`

```json
{
  "app_name": "My Booking",
  "logo_url": "/uploads/logo.png",
  "primary_color": "#3B82F6",
  "secondary_color": "#10B981"
}
```

---

### GET /api/geocode

Geocode an address (for `address` type fields).

**Query Parameters**:

| Parameter | Type | Required | Description |
|---|---|---|---|
| `address` | string | Yes | Address to geocode |

**Example**: `GET /api/geocode?address=10+rue+de+Rivoli+Paris`

**Response**: `200 OK`

```json
{
  "lat": 48.8566,
  "lng": 2.3522,
  "formatted_address": "10 Rue de Rivoli, 75004 Paris, France"
}
```

---

### POST /api/upload

Upload a file to MinIO (S3-compatible).

**Content-Type**: `multipart/form-data`

**Body**: `file` field containing the file to upload.

**Limits**:
- Maximum size: 10 MB
- Allowed types: images (jpg, png, gif, webp, svg), documents (pdf, doc, docx)

**Success Response**: `200 OK`

```json
{
  "url": "http://localhost:9000/booking/uploads/abc123-photo.jpg"
}
```

**Error Response (file too large)**: `413 Payload Too Large`

```json
{ "error": "The file exceeds the maximum allowed size (10 MB)" }
```

**Error Response (type not allowed)**: `400 Bad Request`

```json
{ "error": "This file type is not allowed" }
```

---

## Admin Endpoints (JWT Required)

All endpoints below require the header:

```
Authorization: Bearer <jwt_token>
```

---

### Bookings

#### GET /api/admin/bookings

List bookings with filters and pagination.

**Query Parameters**:

| Parameter | Type | Required | Description |
|---|---|---|---|
| `status` | string | No | Filter by status (`confirmed`, `cancelled`) |
| `resource_id` | integer | No | Filter by resource |
| `date_from` | string | No | Start date (YYYY-MM-DD) |
| `date_to` | string | No | End date (YYYY-MM-DD) |
| `page` | integer | No | Page number (default: 1) |
| `limit` | integer | No | Items per page (default: 20) |

**Response**: `200 OK`

```json
{
  "bookings": [
    {
      "id": 1,
      "resource_id": 1,
      "client_name": "John Doe",
      "email": "john@example.com",
      "phone": "0612345678",
      "start_at": "2026-04-15T09:00:00.000Z",
      "end_at": "2026-04-15T10:00:00.000Z",
      "status": "confirmed",
      "notes": "First visit",
      "Resource": { "id": 1, "name": "Room A", "color": "#3B82F6" }
    }
  ],
  "total": 45,
  "page": 1,
  "totalPages": 3
}
```

#### POST /api/admin/bookings

Create a booking manually (admin).

**Body**: same format as `POST /api/bookings`.

**Response**: `201 Created`

#### PUT /api/admin/bookings/:id

Update a booking.

**Request Body**:

```json
{
  "resource_id": 1,
  "client_name": "John Doe",
  "email": "john@example.com",
  "phone": "0612345678",
  "start_at": "2026-04-15T10:00:00",
  "end_at": "2026-04-15T11:00:00",
  "status": "confirmed",
  "notes": "Rescheduled by 1 hour",
  "color": "#EF4444"
}
```

**Response**: `200 OK`

#### DELETE /api/admin/bookings/:id

Cancel a booking (sets status to `cancelled`, does not delete).

**Response**: `200 OK`

```json
{ "message": "Booking cancelled" }
```

#### DELETE /api/admin/bookings/:id/permanent

Permanently delete a booking, its custom field values, and associated MinIO files.

**Response**: `200 OK`

```json
{ "message": "Booking permanently deleted" }
```

---

### Custom Field Values

#### GET /api/admin/booking-values/:bookingId

Retrieve custom field values for a booking.

**Example**: `GET /api/admin/booking-values/1`

**Response**: `200 OK`

```json
[
  {
    "id": 1,
    "booking_id": 1,
    "field_id": 1,
    "value": "2",
    "CustomField": {
      "id": 1,
      "label": "Number of adults",
      "type": "number"
    }
  },
  {
    "id": 2,
    "booking_id": 1,
    "field_id": 2,
    "value": "true",
    "CustomField": {
      "id": 2,
      "label": "Breakfast",
      "type": "checkbox"
    }
  }
]
```

---

### Resources

#### GET /api/admin/resources

List resources (active and inactive). Supports optional pagination and search.

| Param | Type | Description |
|---|---|---|
| `page` | number | Page number (enables pagination) |
| `limit` | number | Results per page (default: 20) |
| `search` | string | Filter by name (case-insensitive) |

Without `page`, returns all resources (backward-compatible for the public calendar).

**Response**: `200 OK`

```json
[
  {
    "id": 1,
    "name": "Room A",
    "description": "10-seat meeting room",
    "capacity": 10,
    "color": "#3B82F6",
    "active": true
  }
]
```

#### POST /api/admin/resources

Create a resource.

**Request Body**:

```json
{
  "name": "Room B",
  "description": "20-seat conference room",
  "capacity": 20,
  "color": "#10B981",
  "active": true
}
```

**Response**: `201 Created`

#### PUT /api/admin/resources/:id

Update a resource.

**Response**: `200 OK`

#### DELETE /api/admin/resources/:id

Delete a resource.

**Response**: `200 OK`

#### PUT /api/admin/resources-reorder

Reorder resources.

**Request Body**:

```json
{
  "order": [3, 1, 2]
}
```

**Response**: `200 OK`

---

### Time Slots

#### POST /api/admin/slots

Define time slots for a resource.

**Request Body**:

```json
{
  "resource_id": 1,
  "slots": [
    { "day_of_week": 1, "start_time": "09:00", "end_time": "18:00", "duration_min": 60 },
    { "day_of_week": 2, "start_time": "09:00", "end_time": "18:00", "duration_min": 60 },
    { "day_of_week": 3, "start_time": "09:00", "end_time": "18:00", "duration_min": 60 },
    { "day_of_week": 4, "start_time": "09:00", "end_time": "18:00", "duration_min": 60 },
    { "day_of_week": 5, "start_time": "09:00", "end_time": "17:00", "duration_min": 60 }
  ]
}
```

**Response**: `200 OK`

> Note: this endpoint replaces all existing slots for the given resource.

---

### Blocks / Unavailabilities

#### GET /api/admin/blocks

List blocks/unavailabilities with pagination.

| Param | Type | Description |
|---|---|---|
| `resource_id` | number | Filter by resource |
| `page` | number | Page number (default: 1) |
| `limit` | number | Results per page (default: 20) |

**Response**: `200 OK`

```json
[
  {
    "id": 1,
    "resource_id": 1,
    "start_at": "2026-04-20T00:00:00.000Z",
    "end_at": "2026-04-22T23:59:00.000Z",
    "reason": "Annual leave",
    "Resource": { "id": 1, "name": "Room A" }
  }
]
```

#### POST /api/admin/blocks

Create an unavailability block.

**Request Body**:

```json
{
  "resource_id": 1,
  "start_at": "2026-04-20T00:00:00",
  "end_at": "2026-04-22T23:59:00",
  "reason": "Annual leave"
}
```

**Response**: `201 Created`

#### PUT /api/admin/blocks/:id

Update an existing block. *(New in V1.1)*

**Request Body**:

```json
{
  "resource_id": 1,
  "start_at": "2026-04-20T00:00:00",
  "end_at": "2026-04-25T23:59:00",
  "reason": "Extended leave"
}
```

**Response**: `200 OK`

> Note: dates are converted to UTC using the `toLocalISO` function to correctly handle timezones.

#### DELETE /api/admin/blocks/:id

Delete a block.

**Response**: `200 OK`

```json
{ "message": "Block deleted" }
```

---

### Custom Fields

#### GET /api/admin/custom-fields

List all custom fields.

**Query Parameters**:

| Parameter | Type | Required | Description |
|---|---|---|---|
| `resource_id` | integer | No | Filter by resource |

**Response**: `200 OK`

```json
[
  {
    "id": 1,
    "resource_id": 1,
    "label": "Number of adults",
    "type": "number",
    "required": true,
    "options": null,
    "placeholder": "E.g.: 2",
    "sort_order": 1
  },
  {
    "id": 2,
    "resource_id": 1,
    "label": "Service",
    "type": "select",
    "required": true,
    "options": ["Haircut 30min $25", "Color 1h30 $60", "Highlights 2h $80"],
    "placeholder": "",
    "sort_order": 2
  }
]
```

#### POST /api/admin/custom-fields

Create a custom field.

**Request Body**:

```json
{
  "resource_id": 1,
  "label": "Number of adults",
  "type": "number",
  "required": true,
  "options": null,
  "placeholder": "E.g.: 2",
  "sort_order": 1
}
```

**Response**: `201 Created`

#### PUT /api/admin/custom-fields/:id

Update a custom field.

**Body**: same format as creation (fields to update).

**Response**: `200 OK`

#### DELETE /api/admin/custom-fields/:id

Delete a custom field.

**Response**: `200 OK`

```json
{ "message": "Custom field deleted" }
```

#### PUT /api/admin/custom-fields-reorder

Reorder custom fields.

**Request Body**:

```json
{
  "order": [3, 1, 2]
}
```

**Response**: `200 OK`

---

### Settings

#### GET /api/admin/settings

Read all settings.

**Response**: `200 OK`

```json
{
  "app_name": "My Booking",
  "logo_url": "/uploads/logo.png",
  "primary_color": "#3B82F6",
  "secondary_color": "#10B981",
  "smtp_host": "smtp.example.com",
  "smtp_port": "587",
  "smtp_user": "noreply@example.com",
  "smtp_pass": "***",
  "smtp_from": "noreply@example.com"
}
```

#### PUT /api/admin/settings

Update settings.

**Request Body**:

```json
{
  "app_name": "New Name",
  "primary_color": "#EF4444"
}
```

**Response**: `200 OK`

#### POST /api/admin/settings/test-smtp

Test the SMTP configuration (sends a test email).

**Success Response**: `200 OK`

```json
{ "message": "Test email sent successfully" }
```

**Error Response**: `500 Internal Server Error`

```json
{ "error": "Send failed: SMTP connection refused" }
```

#### POST /api/admin/settings/upload-logo

Upload a logo.

**Content-Type**: `multipart/form-data`

**Body**: `logo` field containing the image.

**Response**: `200 OK`

```json
{ "url": "/uploads/logo.png" }
```

#### GET /api/admin/settings/public

Public settings (also accessible without authentication via `GET /api/settings/public`).

---

## Endpoint Summary

### Public Endpoints (10)

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/health` | Health check |
| GET | `/api/resources` | List active resources |
| GET | `/api/resources/:id/slots` | Available time slots |
| GET | `/api/resources/:id/fields` | Custom fields for a resource |
| GET | `/api/resources/bookings/public` | Public bookings |
| GET | `/api/resources/blocks/public` | Public blocks |
| POST | `/api/bookings` | Create a booking |
| DELETE | `/api/bookings/:token` | Cancel via token |
| POST | `/api/auth/login` | Admin login |
| GET | `/api/settings/public` | Public settings |
| POST | `/api/upload` | File upload |
| GET | `/api/geocode` | Address geocoding |

### Admin Endpoints (22)

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/admin/bookings` | List bookings (filters + pagination) |
| POST | `/api/admin/bookings` | Create booking (admin) |
| PUT | `/api/admin/bookings/:id` | Update booking |
| DELETE | `/api/admin/bookings/:id` | Cancel booking (soft delete) |
| DELETE | `/api/admin/bookings/:id/permanent` | Permanently delete booking |
| GET | `/api/admin/booking-values/:bookingId` | Custom field values |
| GET | `/api/admin/resources` | List resources |
| POST | `/api/admin/resources` | Create resource |
| PUT | `/api/admin/resources/:id` | Update resource |
| DELETE | `/api/admin/resources/:id` | Delete resource |
| PUT | `/api/admin/resources-reorder` | Reorder resources |
| POST | `/api/admin/slots` | Define time slots |
| GET | `/api/admin/blocks` | List blocks |
| POST | `/api/admin/blocks` | Create block |
| PUT | `/api/admin/blocks/:id` | Update block *(V1.1)* |
| DELETE | `/api/admin/blocks/:id` | Delete block |
| GET | `/api/admin/settings` | Read settings |
| PUT | `/api/admin/settings` | Update settings |
| POST | `/api/admin/settings/test-smtp` | Test SMTP |
| POST | `/api/admin/settings/upload-logo` | Upload logo |
| GET | `/api/admin/custom-fields` | List custom fields |
| POST | `/api/admin/custom-fields` | Create field |
| PUT | `/api/admin/custom-fields/:id` | Update field |
| DELETE | `/api/admin/custom-fields/:id` | Delete field |
| PUT | `/api/admin/custom-fields-reorder` | Reorder fields |

### HTTP Response Codes

| Code | Meaning |
|---|---|
| `200` | Success |
| `201` | Successfully created |
| `400` | Invalid request (validation) |
| `401` | Not authenticated (JWT missing or expired) |
| `404` | Resource not found |
| `409` | Conflict (booking overlap) |
| `413` | File too large |
| `500` | Server error |
