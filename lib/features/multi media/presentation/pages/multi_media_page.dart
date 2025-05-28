import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../theme/colors.dart';
import '../widgets/document_card.dart';
import '../widgets/multi_media_categories.dart';
import '../widgets/video_card.dart';

class MultiMediaPage extends StatefulWidget {
  const MultiMediaPage({Key? key}) : super(key: key);

  @override
  State<MultiMediaPage> createState() => _MultiMediaPageState();
}

class _MultiMediaPageState extends State<MultiMediaPage> {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final PageController pageController = PageController();

  @override
  void initState() {
    selectedIndex.addListener(() {
      pageController.animateToPage(selectedIndex.value,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        foregroundColor: Colors.white,
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
                width: 15,
              ),
              Text(
                LocaleKeys.lbl_multimedia.tr(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )
            ],
          ),
        ),
        backgroundColor: primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7, top: 7),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  size: 30,
                )),
          )
        ],
      ),
      body:Column(
            children: [
              MultiMediaCategories(selectedIndex: selectedIndex),
              ValueListenableBuilder<int>(
                  valueListenable: selectedIndex,
                  builder: (context, selected, _) {
                    return Expanded(
                        child: PageView(
                      controller: pageController,
                      onPageChanged: (int index) {
                        selectedIndex.value = index;
                      },
                      children: [
                        ListView.builder(
                          itemCount: 20,
                          itemBuilder: (ctx, index) {
                            return DocumentCard();
                          },
                          padding: const EdgeInsets.only(top: 15),
                        ),
                        ListView.builder(
                          itemCount: 20,
                          itemBuilder: (ctx, index) {
                            return VideoCard();
                          },
                          padding: const EdgeInsets.only(top: 15),
                        ),
                        // ListView.builder(
                        //   itemBuilder: (ctx, index) {
                        //     return const VideoCard();
                        //   },
                        //   padding: const EdgeInsets.only(top: 15),
                        // ),
                        // ListView.builder(
                        //   itemBuilder: (ctx, index) {
                        //     return const DocumentCard();
                        //   },
                        //   padding: const EdgeInsets.only(top: 15),
                        // ),
                      ],
                    ));
                  }),
            ],
      ),
    );
  }
}
