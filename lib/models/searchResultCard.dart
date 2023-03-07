import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../screens/videoplayer.dart';
import 'package:flyin/screens/videoDetail.dart';
import '../models/post.dart';

class SearchResult extends StatefulWidget {
  final Post snap;
  const SearchResult({Key? key, required this.snap}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  //the birthday's date

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime date = widget.snap.datePublished!;
    final timestamp = date.millisecondsSinceEpoch;
    final timestampseconds = timestamp.toString().substring(0, 10) ;
    // print(timestampseconds);
    final DateTime date1 =
        DateTime.fromMillisecondsSinceEpoch( int.parse(timestampseconds) * 1000);
    //print(widget.snap.datePublished!.day);
    final date2 = DateTime.now();
    final difference = daysBetween(date1, date2);
   // print(difference);
    //2023-02-27 13:25:22.388
    // Timestamp(seconds=1677484522, nanoseconds=388000000)

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          child: Video(play: true, url: widget.snap.postUrl!),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoDetail(video: widget.snap)));
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(widget.snap.profImage!),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(widget.snap.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Flexible(
                        child: Text(widget.snap.location!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: white,
                            )),
                      ),
                      Flexible(
                        child: Text(
                            '${widget.snap.username} • 20k views •${difference + 1} days ago',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: white,
                              fontWeight: FontWeight.w100,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
