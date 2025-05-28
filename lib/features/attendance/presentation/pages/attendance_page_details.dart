import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_date_utils/in_date_utils.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../service/language_service.dart';
import '../../../../theme/colors.dart';

class AttendanceDetailsPage extends StatefulWidget {
  const AttendanceDetailsPage({Key? key}) : super(key: key);

  @override
  State<AttendanceDetailsPage> createState() => _AttendanceDetailsPageState();
}

class _AttendanceDetailsPageState extends State<AttendanceDetailsPage> {
  final List<int> absents = [10, 15, 16];

 // final List<int> leaves = [8];

  @override
  Widget build(BuildContext context) {
    Map<String , dynamic> data = ModalRoute.of(context)!.settings.arguments  as Map<String , dynamic>;
    List<int> days = data['days'];
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
        flexibleSpace: SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/svg/back_arrow.svg',
                    color: Colors.white, height: 20),
              ),
              const SizedBox(
                width: 20,
              ),
               Text(
                LocaleKeys.lbl_attendance.tr(),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10),
            child: Text(
              '${getMonthName(data['month'])} ${data['year']}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: primaryColor),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CalendarDatePicker2(
            config: CalendarDatePicker2Config(
                controlsHeight: 0,
                lastMonthIcon: const SizedBox.shrink(),
                nextMonthIcon: const SizedBox.shrink(),
                customModePickerIcon: const SizedBox.shrink(),
                dayBuilder: (
                    {required DateTime date,
                    decoration,
                    isDisabled,
                    isSelected,
                    isToday,
                    textStyle}) {
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: !days.contains(date.day)
                              ? lightOrange
                              // : leaves.contains(date.day)
                              //     ? lightBlue
                                  :
                          textColor),
                      child: Center(child: Text(date.day.toString())));
                }),
            value: [],
          ),
          Row(
            children: [
              const SizedBox(width: 15),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                    days.length.toString()
                          ,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown),
                        ),
                         Text(
                          LocaleKeys.lbl_present.tr(),
                          style: const TextStyle(fontSize: 14, color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: lightOrange,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          '${DTU.getDaysInMonth(data['year'], data['month']) - days.length}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrangeAccent),
                        ),
                         Text(
                          LocaleKeys.lbl_leave.tr(),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.deepOrangeAccent),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Flexible(
              //   child: Container(
              //     padding: const EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //         color: lightBlue,
              //         borderRadius: BorderRadius.circular(15)),
              //     child: Center(
              //       child: Column(
              //         children: [
              //           Text(
              //             '${leaves.length}',
              //             style: const TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.bold,
              //                 color: primaryColor),
              //           ),
              //            Text(
              //              LocaleKeys.lbl_leave.tr(),
              //             style: const TextStyle(fontSize: 14, color: primaryColor),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(width: 15),
            ],
          )
        ],
      ),
    );
  }
}

String getMonthName(int month) {
  switch (month) {
    case DateTime.april:
      return LanguageService.rtl ? 'نيسان' : 'April';
    case DateTime.march:
      return LanguageService.rtl ? 'آذار' :'March';
    case DateTime.july:
      return LanguageService.rtl ? 'تموز' :'July';
    case DateTime.october:
      return LanguageService.rtl ? 'تشرين الأول' :'October';
    case DateTime.january:
      return LanguageService.rtl ? 'كانون الثاني' : 'January';
    case DateTime.february:
      return LanguageService.rtl ? 'شباط' : 'February';
    case DateTime.june:
      return LanguageService.rtl ? 'حزيران' : 'June';
    case DateTime.november:
      return LanguageService.rtl ? 'تشرين الثاني' : 'November';
    case DateTime.august:
      return LanguageService.rtl ? 'آب' : 'August';
    case DateTime.may:
      return LanguageService.rtl ? 'أيار' : 'May';
    case DateTime.december:
      return LanguageService.rtl ? 'كانون الاول' : 'December';
  }
  return LanguageService.rtl ? 'أيلول' : 'September';
}
