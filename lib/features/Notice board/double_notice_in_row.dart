import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../Home/notice_card.dart';


class DoubleNoticesInRow extends StatelessWidget {
  const DoubleNoticesInRow(
      {Key? key, required this.index, required this.hideTheSecondOne, required this.text1, required this.text2, required this.date1, required this.date2, required this.title1, required this.title2})
      : super(key: key);
  final int index;
  final bool hideTheSecondOne;
  final String text1;
  final String text2;
  final String date1;
  final String date2;
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    final double fullWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NoticeCard(
          width: fullWidth / 2 - 25,
          height: 200,
          maxLines: 3,
            color: (index/2) % 2 == 0 ? lightOrange : lightBlue,
          index: index,
          text: text1,
          title: title1,
          fromHome: false,
          date: date1,
        ),
        if(hideTheSecondOne) SizedBox(width: fullWidth / 2 - 25,)
        else NoticeCard(
          width: fullWidth / 2 - 25,
          height: 200,
          maxLines: 3,
          color: (index/2) % 2 != 0 ? lightOrange : lightBlue,
          index: index + 1,
          text: text2,
          fromHome: false,
          date: date2,
          title: title2,
        ),
      ],
    );
  }
}
