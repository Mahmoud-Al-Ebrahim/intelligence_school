import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../theme/colors.dart';
import '../widgets/exam_card.dart';

class ExamsPage extends StatelessWidget {
  const ExamsPage({Key? key}) : super(key: key);

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
              Text(
                LocaleKeys.lbl_examination.tr(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )
            ],
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
            top: 25, start: 15, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.lbl_examination_list.tr(),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return  ExamCard();
                    },
                    itemCount: 5
                  ),
                )
          ],
        ),
      ),
    );
  }
}
