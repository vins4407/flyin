import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyin/controllers/authcontroller.dart';
import 'package:flyin/controllers/storageController.dart';
import 'package:flyin/models/user.dart';
import 'package:flyin/screens/home.dart';
import 'package:flyin/screens/login.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/colors.dart';
import '../controllers/authcontroller.dart';
import '../controllers/authcontroller.dart';
import '../utils/utils.dart';

class userinfo extends StatefulWidget {
  static String id = 'signipScreen';
  const userinfo({super.key});

  @override
  State<userinfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<userinfo> {
  bool _isLoading = false;
  Uint8List? _image;

  // void signUpUser() async {
  //   // set loading to true
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   // signup user using our authmethodds
  //   String res = await AuthMethods().signUpUser(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //       username: _usernameController.text,
  //       bio: _bioController.text,
  //       file: _image!,
  //       phone: phone);
  //   // if string returned is sucess, user has been created
  //   if (res == "success") {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     // navigate to the home screen
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const homeScreen()),
  //     );
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     // show the error
  //     showSnackBar(context, res);
  //   }
  // }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController countryController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _bioController = TextEditingController();
    final PhoneAuthController loginController = Get.find();
    var auth = FirebaseAuth.instance;

    _phoneController.text = PhoneAuthController.usernumber.substring(3);

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('flyin',
                  style: TextStyle( color:white,fontSize: 40, fontFamily: "Pacifico")),
              const SizedBox(
                height: 34,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo,color: white),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 24,
              ),
              TextField(
                style: TextStyle(color: white),
                controller: _usernameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.blueGrey,
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(color:white)
                ),
                onSubmitted: (value) {
                  _usernameController.text = value;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                                style: TextStyle(color: white),

                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                                    hintStyle: TextStyle(color:white)

                ),
                onSubmitted: (value) {
                  _emailController.text = value;
                },
              ),
              const SizedBox(
                height: 24,
              ),

              const SizedBox(
                height: 24,
              ),
              TextField(
                                style: TextStyle(color: white),

                controller: _bioController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter your bio',
                                    hintStyle: TextStyle(color:white)

                ),
                onSubmitted: (value) {
                  _bioController.text = value;
                },
              ),

              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () async {
                  String photoUrl = await StorageMethods()
                      .uploadImageToStorage('profilePics', _image!, false);

                  UserInformation userdata = UserInformation(
                      username: _usernameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      photoUrl: photoUrl,
                      bio: _bioController.text,
                      uId: auth.currentUser?.uid);
                  loginController.createUser(userdata, const homeScreen());
                },
                child: Container(

                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: primaryColor,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Sign up',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold),
                        )
                      : const CircularProgressIndicator(
                          color: gColor,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
