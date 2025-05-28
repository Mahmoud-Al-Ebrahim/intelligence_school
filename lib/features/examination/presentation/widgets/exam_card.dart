import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../theme/colors.dart';


class ExamCard extends StatelessWidget {
  const ExamCard({super.key,});


  @override
  Widget build(BuildContext context) {
    final double fullWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10, bottom: 0, end: 15),
      child: Container(
        height: 130,
        width: fullWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: lightOrange,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
              top: 15, start: 20, bottom: 10, end: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exam Name',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              const Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    weight: 400,
                    color: lightBlue,
                    size: 16,
                  ),
                  Text(
                    "${LocaleKeys.lbl_duration.tr()}30 ${LocaleKeys.lbl_minute.tr()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: lightBlue,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: lightBlue,
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    weight: 400,
                    color: lightBlue,
                    size: 16,
                  ),
                  Text(
                    "${LocaleKeys.start_at.tr()} sunday - 14:00pm",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: lightBlue,
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
              GestureDetector(
                onTap: () async {

                  Navigator.of(context).pushNamed('exam');
                  // int year = int.parse(exam.day!.substring(0, 4));
                  // int month = int.parse(exam.day!.substring(5, 7));
                  // int day = int.parse(exam.day!.substring(8));
                  // int hour = int.parse(exam.time!.substring(0, 2));
                  // int minutes = int.parse(exam.time!.substring(3, 5));
                  // int seconds = int.parse(exam.time!.substring(6));
                  // if (DateTime.now().year < year ||
                  //     DateTime.now().month < month ||
                  //     DateTime.now().day < day ||
                  //     DateTime.now().hour < hour ||
                  //     DateTime.now().minute < minutes ||
                  //     DateTime.now().second < seconds) {
                  //   showMessage(LocaleKeys.you_cant_start_exam.tr());
                  //   return;
                  // }
                  // if (DateTime.now().year == year &&
                  //     DateTime.now().month == month &&
                  //     DateTime.now().day == day &&
                  //     DateTime.now().hour == hour &&
                  //     (DateTime.now().minute - minutes) > 5) {
                  //   showMessage(LocaleKeys.exam_period_passed.tr());
                  //   return;
                  // }
                  // int userId =
                  //     BlocProvider.of<AuthBloc>(context).homeModel!.id!;
                  // BlocProvider.of<HomeBloc>(context)
                  //     .add(StartExam(exam.id!, userId));
                },
                child: Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightPink,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 7),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_right,
                          weight: 400,
                          size: 25,
                          color: Colors.white,
                        ),
                        // SizedBox(width: 4,),
                        Text(
                          LocaleKeys.lbl_start_test.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
