// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flyin/controllers/storageController.dart';
// import 'package:uuid/uuid.dart';

// import '../models/post.dart';

// class firestoreMethods {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<String> uploadPost(String description, Uint32List file, String uid,
//       String username, String profImage) async {
//     // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
//     String res = "Some error occurred";
//     try {
//       String photoUrl =
//           await StorageMethods().uploadImageToStorage('posts', file, true);
//       String postId = const Uuid().v1(); // creates unique id based on time
//       Post post = Post(
//         description: description,
//         uid: uid,
//         username: username,
//         likes: [],
//         postId: postId,
//         datePublished: DateTime.now(),
//         postUrl: photoUrl,
//         profImage: profImage,
//         category: '',
//         location: '',
//         title: '',
//       );
//       _firestore.collection('posts').doc(postId).set(post.toJson());
//       res = "success";
//     } catch (err) {
//       res = err.toString();
//     }
//     return res;
//   }
// }
