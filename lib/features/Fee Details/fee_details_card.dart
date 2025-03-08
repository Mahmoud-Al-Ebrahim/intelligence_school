import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intelligence_school/features/Home/notice_board_section.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/colors.dart';
import '../attendance/attendance_page_details.dart';

class FeeDetailsCard extends StatelessWidget {
  FeeDetailsCard({Key? key}) : super(key: key);


  final ValueNotifier<bool> isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width - 40,
          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ValueListenableBuilder<bool>(
                valueListenable: isExpanded,
                builder: (context, expanded, child) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "School Fee for ${DateTime.now().dmy}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "1299\$",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      height: 23,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                           LocaleKeys.lbl_not_paid.tr(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "17 ${getMonthName(2)}",
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              InkWell(
                                onTap: () {
                                  isExpanded.value = !isExpanded.value;
                                },
                                child: ValueListenableBuilder<bool>(
                                    valueListenable: isExpanded,
                                    builder: (context, expanded, _) {
                                      return Icon(
                                        expanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: Colors.red,
                                        size: 25,
                                      );
                                    }),
                              ),
                              SizedBox(width: 1)
                            ],
                          )
                        ],
                      ),
                      if (expanded) ...{
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...List.generate(
                          1,
                          (index) => Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.lbl_total_fee.tr(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                                Text(
                                  "1299 \$",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.lbl_paid_fee.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Text(
                              "0 \$",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                      }
                    ],
                  );
                }),
          ),
        ),
        const SizedBox(
          height: 17,
        )
      ],
    );
  }
}
