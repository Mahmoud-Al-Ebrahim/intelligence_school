import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/locale_keys.g.dart';
import '../../theme/colors.dart';
import 'notices.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/svg/back_arrow.svg',
                  color: Colors.white,matchTextDirection: true, height: 20),
            ),
            const SizedBox(
              width: 15,
            ),
             Text(
              LocaleKeys.lbl_notice_board.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
      body: const Notices(),
    );
  }
}
