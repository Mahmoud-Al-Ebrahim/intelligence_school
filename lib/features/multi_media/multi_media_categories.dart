import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class MultiMediaCategories extends StatelessWidget {
  const MultiMediaCategories({Key? key, required this.selectedIndex}) : super(key: key);

  final ValueNotifier<int> selectedIndex ;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, selected, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IntrinsicWidth(
                //   child: InkWell(
                //     onTap: () {
                //       selectedIndex.value = 0;
                //     },
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Padding(
                //           padding:  EdgeInsets.only(bottom: selected == 0 ? 0 : 16),
                //           child: Text(
                //             'All',
                //             style: TextStyle(
                //                 color: selected == 0 ? Colors.red : primaryColor,
                //                 fontSize: 16),
                //           ),
                //         ),
                //         if (selected == 0) ...{
                //           const Divider(
                //             color: Colors.red,
                //             thickness: 2,
                //           )
                //         }
                //       ],
                //     ),
                //   ),
                // ),
                IntrinsicWidth(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      selectedIndex.value = 0;
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(bottom: selected == 0 ? 0 : 16),
                          child: Text(
                            'Documents',
                            style: TextStyle(
                                color: selected == 0 ? Colors.red : primaryColor,
                                fontSize: 16),
                          ),
                        ),
                        if (selected == 0) ...{
                          const Divider(
                            color: Colors.red,
                            thickness: 1,
                          )
                        }
                      ],
                    ),
                  ),
                ),
                IntrinsicWidth(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      selectedIndex.value = 1;
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(bottom: selected == 1 ? 0 : 16),
                          child: Text(
                            'Video',
                            style: TextStyle(
                                color: selected == 1 ? Colors.red : primaryColor,
                                fontSize: 16),
                          ),
                        ),
                        if (selected == 1) ...{
                          const Divider(
                            color: Colors.red,
                            thickness: 1,
                          )
                        }
                      ],
                    ),
                  ),
                ),
                // IntrinsicWidth(
                //   child: InkWell(
                //     onTap: () {
                //       selectedIndex.value = 3;
                //     },
                //     child: Column(
                //       children: [
                //         Padding(
                //           padding:  EdgeInsets.only(bottom: selected == 3 ? 0 : 16),
                //           child: Text(
                //             'Documents',
                //             style: TextStyle(
                //                 color: selected == 3 ? Colors.red : primaryColor,
                //                 fontSize: 16),
                //           ),
                //         ),
                //         if (selected == 3) ...{
                //           const Divider(
                //             color: Colors.red,
                //             thickness: 1,
                //           )
                //         }
                //       ],
                //     ),
                //   ),
                // ),
                // IntrinsicWidth(
                //   child: InkWell(
                //     onTap: () {
                //       selectedIndex.value = 4;
                //     },
                //     child: Column(
                //       children: [
                //         Padding(
                //           padding:  EdgeInsets.only(bottom: selected == 4 ? 0 : 16),
                //           child: Text(
                //             'Links',
                //             style: TextStyle(
                //                 color: selected == 4 ? Colors.red : primaryColor,
                //                 fontSize: 16),
                //           ),
                //         ),
                //         if (selected == 4) ...{
                //           const Divider(
                //             color: Colors.red,
                //             thickness: 1,
                //           )
                //         }
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          );
        });
  }
}
