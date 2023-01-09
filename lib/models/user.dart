import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation {
  final String? email;
  final String? photoUrl;
  final String? username;
  final String? bio;
  final String? phone;

  const UserInformation(
      {this.username, this.photoUrl, this.email, this.bio, this.phone});

  UserInformation fromMap(Map<String, dynamic> map) {
    return UserInformation(
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      bio: map['bio'],
      photoUrl: map['photourl'],
    );
  }

 static  UserInformation fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserInformation(
        username: snapshot["username"],
        email: snapshot["email"],
        photoUrl: snapshot["photoUrl"],
        bio: snapshot["bio"],
        phone: snapshot['phone']);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "phone": phone
      };
}
