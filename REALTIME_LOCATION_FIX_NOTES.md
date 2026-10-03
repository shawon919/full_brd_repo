# Real-time Location Fix

## What was fixed

1. Driver live location no longer starts automatically when the page opens.
2. The driver must explicitly press **Start Sharing**.
3. The app now checks whether device GPS/location is enabled.
4. The app requests location permission and clearly reports denied/blocked permission.
5. If permission is permanently blocked, the driver gets an **Settings** action to open app settings.
6. The app obtains the first real GPS position before changing the button to **Stop Sharing**.
7. GPS errors are displayed instead of being silently swallowed.
8. Location updates continue every 5 seconds while sharing is active.
9. The bottom location controls are inside a scrollable SafeArea to prevent the RenderFlex overflow seen on small screens.
10. Backend WebSocket and persistent latest-location logic are unchanged because the supplied backend already accepts the driver coordinates and stores them in DriverService.

## Driver operation

1. Open Driver Dashboard.
2. Open **Live Location**.
3. Turn on phone Location/GPS.
4. Allow location permission.
5. Press **Start Sharing**.
6. The first GPS coordinate is sent immediately.
7. A new coordinate is sent every 5 seconds.
8. Owner/Admin can open the corresponding Live Driver Location map and see the marker update.
