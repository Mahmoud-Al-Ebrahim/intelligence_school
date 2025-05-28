import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/locale_keys.g.dart';
import '../../theme/colors.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<String> pagesName = [
    LocaleKeys.lbl_home.tr(),
    LocaleKeys.lbl_homeworks.tr(),
    LocaleKeys.lbl_attendance.tr(),
    LocaleKeys.lbl_fee_details.tr(),
    LocaleKeys.lbl_examination.tr(),
    //LocaleKeys.lbl_report_cards.tr(),
    LocaleKeys.lbl_calender.tr(),
    LocaleKeys.lbl_notice_board.tr(),
    LocaleKeys.lbl_multimedia.tr(),
    LocaleKeys.lbl_profile.tr(),
  ];

  List<String> pagesRoutesName = [
    "home",
    "homework",
    "attendance",
    "fee",
    "exams",
    //"reports",
    "calendar",
    "notices",
    "media",
    "profile",
  ];

  List<String> iconsNames = [
    "home",
    "homework",
    "attendance",
    "fee",
    "exams",
    //"reports",
    "calendar",
    "notices",
    "media",
    "profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: AppBar(
            backgroundColor: secondaryColor,
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20.0, top: 15),
                  child: SvgPicture.asset(
                    "assets/svg/cancel.svg",
                    color: primaryColor,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ],
            title: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  if (false)
                    CircleAvatar(
                      //backgroundImage: NetworkImage(homeModel.image!),
                      radius: 21,
                    )
                  else
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      radius: 21,
                    ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: primaryColor),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Class',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: primaryColor),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.only(end: 20.0, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pagesName.length,
                      itemBuilder: (ctx, index) {
                        return MenuItem(
                            iconUrl: "assets/svg/${iconsNames[index]}.svg",
                            onTap: (){
                              if(index == 0){
                                Scaffold.of(context).closeDrawer();
                                return;
                              }
                              Navigator.of(context).pushNamed(
                                pagesRoutesName[index],
                              );
                            },
                            text: pagesName[index]);
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      "login",
                      (route) => false,
                    );
                  },
                  child: Text(
                    LocaleKeys.lbl_logout.tr(),
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: lightPink),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ));
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({Key? key, required this.iconUrl, required this.text , this.onTap})
      : super(key: key);

  final String iconUrl;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconUrl, height: 30, width: 30),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w400, color: primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
