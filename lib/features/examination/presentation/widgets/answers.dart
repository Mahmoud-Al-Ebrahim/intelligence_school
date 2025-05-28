import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';


class Answer extends StatelessWidget {
  Answer(
      {Key? key,
      required this.answer,
      required this.theSelectedAnswer,
      required this.indexOfAnswer,
      required this.onChanged})
      : super(key: key);
  final String answer;
  final int theSelectedAnswer;
  final int indexOfAnswer;
  final ValueNotifier<bool> checked = ValueNotifier(false);
  final void Function(int? index) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Theme(
              data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent),
              child: RadioListTile(
                activeColor: primaryColor,
                contentPadding: EdgeInsets.zero,
                value: indexOfAnswer,
                groupValue: theSelectedAnswer,
                onChanged: onChanged,
                title: Text(
                  answer,
                ),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     checked.value = !checked.value;
          //   },
          //   child: ValueListenableBuilder<bool>(
          //       valueListenable: checked,
          //       builder: (context, check, _) {
          //         return Container(
          //           padding: EdgeInsets.all(check ? 2 : 0),
          //           decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: check ? primaryColor : Colors.white,
          //               border: check ? null : Border.all(width: 2)),
          //           child: check
          //               ? const Icon(
          //                   Icons.check,
          //                   size: 25.0,
          //                   color: Colors.white,
          //                 )
          //               : const SizedBox(
          //                   width: 25,
          //                   height: 25,
          //                 ),
          //         );
          //       }),
          // ),
          // const SizedBox(
          //   width: 10,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 7),
          //   child: Text(
          //     answer,
          //   ),
          // ),
        ],
      ),
    );
  }
}
