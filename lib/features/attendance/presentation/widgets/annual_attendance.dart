import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';
import 'monthly_attendance.dart';

class AnnualAttendance extends StatelessWidget {
  const AnnualAttendance({Key? key , required this.months , required  this.year}) : super(key: key);
 final Map<int , List<int>> months ;
 final int year;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10,top:20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("Year $year",
          style: TextStyle(
              color: primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
          ),),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index ){
              int month = months.keys.toList().elementAt(index);
              print(month);
              return MonthlyAttendance(
                year: year,
                month: month,
                days: months[month]!,
              );
            },
            itemCount: months.length,
          )
        ],

      ),
    );
  }
}
