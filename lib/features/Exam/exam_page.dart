import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intelligence_school/features/Exam/question.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/colors.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final ValueNotifier<Set<String>> countOfAnsweredQuestions =
      ValueNotifier(Set());
  final Map<String, int> selectedAnswer = {};

  int secondsDuration = 4800;
  late CountdownTimerController controller;
  late int endTime;

  onEnd() async {
    controller.disposeTimer();
    // int fullMark = 0, studentMark = 0;
    // int userId = BlocProvider.of<AuthBloc>(context).homeModel!.id!;
    // theEam.quest?.forEach((element) {
    //   fullMark += element.mark!;
    // });
    // countOfAnsweredQuestions.value.forEach((element) {
    //   Quest quest =
    //       theEam.quest!.firstWhere((ques) => ques.id.toString() == element);
    //   List<String> options = [
    //     quest.option1!,
    //     quest.option2!,
    //     quest.option3!,
    //   ];
    //   int answerIndex =
    //       options.indexWhere((element) => element == quest.answer);
    //   if (selectedAnswer[quest.id!] == answerIndex) {
    //     studentMark += quest.mark!;
    //   }
    // });
    // BlocProvider.of<HomeBloc>(context)
    //     .add(StoreStudentMark(userId, theEam.id!, studentMark));
    // await showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text(LocaleKeys.exam_result.tr()),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text(LocaleKeys.lbl_ok.tr())),
    //         ],
    //         content: Center(
    //           child: Text(LocaleKeys.your_mark_is.tr() +
    //               studentMark.toString() +
    //               ' / ${fullMark}'),
    //         ),
    //       );
    //     });
  }

  @override
  void initState() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * secondsDuration;
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        flexibleSpace: Container(
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'assets/svg/back_arrow.svg',
                  color: Colors.white,
                  matchTextDirection: true,
                  height: 20,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'Mobile development Exam',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              ValueListenableBuilder<Set<String>>(
                  valueListenable: countOfAnsweredQuestions,
                  builder: (context, count, child) {
                    return Text(
                      '${count.length} / 5',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    );
                  }),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  "${LocaleKeys.lbl_exam_code.tr()} ${Random().nextInt(1000)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
                const Spacer(flex: 1),
                const Icon(Icons.timer_outlined, weight: 500),
                CountdownTimer(
                  widgetBuilder: (_, remainingTime) {
                    String seconds = remainingTime?.sec == null
                        ? '00'
                        : (remainingTime!.sec!) < 10
                            ? '0${remainingTime.sec}'
                            : '${remainingTime.sec}';
                    String minutes = remainingTime?.min == null
                        ? '00'
                        : (remainingTime!.min!) < 10
                            ? '0${remainingTime.min}'
                            : '${remainingTime.min}';
                    String hours = remainingTime?.hours == null
                        ? '00'
                        : (remainingTime!.hours!) < 10
                            ? '0${remainingTime.hours}'
                            : '${remainingTime.hours}';
                    return Text(
                      '$hours : $minutes : $seconds ',
                    );
                  },
                  controller: controller,
                  onEnd: onEnd,
                  endTime: endTime,
                  endWidget: const SizedBox(),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              // physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Question(
                  questionNumber:
                      '${LocaleKeys.lbl_question.tr()}${index + 1} (2 Marks)',
                  onQuestionAnswered: (String id, int index) {
                    countOfAnsweredQuestions.value.add(id);
                    selectedAnswer[id] = index;
                    countOfAnsweredQuestions.notifyListeners();
                    // هذه التعليمة تجبره على اعادة الرسم
                  },
                );
              },
              itemCount: 5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () async {
              // if (countOfAnsweredQuestions.value.length != 5) {
              //   await showDialog(
              //       context: context,
              //       builder: (context) {
              //         return AlertDialog(
              //           title: Text(LocaleKeys.lbl_finish_exam.tr()),
              //           actions: [
              //             TextButton(
              //                 onPressed: () async {
              //                   // int fullMark = 0, studentMark = 0;
              //                   // int userId = BlocProvider.of<AuthBloc>(context)
              //                   //     .homeModel!
              //                   //     .id!;
              //                   // theEam.quest?.forEach((element) {
              //                   //   fullMark += element.mark!;
              //                   // });
              //                   // countOfAnsweredQuestions.value
              //                   //     .forEach((element) {
              //                   //   Quest quest = theEam.quest!.firstWhere(
              //                   //       (ques) => ques.id.toString() == element);
              //                   //   List<String> options = [
              //                   //     quest.option1!,
              //                   //     quest.option2!,
              //                   //     quest.option3!,
              //                   //   ];
              //                   //   int answerIndex = options.indexWhere(
              //                   //       (element) => element == quest.answer);
              //                   //   if (selectedAnswer[quest.id!] ==
              //                   //       answerIndex) {
              //                   //     studentMark += quest.mark!;
              //                   //   }
              //                   // });
              //                   // BlocProvider.of<HomeBloc>(context).add(
              //                   //     StoreStudentMark(
              //                   //         userId, theEam.id!, studentMark));
              //                   // Navigator.pop(context);
              //                   await showDialog(
              //                       context: context,
              //                       builder: (context) {
              //                         return AlertDialog(
              //                           title:
              //                               Text(LocaleKeys.exam_result.tr()),
              //                           actions: [
              //                             TextButton(
              //                                 onPressed: () {
              //                                   Navigator.pop(context);
              //                                 },
              //                                 child:
              //                                     Text(LocaleKeys.lbl_ok.tr())),
              //                           ],
              //                           content: Center(
              //                             child: Text(
              //                                 LocaleKeys.your_mark_is.tr() +
              //                                     studentMark.toString() +
              //                                     ' / ${fullMark}'),
              //                           ),
              //                         );
              //                       });
              //                 },
              //                 child: Text(LocaleKeys.lbl_yes.tr())),
              //             TextButton(
              //                 onPressed: () {
              //                   Navigator.pop(context);
              //                 },
              //                 child: Text(LocaleKeys.lbl_no.tr())),
              //           ],
              //         );
              //       });
              // }
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              height: 50,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  LocaleKeys.lbl_finish_exam.tr(),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
