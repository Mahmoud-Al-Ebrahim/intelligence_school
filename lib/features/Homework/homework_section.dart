import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intelligence_school/features/Home/notice_board_section.dart';
import '../../generated/locale_keys.g.dart';
import '../Homework/homework_card.dart';

class HomeworkSection extends StatelessWidget {
  const HomeworkSection({Key? key, required this.date}) : super(key: key);

  final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding:  EdgeInsetsDirectional.only(start: 15.0,top: 7),
          child: Text(date,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return  Padding(
                padding:   EdgeInsets.only(bottom: 10),
                child:  HomeworkCard(
                  description: LocaleKeys.lbl_end_date.tr() + DateTime.now().add(const Duration(days: 20)).dmy,
                  title: 'solve this equation: X^2 + 4X + 1 = 0',
                  finished: false // homeworks[index].,

                ),
              );
            },
            itemCount: 15,
          ),
        ),
      ],
    );
  }
}
