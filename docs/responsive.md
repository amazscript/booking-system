# Responsive Design — Booking System

Documentation for the responsive design strategy introduced in V1.1.

---

## Breakpoint Strategy

| Category | Range | Reactive Variable | Target Devices |
|---|---|---|---|
| **Mobile** | < 640px | `isMobile = true` | Phones (iPhone, Android) |
| **Tablet** | 640px - 1023px | `isTablet = true` | iPad, Android tablets |
| **Desktop** | >= 1024px | `isMobile = false`, `isTablet = false` | Desktop computers, laptops |

Breakpoints are computed reactively and updated on window resize.

---

## Adaptations by Breakpoint

### Toolbar (Calendar Toolbar)

| Element | Mobile (< 640px) | Tablet (640-1023px) | Desktop (>= 1024px) |
|---|---|---|---|
| View selector | Dropdown `<select>` | Buttons | Buttons |
| Navigation buttons | Compact | Compact | Full |
| Print button | Hidden | Visible | Visible |
| Today button | Visible | Visible | Visible |

### Available Views

| View | Mobile | Tablet | Desktop |
|---|---|---|---|
| Month | Yes (adapted) | Yes | Yes |
| Week | No (redirects to Day) | Yes | Yes |
| Day | Yes (adapted) | Yes | Yes |
| Resource Timeline | No (redirects to Day) | Yes | Yes |
| Resource DayGrid | Yes | Yes | Yes |
| Resource TimeGrid | No (redirects to Day) | Yes | Yes |

Redirection is automatic: if the user is on an unsupported view and resizes the window to mobile, the view automatically switches to Day.

### Day Names

| Breakpoint | Format | Example |
|---|---|---|
| Mobile | 1 letter | M, T, W, T, F, S, S |
| Tablet/Desktop | Full or abbreviated | Mon, Tue, Wed, Thu, Fri, Sat, Sun |

---

## Month View on Mobile

On mobile, the Month view is completely redesigned:

### Colored Dots (Replace Event Pills)

Instead of displaying event pills (which would take up too much space), each day displays small colored dots. The color corresponds to the booking's resource.

### Bottom Sheet on Tap

When the user taps on a day:
1. A **bottom sheet** slides up from the bottom of the screen
2. It displays the list of events for the selected day
3. Each event can be tapped to view its details

### CSS Dimensions

- Month cell: `min-height: 56px`

---

## Day View on Mobile

| Action | Behavior |
|---|---|
| Tap on an event | Opens the detail modal (eye icon) |
| Tap on an empty cell | Creates a 1-hour booking at that time slot |

### CSS Dimensions

- Hour cell: `44px` width
- Event pill: `min-height: 22px`

---

## Touch Interactions

### Swipe (Navigation)

| Gesture | Action |
|---|---|
| Swipe left | Next period (next month/week/day) |
| Swipe right | Previous period |

Swipe works on all views and all mobile/tablet breakpoints.

### Tap-to-Create (Mobile Only)

On mobile, drag-to-select is disabled. Instead:
- **Day view**: tap on an empty cell = create a 1-hour booking

### Tap-to-View (Mobile Only)

- **Day view**: tap on an event = open the detail modal
- **Month view**: tap on a day = bottom sheet with the event list

### Touch Drag (Tablet Only)

On tablet, drag & drop remains functional thanks to touch support:

- `addDragListeners()`: registers `touchstart`, `touchmove`, `touchend` listeners
- `removeDragListeners()`: cleans up listeners on component unmount
- `getPointerCoords()`: utility function that normalizes coordinates between:
  - `MouseEvent` (desktop): uses `clientX`, `clientY`
  - `TouchEvent` (tablet): uses `touches[0].clientX`, `touches[0].clientY`

---

## Event Pills

| Property | Mobile | Desktop |
|---|---|---|
| Text size | Larger (readability) | Standard size |
| Displayed content | Client name | Client name + time |
| EventActions (icons) | Hidden (`hidden sm:inline-flex`) | Visible (eye, pencil, trash) |
| Min-height | 22px | Standard |

---

## Hamburger Menu

In the navbar (`App.vue`), a hamburger menu replaces horizontal navigation on mobile:

- **Visible**: on mobile only (< 640px)
- **Content**: links to admin pages (Dashboard, Resources, Blocks, Settings)
- **Behavior**: tap to open/close the menu

---

## Forms and Modals

### BookingForm

| Element | Mobile | Desktop |
|---|---|---|
| Date/time grid | 1 column | 2 columns side by side |
| Padding | Reduced | Standard |
| Image size sliders (W/H) | Stacked vertically | Side by side |

### Detail Modal

| Element | Mobile | Desktop |
|---|---|---|
| Layout | 1 column | 2 columns |

### Resource Selector

| Breakpoint | Behavior |
|---|---|
| Mobile | Horizontal scroll (overflow-x) |
| Desktop | Full display, line wrapping |

### Action Buttons

| Breakpoint | Layout |
|---|---|
| Mobile | Stacked vertically (flex-col) |
| Desktop | Side by side (flex-row) |

---

## Responsive Admin Pages

| Page | Mobile Adaptations |
|---|---|
| `AdminDashboard` | Secondary columns hidden, horizontally scrollable table |
| `AdminResources` | Responsive modals and grids (adaptive columns) |
| `AdminBlocks` | Scrollable form, responsive layout |
| `AdminSettings` | Reduced padding |
| `AdminLogin` | Adaptive margins |

---

## CSS Utilities

### `scrollbar-hide` Class

Hides scrollbars while preserving scroll functionality:

```css
.scrollbar-hide::-webkit-scrollbar {
  display: none;
}
.scrollbar-hide {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
```

### Key Dimensions

| Element | Value |
|---|---|
| Month cell (mobile) | min-height: 56px |
| Day hour cell (mobile) | 44px width |
| Event pill (mobile) | min-height: 22px |
| Timeline labels (mobile) | Reduced size |
