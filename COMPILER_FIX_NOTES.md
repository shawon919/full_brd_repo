# Salary / Service Flutter Integration Fix

Fixed in this build:
- Added all HireServiceApi methods referenced by controllers/views.
- Added admin pending driver salary API integration.
- Added driver unpaid salary API integration.
- Added admin active driver services API integration.
- Added driver-service termination API integration.
- Added owner/driver service history API integration.
- Added admin user salary billing API integration.
- Fixed BillingModel fallback parsing (removed invalid named fallback argument).
- Fixed DriverServiceModel missing driverPhone and durationDays/durationMonths members.
- Fixed malformed AdminPaidSalaryPage widget expression.
- Backend unpaid salary response now falls back to DriverService.salary when Billing.driver_salary is zero.

Run locally:
  flutter pub get
  flutter analyze
