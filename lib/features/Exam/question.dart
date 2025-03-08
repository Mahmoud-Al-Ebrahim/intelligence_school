import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import 'answers.dart';

class Question extends StatelessWidget {
  Question({Key? key, required this.questionNumber, required this.onQuestionAnswered})
      : super(key: key);
  final String questionNumber;
  final ValueNotifier<int> selectedAnswerIndex = ValueNotifier(-1);
  final void Function(String id , int index) onQuestionAnswered ;

  @override
  Widget build(BuildContext context) {
    List<String> options = [
     'dart',
     'c++',
     'java script',
     'none',
    ];
    int indexOfAnswer = 0;
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedAnswerIndex,
        builder: (context , selectedAnswer , child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child! ,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Answer(
                    onChanged: (int? index) {
                      onQuestionAnswered.call(questionNumber , index!);
                      selectedAnswerIndex.value = index ?? -1;
                    },
                    answer: options[index],
                    indexOfAnswer: indexOfAnswer,
                    theSelectedAnswer: selectedAnswer,
                  );
                },
                itemCount: 3 ,
              )
            ],
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionNumber,
              style: const TextStyle(
                  color: primaryColor, fontSize: 17, fontWeight: FontWeight.w400),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 7, right: 7),
              child: Container(
                decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'what is the programming language of flutter?',
                    style: const TextStyle(
                      // overflow: TextOverflow.visible,
                      //  wordSpacing: double.maxFinite,

                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
