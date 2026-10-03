class UnpaidSalaryModel {
  final String billingUuid, serviceUuid, driverName, ownerName, ownerEmail, billingMonth, dueDate, ownerBillingStatus, salaryStatus;
  final double salaryAmount;
  UnpaidSalaryModel({required this.billingUuid,required this.serviceUuid,required this.driverName,required this.ownerName,required this.ownerEmail,required this.salaryAmount,required this.billingMonth,required this.dueDate,required this.ownerBillingStatus,required this.salaryStatus});
  factory UnpaidSalaryModel.fromJson(Map<String,dynamic> j)=>UnpaidSalaryModel(
    billingUuid:(j['billing_uuid']??'').toString(), serviceUuid:(j['service_uuid']??'').toString(), driverName:(j['driver_name']??'').toString(), ownerName:(j['owner_name']??'').toString(), ownerEmail:(j['owner_email']??'').toString(), salaryAmount:_d(j['salary_amount']??j['driver_salary']??j['amount']), billingMonth:(j['billing_month']??'').toString(), dueDate:(j['due_date']??'').toString(), ownerBillingStatus:(j['owner_billing_status']??'').toString(), salaryStatus:(j['salary_status']??'unpaid').toString());
  static double _d(dynamic v)=>v is num?v.toDouble():double.tryParse(v?.toString()??'')??0;
}
