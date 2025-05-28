import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../theme/colors.dart';
import '../widgets/annual_attendance.dart';

class AnnualAttendancePage extends StatefulWidget {
  const AnnualAttendancePage({Key? key}) : super(key: key);

  @override
  State<AnnualAttendancePage> createState() => _AnnualAttendancePageState();
}

class _AnnualAttendancePageState extends State<AnnualAttendancePage> {

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
      body:
          // Map<int , Map<int , List<int>>> years = {};
          // attendanceModel.data!.attendances!.forEach((element) {
          //   int year = int.parse(element.attendanceDay!.substring(0 , 4));
          //   if(years[year] == null){
          //     years[year] = {};
          //   }
          //   int month = int.parse(element.attendanceDay!.substring(5 , 7));
          //   if(years[year]![month] == null){
          //     years[year]![month] = [];
          //   }
          //   int day = int.parse(element.attendanceDay!.substring(8));
          //   years[year]![month]!.add(day);
          // });
           ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              int year = 2022 + index;
              Map<int , List<int>> years={};
              for(int i = 1 ; i<= 12 ;i++) {
                years[i] = List.generate((30), (index) => index);
                years[i]!.removeWhere((val)=> val % (i+1) == 0);
              }
              return  AnnualAttendance(months:years ,year: year,);
            },
            itemCount: 4,
          ));
  }
}
