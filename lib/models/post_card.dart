import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/videoplayer.dart';

class PostCard extends StatefulWidget {
  final snap;
  final index;
  const PostCard({Key? key, required this.snap, this.index}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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
    final Timestamp timestamp = widget.snap['datePublished'];
    // print(timestamp);
    final DateTime date1 =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    final date2 = DateTime.now();
    final difference = daysBetween(date1, date2);
    print(difference);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              alignment: Alignment.center,
              child: Container(
                key: new PageStorageKey(
                  widget.index,
                ),
                child: Video(play: true, url: widget.snap['postUrl']),
              ),
            ),
            // Positioned(
            //   bottom: 8.0,
            //   right: 20.0,
            //   child: Container(
            //     padding: const EdgeInsets.all(4.0),
            //     color: Colors.black,
            //     child: Text(
            //       '1:20',
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodySmall!
            //           .copyWith(color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => print('Navigate to profile'),
                child: CircleAvatar(
                  foregroundImage: NetworkImage(widget.snap['profImage']),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        widget.snap['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 15.0),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.snap['location'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 15.0),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '${widget.snap['username']} • 20k views •${difference + 1} days ago',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.more_vert, size: 20.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}
