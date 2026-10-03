import 'package:flutter/material.dart';
import '../api/hire_service_api.dart';
import '../models/unpaid_salary_model.dart';
import '../models/salary_payment_model.dart';

class AdminPendingSalaryPage extends StatefulWidget {
  const AdminPendingSalaryPage({super.key});
  @override State<AdminPendingSalaryPage> createState() => _AdminPendingSalaryPageState();
}
class _AdminPendingSalaryPageState extends State<AdminPendingSalaryPage> {
  final api = HireServiceApi(); List<UnpaidSalaryModel> items = []; bool loading = true;
  @override void initState(){super.initState();load();}
  Future<void> load() async { setState(()=>loading=true); try{items=await api.getAdminPendingDriverSalary();}catch(e){_msg(e);}finally{if(mounted)setState(()=>loading=false);} }
  void _msg(Object e)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.toString().replaceFirst('Exception: ',''))));
  Future<void> pay(UnpaidSalaryModel x) async {
    final tx=TextEditingController(); final notes=TextEditingController(); String method='bank';
    final ok=await showDialog<bool>(context:context,builder:(dialogContext)=>StatefulBuilder(builder:(context,setDialogState)=>AlertDialog(
      title:const Text('Give Salary'),
      content:SizedBox(width:430,child:Column(mainAxisSize:MainAxisSize.min,children:[
        Align(alignment:Alignment.centerLeft,child:Text('${x.driverName} • ${x.billingMonth}',style:const TextStyle(fontWeight:FontWeight.w800))),
        const SizedBox(height:8),Align(alignment:Alignment.centerLeft,child:Text('Salary: ৳${x.salaryAmount.toStringAsFixed(2)}',style:const TextStyle(fontSize:18,fontWeight:FontWeight.w900))),
        const SizedBox(height:16),TextField(controller:tx,decoration:const InputDecoration(labelText:'Transaction ID',border:OutlineInputBorder())),
        const SizedBox(height:12),DropdownButtonFormField<String>(value:method,decoration:const InputDecoration(labelText:'Payment method',border:OutlineInputBorder()),items:const[
          DropdownMenuItem(value:'bank',child:Text('Bank Transfer')),DropdownMenuItem(value:'mobile_banking',child:Text('Mobile Banking')),DropdownMenuItem(value:'cash',child:Text('Cash')),DropdownMenuItem(value:'other',child:Text('Other'))],onChanged:(v)=>setDialogState(()=>method=v??'bank')),
        const SizedBox(height:12),TextField(controller:notes,maxLines:2,decoration:const InputDecoration(labelText:'Notes (optional)',border:OutlineInputBorder())),
      ])),
      actions:[TextButton(onPressed:()=>Navigator.pop(dialogContext,false),child:const Text('Cancel')),ElevatedButton(onPressed:()=>Navigator.pop(dialogContext,true),child:const Text('Confirm Payment'))],
    )));
    if(ok!=true)return;
    if(tx.text.trim().isEmpty){_msg(Exception('Transaction ID is required.'));return;}
    try{final data=await api.payDriverSalary(billingUuid:x.billingUuid,transactionId:tx.text.trim(),paymentMethod:method,notes:notes.text);_msg(data['message']?.toString()??'Salary paid.');await load();}catch(e){_msg(e);}
  }
  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Pending Driver Salary')),
    body:RefreshIndicator(onRefresh:load,child:loading?const Center(child:CircularProgressIndicator()):items.isEmpty?ListView(children:const[SizedBox(height:180),Center(child:Text('No pending driver salaries.'))]):ListView.builder(
      padding:const EdgeInsets.all(20),itemCount:items.length,itemBuilder:(_,i){final x=items[i];return Card(child:ListTile(
        contentPadding:const EdgeInsets.all(16),leading:const CircleAvatar(child:Icon(Icons.payments_outlined)),title:Text(x.driverName,style:const TextStyle(fontWeight:FontWeight.w800)),
        subtitle:Text('${x.billingMonth}\nOwner: ${x.ownerName}\nDue: ${x.dueDate}'),isThreeLine:true,
        trailing:SizedBox(width:150,child:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.end,children:[Text('৳${x.salaryAmount.toStringAsFixed(2)}',style:const TextStyle(fontWeight:FontWeight.w900,fontSize:16)),const SizedBox(height:5),ElevatedButton(onPressed:()=>pay(x),child:const Text('Give Salary'))])),
      ));})),
  );
}

class AdminPaidSalaryPage extends StatefulWidget { const AdminPaidSalaryPage({super.key}); @override State<AdminPaidSalaryPage> createState()=>_AdminPaidSalaryPageState(); }
class _AdminPaidSalaryPageState extends State<AdminPaidSalaryPage>{
  final api=HireServiceApi(); List<SalaryPaymentModel> items=[]; bool loading=true;
  @override void initState(){super.initState();load();}
  Future<void>load()async{setState(()=>loading=true);try{items=await api.getAdminSalaryPayments();}catch(e){_msg(e);}finally{if(mounted)setState(()=>loading=false);}}
  void _msg(Object e)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.toString().replaceFirst('Exception: ',''))));
  void view(SalaryPaymentModel x){showDialog(context:context,builder:(_)=>AlertDialog(title:Text('${x.driverName.isEmpty?'Driver':x.driverName} — Payment'),content:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[_r('Amount','৳${x.amount.toStringAsFixed(2)}'),_r('Month',x.billingMonth),_r('Owner',x.ownerName.isEmpty?x.ownerEmail:x.ownerName),_r('Method',x.paymentMethod.replaceAll('_',' ')),_r('Transaction',x.transactionId),_r('Paid at',x.paidAt),_r('Status',x.status)]),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Close'))]));}
  Widget _r(String a,String b)=>Padding(padding:const EdgeInsets.only(bottom:9),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[SizedBox(width:95,child:Text(a,style:const TextStyle(color:Colors.black54))),Expanded(child:Text(b,style:const TextStyle(fontWeight:FontWeight.w700)))]));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paid Driver Salary')),
      body: RefreshIndicator(
        onRefresh: load,
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : items.isEmpty
                ? ListView(children: const [SizedBox(height: 180), Center(child: Text('No paid driver salaries yet.'))])
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final x = items[i];
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: const CircleAvatar(child: Icon(Icons.verified_rounded)),
                          title: Text(x.driverName.isEmpty ? 'Driver' : x.driverName, style: const TextStyle(fontWeight: FontWeight.w800)),
                          subtitle: Text('${x.billingMonth}\n${x.paymentMethod.replaceAll('_', ' ')} • ${x.transactionId}'),
                          isThreeLine: true,
                          trailing: SizedBox(
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('৳${x.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900)),
                                TextButton(onPressed: () => view(x), child: const Text('View')),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

class AdminUserSalaryPage extends StatefulWidget { final bool paid; const AdminUserSalaryPage({super.key,required this.paid}); @override State<AdminUserSalaryPage> createState()=>_AdminUserSalaryPageState(); }
class _AdminUserSalaryPageState extends State<AdminUserSalaryPage>{
  final api=HireServiceApi(); late Future<List<Map<String,dynamic>>> future;
  @override void initState(){super.initState();future=api.getAdminUserSalaryBillings(widget.paid?'paid':'pending');}
  double _num(dynamic v)=>v is num?v.toDouble():double.tryParse(v?.toString()??'')??0;
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:Text(widget.paid?'Users — Paid Salary':'Users — Pending Salary')),body:FutureBuilder<List<Map<String,dynamic>>>(future:future,builder:(_,s){
    if(s.connectionState!=ConnectionState.done)return const Center(child:CircularProgressIndicator());
    if(s.hasError)return Center(child:Text(s.error.toString()));
    final list=s.data??[];
    if(list.isEmpty)return Center(child:Text(widget.paid?'No users with paid salary billing.':'No users with pending salary billing.'));
    return ListView.builder(padding:const EdgeInsets.all(20),itemCount:list.length,itemBuilder:(_,i){final x=list[i];return Card(child:ListTile(title:Text((x['user_name']??x['user_email']??'User').toString(),style:const TextStyle(fontWeight:FontWeight.w800)),subtitle:Text('Driver: ${(x['driver_name']??'').toString()}\nMonth: ${(x['billing_month']??'').toString()}\nStatus: ${(x['status']??'').toString()}'),isThreeLine:true,trailing:Text('৳${_num(x['amount']).toStringAsFixed(2)}',style:const TextStyle(fontWeight:FontWeight.w900))));});
  }));
}
