// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:decarbonus/screens/result.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../resources/questions_model.dart';
import '../utils/global_variable.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int questionIndex = 0;
  late int? selectedOption = 100;

  var responses = <String, int>{};
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          questionIndex != 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    if (questionIndex > 0) {
                      setState(() {
                        questionIndex--;
                        selectedOption = null;
                      });
                    }
                  },
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.black, width: 3),
                  ),
                  label: const Text('Previous',
                      style: TextStyle(color: Colors.black)),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                )
              : Container(),
          questionIndex != questionsList.length - 1
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    if (questionIndex < questionsList.length - 1) {
                      setState(() {
                        questionIndex++;
                        selectedOption = null;
                      });
                    }
                  },
                  label: const Text('Next'),
                  icon: const Icon(Icons.arrow_forward),
                )
              : FloatingActionButton.extended(
                  backgroundColor: const Color(0xFF1DBF73),
                  onPressed: () async {
                    User currentUser = _auth.currentUser!;
                    var dio = Dio();
                    results = await dio.post(
                        'https://api-account-345807.el.r.appspot.com/calculate',
                        data: responses);
                    Map<String, dynamic> result =
                        json.decode(results.toString());
                    await _collectionReference
                        .doc(currentUser.uid)
                        .update({'responses': responses});
                    await _collectionReference
                        .doc(currentUser.uid)
                        .update({'emmision': result['result']});
                    await _collectionReference
                        .doc(currentUser.uid)
                        .update({'result': result});
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const Result(),
                      ),
                    );
                  },
                  shape: const StadiumBorder(
                      side: BorderSide(color: Colors.green, width: 3)),
                  label: const Text('Submit'),
                  icon: const Icon(Icons.check),
                ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Text(
                '${questionIndex + 1}/${questionsList.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                questionsList[questionIndex]['question'],
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset(
                  questionsList[questionIndex]['icon'],
                  height: 220,
                  width: 220,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListView.builder(
                    itemCount: questionsList[questionIndex]['options'].length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: selectedOption == index
                            ? const Color(0xFF1DBF73)
                            : null,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            selectedOption = index;
                            responses.addAll({questionIndex.toString(): index});
                          });
                        },
                        title: Text(
                            questionsList[questionIndex]['options'][index]),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
