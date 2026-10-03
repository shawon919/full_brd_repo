import 'package:flutter/material.dart';
import 'package:brd/hire_service/api/hire_service_api.dart';
import 'package:brd/hire_service/models/unpaid_salary_model.dart';

class DriverUnpaidSalaryPage extends StatefulWidget {
  const DriverUnpaidSalaryPage({super.key});
  @override State<DriverUnpaidSalaryPage> createState() => _DriverUnpaidSalaryPageState();
}

class _DriverUnpaidSalaryPageState extends State<DriverUnpaidSalaryPage> {
  final api = HireServiceApi();
  List<UnpaidSalaryModel> items = [];
  bool loading = true;

  @override void initState(){super.initState();load();}
  Future<void> load() async {
    setState(()=>loading=true);
    try{items=await api.getMyUnpaidSalary();}
    catch(e){if(mounted)ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.toString().replaceFirst('Exception: ',''))));}
    finally{if(mounted)setState(()=>loading=false);}
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF4F7F6),
      appBar:AppBar(title:const Text('Unpaid Salary'),backgroundColor:const Color(0xFF123B35),foregroundColor:Colors.white),
      body:RefreshIndicator(
        onRefresh:load,
        child:loading?const Center(child:CircularProgressIndicator()):items.isEmpty
          ?ListView(children:const[SizedBox(height:180),Center(child:Text('No unpaid salary.'))])
          :ListView.builder(
            padding:const EdgeInsets.all(16),itemCount:items.length,
            itemBuilder:(_,i){final x=items[i];return Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Row(children:[const Icon(Icons.pending_actions,color:Color(0xFFB7791F)),const SizedBox(width:10),Expanded(child:Text(x.billingMonth,style:const TextStyle(fontSize:18,fontWeight:FontWeight.w900))),Text('UNPAID',style:TextStyle(color:Colors.orange.shade800,fontWeight:FontWeight.w800))]),
              const Divider(height:24),
              Text('Salary: ৳${x.salaryAmount.toStringAsFixed(2)}',style:const TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
              const SizedBox(height:7),Text('Owner: ${x.ownerName.isEmpty?x.ownerEmail:x.ownerName}'),Text('Due date: ${x.dueDate}'),Text('Owner billing: ${x.ownerBillingStatus.toUpperCase()}'),
              const SizedBox(height:4),const Text('The driver does not need to make any payment.',style:TextStyle(color:Colors.black54)),
            ])));},
          ),
      ),
    );
  }
}
