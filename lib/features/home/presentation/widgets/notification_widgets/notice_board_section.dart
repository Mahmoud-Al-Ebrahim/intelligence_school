import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../../../theme/colors.dart';
import 'notice_card.dart';

class NoticeBoardSection extends StatelessWidget {
  const NoticeBoardSection({Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
           Padding(
            padding: const EdgeInsetsDirectional.only(start: 15.0,),
            child: Text(
              LocaleKeys.lbl_notice_board.tr(),
              style: const TextStyle(
                fontSize: 20,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            child: Material(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsetsDirectional.only(start: 15),
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsetsDirectional.only(start: index != 0 ?  10.0 : 0),
                    child: NoticeCard(
                      width: 140,
                      height: 150,
                      maxLines: 2,
                      index: index,
                      color: index % 2 == 0 ? lightBlue: lightOrange,
                      date: DateTime.now().dmy,
                      text: 'notification content',
                      title: 'notification title',
                    ),
                  );
                },
                itemCount: 17,
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension dateExtension on DateTime{
  String get dmy => '$day-$month-$year';
}
