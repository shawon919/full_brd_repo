# BRD Salary + Service + Live Location Update

Implemented:
- Admin Active Services with Terminate Service.
- Terminated services remain in service history.
- Driver profile `is_booked` is released on termination and set when service starts.
- Active-service double assignment protection for driver and owner.
- Admin Operational Driver Locations.
- Driver Start/Stop Live Location using service-specific WebSocket.
- Owner assigned-driver live location and service history.
- Driver service history.
- Admin Driver Salary Pending and Paid sections.
- Admin Users Salary Pending and Users Salary Paid sections.
- Driver Unpaid Salary and Paid Salary sections.
- Salary amount fallback/backfill for older billing/payment records that stored 0.00.
- Android/iOS location permission declarations.

New API endpoints:
- GET /dashboard/dashboard/admin/driver-services/
- POST /dashboard/dashboard/admin/driver-service/<uuid>/terminate/
- GET /dashboard/dashboard/driver-service/history/
- GET /dashboard/dashboard/admin/salary-payments/pending/
- GET /dashboard/dashboard/admin/user-salary/pending/
- GET /dashboard/dashboard/admin/user-salary/paid/

WebSocket:
- wss://<host>/ws/service-location/<service_uuid>/?token=<access_token>
