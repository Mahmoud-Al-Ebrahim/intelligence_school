import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intelligence_school/features/Home/notice_board_section.dart';
import 'double_notice_in_row.dart';
class Notices extends StatelessWidget {
  const Notices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<MyNotification> notifications = BlocProvider.of<AuthBloc>(context).homeModel!.notifications ?? [];
    return  ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20 , left: 15 , right: 15),
      itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: DoubleNoticesInRow(index : 2 * index ,
            date1: DateTime.now().dmy,
            date2: DateTime.now().dmy,
            text1: 'notification content',
            text2: 'notification content',
          title1: 'notification title',
          title2: 'notification title',
          hideTheSecondOne: index ==((17 + 1) ~/ 2 - 1),
          //   text1: notifications[index].message!,
          //   date1: notifications[index].createdAt!.dmy,
          //   title1: notifications[index].title!,
          // hideTheSecondOne: notifications.length.isOdd && index ==((notifications.length + 1) ~/ 2 - 1) ,
          // text2: notifications.length.isOdd && index ==((notifications.length + 1) ~/ 2 - 1)  ? '' :  notifications[index].message! ,
          //   date2: notifications.length.isOdd && index ==((notifications.length + 1) ~/ 2 - 1)  ? '' :  notifications[index].createdAt!.dmy ,
          //   title2: notifications.length.isOdd && index ==((notifications.length + 1) ~/ 2 - 1)  ? '' :  notifications[index].title! ,
        ),
      );
    },
      itemCount:  (17 + 1) ~/ 2 //(notifications.length + 1) ~/ 2,
    );
  }
}
