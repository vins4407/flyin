import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyin/screens/login.dart';
import 'package:flyin/screens/search_feed.dart';
import 'package:get/get.dart';
import '../models/post_card.dart';
import '../utils/colors.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileSearchColor,
      appBar: AppBar(
        backgroundColor: mobileSearchColor,
        centerTitle: false,
        title: const Text('flyin', style: TextStyle(fontFamily: "Pacifico")),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              icon: Icon(Icons.search)),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: white,
            ),
            onPressed: () async {
              await auth.signOut();
              if (auth.currentUser == null) {
                Get.offAll(() => login());
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('PostInfo').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              key: PageStorageKey(widget.key),
              //physics: NeverScrollableScrollPhysics(),
              addAutomaticKeepAlives: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                child: PostCard(
                  index: index,
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
