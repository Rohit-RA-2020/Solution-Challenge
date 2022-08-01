import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';

class CommentCard extends StatelessWidget {
  final dynamic snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(snap.data());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              snap.data()['profilePic'],
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: snap.data()['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        TextSpan(
                          text: ' ${snap.data()['text']}',
                          style: const TextStyle(
                            color: Color(0xFF474B4F),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        snap.data()['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Found something wrong'),
                      content: const Text(
                          'Do you want to report this comment?'),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Report',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            FireStoreMethods().reportComment(
                              snap['name'].toString(),
                              snap['uid'].toString(),
                              snap['commentId'].toString(),
                              snap['text'].toString(),
                            );
                            Navigator.of(context).pop();
                            showSnackBar(context, 'Comment reported');
                          },
                        ),
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
