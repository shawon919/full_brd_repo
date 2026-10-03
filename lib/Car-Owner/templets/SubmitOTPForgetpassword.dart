import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class Submitotpforgetpassword extends StatelessWidget {
  const Submitotpforgetpassword({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Color(0xFF757575)),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "OTP Verification",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "We sent your code to +1 898 860 *** \nThis code will expired in 00:30",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF757575)),
                  ),
                  // const SizedBox(height: 16),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  OtpForm(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Resend OTP Code",
                      style: TextStyle(color: Color(0xFF757575)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class OtpForm extends StatelessWidget {
   OtpForm({super.key});

   
   final Usergetxcontroller signingetxcontroller = Get.put(
    Usergetxcontroller(),
  );
  

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
         Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: List.generate(6, (index) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        controller: signingetxcontroller.otpControllers[index] ,
        focusNode: signingetxcontroller.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,

        onChanged: (value)=>signingetxcontroller.onchangeOtp(value, index),

        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],

        style: Theme.of(context).textTheme.titleLarge,

        decoration: InputDecoration(
          hintText: "0",
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          border: authOutlineInputBorder,
          enabledBorder: authOutlineInputBorder,
          focusedBorder: authOutlineInputBorder.copyWith(
            borderSide: const BorderSide(color: Color(0xFFFF7643)),
          ),
        ),
      ),
    );
  }),
),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFFF7643),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
