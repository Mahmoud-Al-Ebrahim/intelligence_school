import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../Notice board/notice_details_page.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard(
      {Key? key,
      required this.color,
      required this.index,
      required this.text,
      required this.date,
      required this.width,
      required this.height,
      required this.maxLines,
      this.fromHome = true,
      required this.title})
      : super(key: key);

  final Color color;
  final String title;
  final String text;
  final String date;
  final int index;
  final double width;

  final double height;

  final int maxLines;

  final bool fromHome;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('notice-details',
            arguments: NoticeBoardDetailsModel(
              text,title,date,
                index: index, prefixOfTag: fromHome ? 'home-' : ''));
      },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Hero(
                  tag: '${fromHome ? 'home-' : ''}notice-image$index',
                  child: Container(
                    width: height / 3.5,
                    height: height / 3.5,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor,
                        ),
                    child: Image.asset('assets/images/graduation-hat.png' , color: secondaryColor,),
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Hero(
                    tag: '${fromHome ? 'home-' : ''}notice-title$index',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Hero(
                tag: '${fromHome ? 'home-' : ''}notice-description$index',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Hero(
              tag: '${fromHome ? 'home-' : ''}notice-date$index',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
