import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reduce_footprint/Screens/login/result.dart';
import 'package:reduce_footprint/constants.dart';
import 'package:reduce_footprint/models/questions_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int questionIndex = 0;
  late int? selectedOption = 100;

  var responses = <String, int>{};

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
                    var result = await dio.post(
                        'http://10.0.2.2:3000/calculate',
                        data: responses);

                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Result(result: result),
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
          margin:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0 * 2),
          padding: const EdgeInsets.all(20.0),
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
              Lottie.asset(
                questionsList[questionIndex]['icon'],
                height: 250.sp,
                width: 250.sp,
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
