import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/locale_keys.g.dart';
import '../../theme/colors.dart';
import 'fee_details_card.dart';

class FeeDetailsPage extends StatefulWidget {
  const FeeDetailsPage({Key? key}) : super(key: key);

  @override
  State<FeeDetailsPage> createState() => _FeeDetailsPageState();
}

class _FeeDetailsPageState extends State<FeeDetailsPage> {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

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
                LocaleKeys.lbl_fee_details.tr(),
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
        children: [
          // FeeDetailsCategories(
          //     selectedIndex:selectedIndex
          // ),
          Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return FeeDetailsCard();
                },
                padding: EdgeInsets.only(top: 15),
                itemCount: 20,
              ),
            )
        ],
      ),
    );
  }
}
