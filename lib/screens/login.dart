import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyin/screens/home.dart';
import 'package:flyin/screens/verify.dart';
import 'package:flyin/utils/colors.dart';
import 'package:get/get.dart';

import '../controllers/authcontroller.dart';

class login extends StatefulWidget {
  static const String id = 'loginScreen';
  static var verify = "";
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<login> {
  TextEditingController countryController = TextEditingController();
  final PhoneAuthController loginController = Get.find();

  var phone = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 28, right: 28),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Flyin',
                  style: TextStyle(
                      color: mobileBackgroundColor,
                      fontSize: 50,
                      fontFamily: "Pacifico")),
              const SizedBox(
                height: 34,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: ((value) {
                        phone = value;
                      }),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
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
                      // await FirebaseAuth.instance.verifyPhoneNumber(
                      //   phoneNumber: '${countryController.text + phone}',
                      //   verificationCompleted:
                      //       (PhoneAuthCredential credential) async {},
                      //   verificationFailed: (FirebaseAuthException e) {},
                      //   codeSent: (String verificationId, int? resendToken) {
                      //     login.verify = verificationId;
                      //     Navigator.pushNamed(context, verification.id);
                      //   },
                      //   codeAutoRetrievalTimeout: (String verificationId) {},
                      // );
                      loginController
                          .verifyPhone('${countryController.text + phone}');
                      Get.to(() => const verification());
                    },
                    child: Text("Send the code")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
