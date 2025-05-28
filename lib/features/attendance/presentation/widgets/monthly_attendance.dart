import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_date_utils/in_date_utils.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../theme/colors.dart';
import '../pages/attendance_page_details.dart';

class MonthlyAttendance extends StatelessWidget {
  const MonthlyAttendance(
      {Key? key, required this.days, required this.month, required this.year})
      : super(key: key);

  final List<int> days;

  final int month;
  final int year;

  @override
  Widget build(BuildContext context) {
    final double fullWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'attendance_details',
            arguments: {'year': year, 'month': month, 'days': days});
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 0, bottom: 10, top: 20, end: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: lightPink),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      getMonthName(month),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 60,
                  width: (fullWidth - 120) / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: textColor),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(
                          days.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.brown,
                          ),
                        ),
                        Text(
                          LocaleKeys.lbl_present.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 60,
                  width: (fullWidth - 120) / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lightOrange),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(
                          (DTU.getDaysInMonth(year, month) - days.length)
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.deepOrangeAccent),
                        ),
                        Text(
                          LocaleKeys.lbl_leave.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.deepOrangeAccent),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(width: 10,),
                // Container(
                //   height: 60, width:  (fullWidth - 120) / 3,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: lightBlue),
                //   child:  Padding(
                //     padding: const EdgeInsets.all(5),
                //     child: Column(
                //       children:[
                //         const Text("0",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16,
                //               color:primaryColor
                //           ),),
                //         Text(LocaleKeys.lbl_leave.tr(),
                //           style: const TextStyle(
                //               fontWeight: FontWeight.w400,
                //               fontSize: 16,
                //               color:primaryColor
                //
                //           ),),
                //       ],
                //     ),
                //   ),
                //
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
