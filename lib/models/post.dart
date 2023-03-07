import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? description;
  String? title;
  String? category;
  String? location;
  String uid;
  String? username;
  String? postId;
  DateTime? datePublished;
  String? postUrl;
  final String? profImage;

  Post({
    this.title,
    this.category,
    this.location,
    this.description,
    required this.uid,
    this.username,
    this.postId,
    this.datePublished,
    this.postUrl,
    this.profImage,
  });

  static Post frommap(Map<String, dynamic> map) {
    return Post(
      title: map['title'],
      category: map['category'],
      location: map['location'],
      description: map['description'],
      uid: map['uid'],
      username: map['username'],
      postId: map['postId'],
      datePublished: map['date'],
      postUrl: map['postUrl'],
      profImage: map['profImage'],
    );
  }
  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    print(data);
    return Post(
      description: data['description'],
      title: data['title'],
      category: data['category'],
      location: data['location'],
      uid: data['uid'],
      username: data['username'],
      postId: data['postId'],
      datePublished: data['datePublished'].toDate(),
      postUrl: data['postUrl'],
      profImage: data['profImage'],
    );
  }


  Post fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'],
      category: map['category'],
      location: map['location'],
      description: map['description'],
      uid: map['uid'],
      username: map['username'],
      postId: map['postId'],
      datePublished: map['date'],
      postUrl: map['postUrl'],
      profImage: map['profImage'],
    );
  }

  

  Map<String, dynamic> toJson() => {
        "description": description,
        "title": title,
        "category": category,
        "location": location,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}
