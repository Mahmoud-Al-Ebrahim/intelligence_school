import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/locale_keys.g.dart';
import '../../theme/colors.dart';

class NoticeBoardDetailsModel {
  final int index;
  final String prefixOfTag;
  final String text;
  final String title;
  final String date;

  const NoticeBoardDetailsModel(this.text, this.title, this.date,
      {required this.index, required this.prefixOfTag});
}

class NoticeDetailsPage extends StatelessWidget {
  const NoticeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final NoticeBoardDetailsModel data = ModalRoute.of(context)!.settings.arguments as NoticeBoardDetailsModel;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/svg/back_arrow.svg',
                  color: Colors.white,matchTextDirection: true, height: 20),
            ),
            const SizedBox(
              width: 15,
            ),
             Text(
              LocaleKeys.lbl_notice_details.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: '${data.prefixOfTag}notice-image${data.index}',
                child: Container(
                  width: size.width * 0.7,
                  height:size.width * 0.7,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30) , color: primaryColor,
                      ),
                  child: Image.asset('assets/images/graduation-hat.png' , color: secondaryColor,),
                ),
              ),
              SizedBox(height: 20,),
              Hero(
                tag: '${data.prefixOfTag}notice-title${data.index}',
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      data.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
               Hero(
                tag: '${data.prefixOfTag}notice-description${data.index}',
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      data.text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
               Hero(
                tag: '${data.prefixOfTag}notice-date${data.index}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    data.date,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
