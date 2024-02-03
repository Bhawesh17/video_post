
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_post/constants/constants.dart';
import 'package:video_post/features/app/router_constants.dart';
import 'package:video_post/features/homepage/home_page.dart';
import 'package:video_post/features/login&singup/phone_auth/login_with_number.dart';
import 'package:video_post/features/login&singup/sing_up/singup.dart';

import 'package:video_post/utils/utils.dart';
import 'package:video_post/widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController =
  new TextEditingController();
  TextEditingController passwordNameTextEditingController =
  new TextEditingController();

  final _auth = FirebaseAuth.instance;


  @override
  void login(BuildContext context) async {
    try {
      // We will write our login code here
      await _auth.signInWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordNameTextEditingController.text);
      //this will show successfuil message
      //Navigator.pop(context);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("Login Successfully")));
      Utils().toastmessage("Loged In Successfully");
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => HomeScreen()),(route) => true,);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    passwordNameTextEditingController.dispose();
    emailTextEditingController.dispose();

    super.dispose();
  }



  //page code start now
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of an input field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontFamily: "Shizuru",
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: const Color(0xFFff4600).withOpacity(0.5),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                ' CLIP - UP ',
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w900,
                                ),
                                speed: const Duration(milliseconds: 100),
                              ),
                            ],
                            totalRepeatCount: 1,
                            pause: const Duration(milliseconds: 1000),
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 38.0,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              controller: emailTextEditingController,
                              onChanged: (value) {
                                //Do something with the user input.
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your email',
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Icon(Icons.alternate_email_outlined),
                                  )),
                              validator: (val) {
                                return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                    ? null
                                    : "Please Enter Correct Email";
                              },
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                              obscureText: true,
                              textAlign: TextAlign.center,
                              controller: passwordNameTextEditingController,
                              onChanged: (value) {
                                //Do something with the user input.
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your password.',
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Icon(Icons.lock_outlined),
                                  )),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please Enter Password';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        padding:
                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RoundedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhoneAuthSate()));
                            },
                            backgroundcolor: Colors.white,
                            color: Colors.black,
                            title: 'Phone.No - Login',
                          ),
                        ),
                        Expanded(
                          child: RoundedButton(
                            backgroundcolor: Colors.lightBlueAccent,
                            color: Colors.white,
                            title: 'Sign In',
                            onPressed: () {
                              // Dismiss the keyboard when tapping outside of an input field
                              FocusScope.of(context).unfocus();
                              // Navigator.pop(context);
                              // Navigator.pushNamed(
                              //     context, RouterConstants.HomeScreenRoute);
                              if (_formKey.currentState!.validate()) {
                                login(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingUp()));
                          },
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
