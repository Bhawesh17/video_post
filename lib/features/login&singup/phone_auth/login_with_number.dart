import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_post/features/login&singup/phone_auth/oypscreen.dart';

class PhoneAuthSate extends StatefulWidget {
  const PhoneAuthSate({super.key});

  @override
  State<PhoneAuthSate> createState() => _PhoneAuthSateState();
}

class _PhoneAuthSateState extends State<PhoneAuthSate> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phoneController,
            //  keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                String phoneNumber = '+91${phoneController.text.trim()}';
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verificationid, int? resendtoeken) {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OTPScreen(verificationid: verificationid,) ));
                    },
                    codeAutoRetrievalTimeout: (String verificationid) {},
                    phoneNumber: phoneNumber);
              },
              child: Text("Verify phone Number"))
        ],
      ),
    ));
  }
}
