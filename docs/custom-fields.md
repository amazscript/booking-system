# Custom Fields — Booking System

Complete documentation for the custom fields system introduced in V1.1.

---

## Overview

The custom fields system allows each resource to have its own booking form. An admin can define specific fields for each resource (e.g., "Number of adults" for a hotel, "Service" for a hairdresser, "Reason for visit" for a doctor).

---

## The 19 Field Types

| Type | Display | Storage | Modal Display |
|---|---|---|---|
| `text` | Text input | Plain text | Text |
| `textarea` | Multi-line text area | Plain text | Full-width text block |
| `number` | Number input | Number as string | Number |
| `select` | Dropdown (1 choice) | Option value (`"haircut"`) | Option label (`"Haircut"`) |
| `multi-select` | Checkboxes (multiple choices) | Comma-separated (`"yoga,pilates"`) | Blue tags |
| `radio` | Radio buttons (1 choice) | Option value (`"beginner"`) | Option label (`"Beginner"`) |
| `date` | Date picker | `YYYY-MM-DD` | Formatted date |
| `time` | Time picker | `HH:MM` | Formatted time |
| `datetime-local` | Date + time picker | `YYYY-MM-DDTHH:MM` | Formatted date and time |
| `email` | Email input | Email string | Email text |
| `tel` | Phone input | Phone string | Phone text |
| `url` | URL input | URL string | Clickable link |
| `color` | Color picker | Hex (`#FF0000`) | Color swatch + hex code |
| `range` | Slider | Number as string | Number |
| `file` | File upload (MinIO) | JSON `{"url","w","h"}` | Image preview or file link |
| `checkbox` | Toggle checkbox | `"true"` / `"false"` | Yes/No (translated) |
| `hidden` | Not visible | Plain text | Not displayed |
| `address` | Address autocomplete | JSON `{"street","city","postcode","country"}` | Formatted address |
| `video` | URL input | YouTube/Vimeo/Dailymotion URL | Embedded video player |

---

## Options Format (select, multi-select, radio)

The three choice-based field types (`select`, `multi-select`, `radio`) use the same options format.

### Basic format (label only)

One option per line:

```
Beginner
Intermediate
Advanced
```

This creates options where the label and value are derived from the text.

### Full format (label + duration + price)

```
Label|duration_in_minutes|price
```

Example:

```
Haircut|30|25
Coloring|90|60
Highlights|120|80
```

| Part | Meaning | Required |
|---|---|---|
| `Haircut` | Label displayed to the client | Yes |
| `30` | Duration in minutes (auto-adjusts booking end time) | No |
| `25` | Price (displayed next to the option) | No |

Duration and price are optional. These all work:

```
Haircut|30|25       → Label: Haircut, Duration: 30min, Price: 25
Haircut|30          → Label: Haircut, Duration: 30min, no price
Haircut             → Label: Haircut, no duration, no price
```

### How options are stored

Options are stored as JSON in the `custom_fields.options` column:

```json
[
  { "label": "Haircut", "value": "haircut", "duration": 30, "price": 25 },
  { "label": "Coloring", "value": "coloring", "duration": 90, "price": 60 },
  { "label": "Highlights", "value": "highlights", "duration": 120, "price": 80 }
]
```

The `value` is auto-generated from the label (lowercase, spaces replaced with hyphens).

### How selected values are stored

When a client selects an option, only the `value` is stored in `booking_values.value`:

- **select/radio**: `"haircut"` (single value)
- **multi-select**: `"yoga,pilates,meditation"` (comma-separated)

### How values are displayed in the detail modal

The modal resolves the stored value back to the label using the field's options:

- `"haircut"` → displays `"Haircut"`
- `"yoga,pilates"` → displays `[Yoga] [Pilates]` (blue tags)

### Example: Hair Salon

**Admin creates the field:**

- Field label: `Service`
- Type: `Dropdown`
- Required: Yes
- Options:
```
Haircut|30|25
Coloring|90|60
Highlights|120|80
```

**Client books:**
- Selects "Coloring" from the dropdown
- Booking end time automatically adjusts +90 minutes
- Value stored in DB: `"coloring"`

**Admin views booking:**
- Modal shows: `Service: Coloring`

### Example: Fitness Coach

**Admin creates the field:**

- Field label: `Goals`
- Type: `Multi-select`
- Required: Yes
- Options:
```
Weight loss
Muscle gain
Flexibility
Endurance
```

**Client books:**
- Checks "Weight loss" and "Flexibility"
- Value stored in DB: `"weight-loss,flexibility"`

**Admin views booking:**
- Modal shows: `Goals: [Weight loss] [Flexibility]`

### Difference between select, multi-select, and radio

| Type | Choices | Display | Use case |
|---|---|---|---|
| **Dropdown** (select) | 1 only | Dropdown menu | Many options, pick one (e.g., Service) |
| **Radio** | 1 only | Visible radio buttons | Few options, pick one (e.g., Level) |
| **Multi-select** | Multiple | Checkboxes | Pick several (e.g., Allergies, Goals) |

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
