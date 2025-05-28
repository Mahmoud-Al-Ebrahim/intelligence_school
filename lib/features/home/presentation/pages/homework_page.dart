import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../theme/colors.dart';

class HomeworkPage extends StatefulWidget {
  const HomeworkPage({Key? key}) : super(key: key);

  @override
  State<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/svg/back_arrow.svg',
                      color: Colors.white,
                      height: 20,
                      matchTextDirection: true,
                    )),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  LocaleKeys.lbl_homeworks.tr(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: textColor),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container()
          ]
        )));
  }
}

// List.generate(
// 3,
// (index) => HomeworkSection(
// date: DateTime.now().add(const Duration(days: 17)).toString(),
// ),
// ),