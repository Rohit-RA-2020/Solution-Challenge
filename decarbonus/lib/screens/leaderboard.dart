import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
            flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: screenHeight / 8),
                    child: Column(
                      children: [
                        Container(
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.greenAccent,
                          ),
                        ),
                        Container(
                          child: const Text(
                            "2",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.greenAccent,
                        ),
                      ),
                      Container(
                        child: const Text(
                          "1",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight / 8),
                    child: Column(
                      children: [
                        Container(
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.greenAccent,
                          ),
                        ),
                        Container(
                          child: const Text(
                            "3",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/leaderboard.png"),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 2,
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                  elevation: 0,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    leading: Text("1"),
                    trailing: Text("5001"),
                    title: Row(
                      children: const [
                        CircleAvatar(
                          radius: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Yash Satankar'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    leading: Text("2"),
                    trailing: Text("4981"),
                    title: Row(
                      children: const [
                        CircleAvatar(
                          radius: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Yash Satankar'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  elevation: 0,
                  child: ListTile(
                    leading: Text("3"),
                    trailing: Text("4501"),
                    title: Row(
                      children: const [
                        CircleAvatar(
                          radius: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Yash Satankar'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
