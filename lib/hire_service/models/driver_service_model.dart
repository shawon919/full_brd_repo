class DriverServiceModel {
  final String uuid, driverName, driverEmail, driverPhone, ownerName, ownerEmail, status, joiningDate, endingDate;
  final double salary;
  final int driverId, ownerId;
  DriverServiceModel({required this.uuid,required this.driverId,required this.driverName,required this.driverEmail,required this.driverPhone,required this.ownerId,required this.ownerName,required this.ownerEmail,required this.salary,required this.joiningDate,required this.endingDate,required this.status});
  int get durationDays { final start=DateTime.tryParse(joiningDate); if(start==null)return 0; final end=endingDate.isNotEmpty?DateTime.tryParse(endingDate):DateTime.now(); if(end==null)return 0; final d=end.difference(start).inDays+1; return d<1?1:d; }
  double get durationMonths => durationDays/30.0;
  factory DriverServiceModel.fromJson(Map<String,dynamic> j)=>DriverServiceModel(
    uuid:(j['service_uuid']??j['uuid']??'').toString(), driverId:_i(j['driver_id']), driverName:(j['driver_name']??'').toString(), driverEmail:(j['driver_email']??'').toString(), driverPhone:(j['driver_phone']??j['driver_phone_number']??'').toString(), ownerId:_i(j['owner_id']??j['user_id']), ownerName:(j['owner_name']??j['user_name']??'').toString(), ownerEmail:(j['owner_email']??j['user_email']??'').toString(), salary:_d(j['salary']??j['driver_salary']??j['salary_amount']), joiningDate:(j['joining_date']??'').toString(), endingDate:(j['ending_date']??'').toString(), status:(j['status']??'').toString());
  static int _i(dynamic v)=>int.tryParse(v?.toString()??'')??0;
  static double _d(dynamic v)=>v is num?v.toDouble():double.tryParse(v?.toString()??'')??0;
}
