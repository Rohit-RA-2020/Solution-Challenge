import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.green),
        elevation: 0,
        title: const Text(
          'Leaderboard 🏆',
          style: TextStyle(color: Colors.black, fontSize: 19),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .orderBy('emmision')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // return the header
                      return const LeaderBoardItems(
                        no: '',
                        name: 'Name',
                        emmision: 'Co2 / tons',
                        img: '',
                        isHeader: true,
                      );
                    }
                    index -= 1;
                    return LeaderBoardItems(
                      isHeader: false,
                      no: (index + 1).toString() + '.',
                      name: (snapshot.data! as dynamic).docs[index]['username'],
                      emmision: (snapshot.data! as dynamic)
                          .docs[index]['emmision']
                          .toString(),
                      img: (snapshot.data! as dynamic).docs[index]['photoUrl'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderBoardItems extends StatelessWidget {
  const LeaderBoardItems({
    required this.no,
    required this.name,
    required this.emmision,
    required this.img,
    required this.isHeader,
    Key? key,
  }) : super(key: key);

  final String no;
  final String img;
  final String name;
  final String emmision;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10),
            child: Text(
              no,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          img != ''
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                    img,
                  ),
                  radius: 16,
                )
              : Container(),
        ],
      ),
      title: Text(
        name,
        style: isHeader
            ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
            : null,
      ),
      trailing: Text(
        emmision,
        style: isHeader
            ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
            : null,
      ),
    );
  }
}
