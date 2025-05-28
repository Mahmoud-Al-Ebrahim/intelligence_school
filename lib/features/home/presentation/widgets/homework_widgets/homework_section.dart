// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import '../../../../../generated/locale_keys.g.dart';
// import '../../../../../theme/colors.dart';
// import 'homework_card.dart';
//
// class HomeWorkSection extends StatelessWidget {
//   const HomeWorkSection({Key? key ,}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only( top: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children:  [
//             Padding(
//             padding:  const EdgeInsetsDirectional.only(start: 15),
//             child:  Text(
//               LocaleKeys.lbl_homeworks.tr(),
//               style: const TextStyle(
//                 fontSize: 20,
//                 color: primaryColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: ListView.builder(
//             //  physics:const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return  Padding(
//                   padding:   EdgeInsets.only(bottom: 10),
//                   child:  HomeWorkCard(
//                     description: LocaleKeys.lbl_end_date.tr() + homeworks[index].endDate!.dmy,
//                     title: homeworks[index].text!,
//                   ),
//                 );
//               },
//               itemCount: homeworks.length,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
