import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flyin/utils/colors.dart';
import '../models/post.dart';
import 'package:flyin/controllers/authcontroller.dart';
import '../models/searchResultCard.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final userid = PhoneAuthController.useralldata['uId'];
  List<Post> _searchResult = [];
  bool _isSearching = false;

  void _searchVideos(String query) async {
    setState(() {
      _isSearching = true;
    });

    final snapshot = await FirebaseFirestore.instance
        .collection('PostInfo')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    final videos =
        snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();

    print(videos);

    setState(() {
      _searchResult = videos;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileSearchColor,
        title: Text('Search Videos'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              style: TextStyle(color: white),
              controller: _searchController,
             textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: white,
                hintStyle: TextStyle(color: white,fontWeight: FontWeight.w200),
                hintText: 'Search videos...',
                suffixIcon: IconButton(
                  onPressed: () => _searchController.clear(),
                  icon: Icon(Icons.clear),
                ),
              ),
            ),
          ),
          _isSearching
              ? CircularProgressIndicator()
              : ListView.builder(
                  
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _searchResult.length,
                  itemBuilder: (context, index) {
                    final video = _searchResult[index];
                    print(video.category);
                    return SearchResult(snap: video);
                  },
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _searchVideos(_searchController.text);
          print(_searchController.text);
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
