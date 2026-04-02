# Custom Fields — Booking System

Complete documentation for the custom fields system introduced in V1.1.

---

## Overview

The custom fields system allows each resource to have its own booking form. An admin can define specific fields for each resource (e.g., "Number of adults" for a hotel, "Service" for a hairdresser, "Reason for visit" for a doctor).

---

## The 19 Field Types

| Type | HTML Input | Storage Format | Display in Modal | Validation |
|---|---|---|---|---|
| `text` | `<input type="text">` | Plain text | Text | Required if set |
| `textarea` | `<textarea>` | Plain text (multiline) | Multiline text | Required if set |
| `number` | `<input type="number">` | Number (string) | Number | Required if set, min/max if configured |
| `select` | `<select>` | Selected option value | Option text | Required if set |
| `multi-select` | `<select multiple>` | JSON array (`["a","b"]`) or comma-separated values (`"a,b"`) | Formatted list (bullets or commas) | Required if set, at least 1 value |
| `radio` | `<input type="radio">` | Selected option value | Option text | Required if set |
| `date` | `<input type="date">` | ISO format `YYYY-MM-DD` | Formatted date | Required if set |
| `time` | `<input type="time">` | Format `HH:MM` | Formatted time | Required if set |
| `datetime-local` | `<input type="datetime-local">` | ISO format `YYYY-MM-DDTHH:MM` | Formatted date and time | Required if set |
| `email` | `<input type="email">` | Text (email address) | Mailto link | Required if set, email format |
| `tel` | `<input type="tel">` | Text (phone number) | Tel link | Required if set |
| `url` | `<input type="url">` | Text (URL) | Clickable link | Required if set, URL format |
| `color` | `<input type="color">` | Hex code (`#FF0000`) | Color swatch | Required if set |
| `range` | `<input type="range">` | Number (string) | Numeric value | Required if set, min/max |
| `file` | `<input type="file">` | File URL (MinIO path) | Image preview or download link | Required if set, max size 10 MB, restricted types |
| `checkbox` | `<input type="checkbox">` | `"true"` or `"false"` | Yes/No (translated per language) | No specific validation |
| `hidden` | `<input type="hidden">` | Plain text | Not displayed | None |
| `address` | Enhanced text field | Text (full address) | Formatted address | Required if set |
| `video` | Video URL field | Video URL (YouTube, Vimeo, etc.) | Embedded video (iframe) | Required if set, URL format |

---

## Data Model

### `custom_fields` Table

| Field | Type | Description |
|---|---|---|
| `id` | INTEGER (PK) | Unique identifier |
| `resource_id` | INTEGER (FK) | Associated resource |
| `label` | STRING | Field label (displayed in the form) |
| `type` | STRING | Field type among the 19 types listed above |
| `required` | BOOLEAN | Whether the field is mandatory |
| `options` | JSON | Options for select, multi-select, radio (array of values) |
| `placeholder` | STRING | Placeholder text in the field |
| `sort_order` | INTEGER | Display order in the form |
| `created_at` | TIMESTAMP | Creation date |
| `updated_at` | TIMESTAMP | Last modified date |

### `booking_values` Table

| Field | Type | Description |
|---|---|---|
| `id` | INTEGER (PK) | Unique identifier |
| `booking_id` | INTEGER (FK) | Associated booking |
| `field_id` | INTEGER (FK) | Associated custom field |
| `value` | TEXT | Value entered by the client |

Values are always stored as plain text in the `value` column. The field type determines how the value is interpreted and displayed.

---

## Field Administration (AdminResources)

### Creating a Custom Field

1. Go to **Admin > Resources**
2. Click on an existing resource to edit it
3. In the "Custom Fields" section, click **Add a field**
4. Fill in:
   - **Label**: name displayed in the form (e.g., "Number of adults")
   - **Type**: choose from the 19 types
   - **Required**: yes/no
   - **Placeholder**: hint text (optional)
   - **Options**: for `select`, `multi-select`, `radio` types — define the list of values
5. Save

### Reordering Fields

Fields can be reordered via the `PUT /api/admin/custom-fields-reorder` endpoint. The order defined by `sort_order` determines the display order in the form.

### Editing / Deleting a Field

- Edit: `PUT /api/admin/custom-fields/:id`
- Delete: `DELETE /api/admin/custom-fields/:id` (associated booking_values are preserved)

---

## File Upload Flow (MinIO)

### Architecture

```
Client (browser)
    |
    | POST /api/upload  (multipart/form-data)
    |
    v
API (Express + Multer)
    |
    | PutObject
    |
    v
MinIO (S3-compatible)
    |
    | Public URL returned
    |
    v
Client (stores the URL in booking_values.value)
```

### Detailed Steps

1. The user selects a file via the `type="file"` input
2. The frontend sends a `POST /api/upload` request as `multipart/form-data`
3. The API validates:
   - **Size**: maximum 10 MB (translated error message if exceeded)
   - **MIME type**: list of allowed types (translated error message if not allowed)
4. The file is sent to MinIO via the S3 SDK
5. The API returns the public URL of the file
6. The frontend displays a preview (if image) and stores the URL in the field
7. On form submission, the URL is saved in `booking_values.value`

### Nginx Configuration

```nginx
client_max_body_size 10m;
```

This directive is required for nginx to accept requests larger than 1 MB (the default size).

### Image Size Controls

For `file` type fields containing an image, the form provides sliders:
- **W (Width)**: controls the display width
- **H (Height)**: controls the display height

These controls are stacked vertically on mobile.

---

## Image Detection (Display Logic)

The detail modal determines whether a value is an image based on two criteria:

### 1. File Extension Detection

Recognized extensions: `.jpg`, `.jpeg`, `.png`, `.gif`, `.webp`, `.svg`, `.bmp`, `.ico`

### 2. URL Pattern Detection

URLs recognized as images even without an explicit extension:
- `picsum.photos` (e.g., `https://picsum.photos/200/300`)
- `unsplash.com` / `images.unsplash.com`
- Any domain serving images via CDN with resize parameters

If a value is detected as an image, it is displayed as a preview in the modal. Otherwise, it is displayed as a download link.

---

## Multi-Select Storage Formats

The `multi-select` field supports two storage formats to ensure backward compatibility:

### Format 1: JSON Array (preferred)

```json
["Option A", "Option B", "Option C"]
```

### Format 2: Comma-Separated Values

```
Option A,Option B,Option C
```

Both formats are handled transparently during validation and display. On save, the JSON format is used by default.

---

## i18n Error Messages

Upload error messages are translated into all 13 supported languages:

| Key | Example (en) |
|---|---|
| File too large | "The file exceeds the maximum allowed size (10 MB)" |
| File type not allowed | "This file type is not allowed" |

Languages: en, fr, de, es, it, pt, nl, pl, ru, ar, ja, zh, tr
