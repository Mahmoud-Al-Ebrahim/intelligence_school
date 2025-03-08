import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/colors.dart';
import '../custom_widget/drop_down_menu.dart';
import '../custom_widget/my_calendar.dart';
import 'event_card.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

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
                child: SvgPicture.asset('assets/svg/back_arrow.svg',
                    color: Colors.white, matchTextDirection: true, height: 20),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                LocaleKeys.lbl_calender.tr(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const Spacer(),
              SizedBox(
                width: 110,
                child: DropDownMenu<String>(
                  items: const [
                    '2020',
                    '2021',
                    '2022',
                    '2023',
                    '2024',
                  ],
                  value: '2020',
                  onChange: (data) {},
                ),
              ),
              const SizedBox(width: 10,)
            ],
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          const MyCalendar(),
          Expanded(
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  itemBuilder: (ctx, index) {
                    return const EventCard();
                  }))
        ],
      ),
    );
  }
}
