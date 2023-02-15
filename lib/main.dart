import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flyin/screens/home.dart';
import 'package:flyin/screens/login.dart';

import 'package:get/get.dart';

import 'controllers/authcontroller.dart';
import 'controllers/postController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final phoneAuthController = Get.put(PhoneAuthController());
  final postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (BuildContext context) {
        
          PhoneAuthController().getUser();
          // HomeRef().rd();
        
        return FirebaseAuth.instance.currentUser != null
            ? const homeScreen()
            : const login();
      }),
      //initialRoute: login.id,
    );
  }
}
