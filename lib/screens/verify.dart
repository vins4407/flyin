import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyin/screens/home.dart';
import 'package:flyin/screens/login.dart';
import 'package:flyin/screens/sign_up.dart';
import 'package:flyin/utils/colors.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/authcontroller.dart';

class verification extends StatefulWidget {
  static const String id = 'verificationScreen';

  const verification({super.key});

  @override
  State<verification> createState() => _verificationState();
}

class _verificationState extends State<verification> {
  final PhoneAuthController loginController = Get.find();

  var onTapRecognizer;

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: mobileBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: white,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/img1.png',
              //   width: 150,
              //   height: 150,
              // ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(color:white,fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  color:white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: true,
                animationType: AnimationType.slide,
                pinTheme: PinTheme(
                  
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                // backgroundColor: Colors.blue.shade50,
                enableActiveFill: false,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    code = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),

              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      // try {
                      //   PhoneAuthCredential credential =
                      //       PhoneAuthProvider.credential(
                      //           verificationId: login.verify, smsCode: code);
                      //   // Sign the user in (or link) with the credential
                      //   await auth.signInWithCredential(credential);
                      //   Navigator.pushNamedAndRemoveUntil(
                      //       context, homeScreen.id, (route) => false);
                      // } catch (e) {
                      //   print("wrong otp");
                      // }

                      loginController.verifyOtp(code, userinfo());
                    },
                    child: Text("Verify Phone Number" ,style: TextStyle(color:white),)),
              ),
              Row(
                children: [
                  TextButton(
                    
                      onPressed: (){},
                      child: Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color:Colors.white38, fontSize: 15),
                      )),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Didn't receive the code? ",
                    style: TextStyle(color: white, fontSize: 15),
                    children: [
                      TextSpan(
                          text: " RESEND",
                          recognizer: onTapRecognizer,
                          style: TextStyle(
                              color: Color(0xFF91D3B3),
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
