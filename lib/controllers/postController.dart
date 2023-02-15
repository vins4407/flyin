import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyin/controllers/authcontroller.dart';
import 'package:flyin/screens/addpost.dart';
import 'package:get/get.dart';

import '../models/post.dart';

class PostController extends GetxController {
  static Map<String, dynamic> postData = {};

  var auth = FirebaseAuth.instance;
  final _instance = FirebaseFirestore.instance;

  createPost(Post postdata, Widget screen, String postId) async {
    //final prefs = await SharedPreferences.getInstance();
   
    //await prefs.setString('action', uid);
    final docuser = FirebaseFirestore.instance.collection('PostInfo').doc(postId);
    final json = postdata.toJson();
    await docuser.set(json).whenComplete(
          () => Get.offAll(screen),
        );
  }

  Future<Post?> getPostdata() async {
    // final prefs = await SharedPreferences.getInstance();
    var docid = auth.currentUser?.uid.toString();
    // var docid = prefs.getString('action');
    final docUser = _instance.collection('PostInfo').doc(docid);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      postData = snapshot.data()!;
      return Post(uid: docid!).fromMap(snapshot.data()!);
    } else {
      return null;
    }
  }
}
