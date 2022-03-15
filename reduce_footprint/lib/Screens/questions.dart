// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reduce_footprint/Screens/result.dart';
import 'package:reduce_footprint/constants.dart';
import 'package:reduce_footprint/models/questions_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reduce_footprint/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int questionIndex = 0;
  late int? selectedOption = 100;

  var responses = <String, int>{};
  late CollectionReference _collectionReference;

  @override
  void initState() {
    _collectionReference = FirebaseFirestore.instance.collection(email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0.sp),
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
                  onPressed: () {
                    if (questionIndex > 0) {
                      setState(() {
                        questionIndex--;
                        selectedOption = null;
                      });
                    }
                  },
                  label: const Text('Previous'),
                  icon: const Icon(Icons.arrow_back),
                )
              : Container(),
          questionIndex != questionsList.length - 1
              ? FloatingActionButton.extended(
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
                  backgroundColor: kPrimaryColor,
                  onPressed: () async {
                    var dio = Dio();
                    results = await dio.post(
                        'https://carbonfootprint-api.herokuapp.com/calculate',
                        data: responses);
                    Map<String, dynamic> result =
                        json.decode(results.toString());
                    await _collectionReference.doc('responses').set(responses);
                    await _collectionReference.doc('results').set(result);
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const Result(),
                      ),
                    );
                  },
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
                style: TextStyle(
                  fontSize: 16.sp,
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
                  height: 220.sp,
                  width: 220.sp,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: questionsList[questionIndex]['options'].length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(4.h),
                    decoration: BoxDecoration(
                      color: selectedOption == index ? Colors.lightGreen : null,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: kPrimaryColor,
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
                      title:
                          Text(questionsList[questionIndex]['options'][index]),
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
