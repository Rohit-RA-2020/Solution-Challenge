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
      body: const Center(
        child: Text('Leaderboard coming soon!'),
      ),
    );
  }
}
