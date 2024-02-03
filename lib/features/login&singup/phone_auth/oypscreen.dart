import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_post/features/homepage/home_page.dart';

class OTPScreen extends StatefulWidget {
  String verificationid;
  OTPScreen({super.key, required this.verificationid});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: otpController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                hintText: "Enter OTP",
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                          verificationId: widget.verificationid,
                          smsCode: otpController.text.toString());
                  FirebaseAuth.instance.signInWithCredential(credential).then((value){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  });
                } catch (e) {}
              },
              child: Text("Verify OTP"))
        ],
      ),
    ));
  }
}
