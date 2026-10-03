# BRD Real-Time Driver Location + Map

## What is included

- Driver GPS is read with `geolocator`.
- Driver sends latitude/longitude over the authenticated service WebSocket every 5 seconds.
- Django validates that only the assigned driver can publish.
- Django stores the latest GPS position on `DriverService`.
- Owner/admin receive live WebSocket updates.
- A newly opened owner/admin map receives the persisted last-known location immediately.
- Flutter displays the position on OpenStreetMap using `flutter_map`; no Google Maps API key is required.
- The driver marker moves whenever a new GPS update arrives.

## Backend

Run the new migration inside the dashboard container:

```bash
docker compose -f docker-images.yml exec dashboard python manage.py migrate
```

Then restart the WebSocket/application containers if needed:

```bash
docker compose -f docker-images.yml restart myapp dashboard nginx
```

## Flutter

From the Flutter project directory:

```bash
flutter pub get
flutter run
```

The added packages are:

- `flutter_map`
- `latlong2`

Android already requests fine/coarse location and now explicitly requests Internet access.

## Runtime flow

```text
Driver GPS
   ↓
Flutter Geolocator
   ↓
Authenticated WebSocket
   ↓
Django Channels
   ↓
Save latest location + broadcast
   ↓
Owner/Admin WebSocket
   ↓
Flutter OpenStreetMap
   ↓
Live driver marker
```

## Important

The current driver-sharing implementation keeps sending while the BRD driver live-location screen is active. It is not a background/terminated-app tracking service. If the app is completely backgrounded or terminated, continuous tracking requires a separate Android foreground-service/iOS background-location implementation.
