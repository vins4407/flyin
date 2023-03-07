import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../screens/videoplayer.dart';
import '../models/post.dart';

class VideoDetail extends StatelessWidget {
  final Post video;

  VideoDetail({required this.video});

int commentLen = 0;
  bool isLikeAnimating = false;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  //the birthday's date


  @override
  Widget build(BuildContext context) {
    final DateTime date = video.datePublished!;
    final timestamp = date.millisecondsSinceEpoch;
    final timestampseconds = timestamp.toString().substring(0, 10) ;
    // print(timestampseconds);
    final DateTime date1 =
        DateTime.fromMillisecondsSinceEpoch( int.parse(timestampseconds) * 1000);
    //print(video.datePublished!.day);
    final date2 = DateTime.now();
    final difference = daysBetween(date1, date2);
   // print(difference);
    //2023-02-27 13:25:22.388
    // Timestamp(seconds=1677484522, nanoseconds=388000000)

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                height: 250,
                child: Video(play: true, url: video.postUrl!),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      foregroundImage: NetworkImage(video.profImage!),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(video.title!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Flexible(
                            child: Text(video.location!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: white,
                                )),
                          ),
                          Flexible(
                            child: Text(
                                '${video.username} • 20k views •${difference + 1} days ago',
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

             Flexible(
                            child: Text('comments ',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
          ],
        ),
      ),
    );
  }
}
