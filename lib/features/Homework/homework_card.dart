import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class HomeworkCard extends StatelessWidget {
   HomeworkCard({Key? key,required this.title,required this.description, required this.finished}) : super(key: key);
  final String title;
  final bool finished ;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
        padding: const EdgeInsets.all(10)..copyWith(left: 15 , right: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: lightPink),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){

            },
            child: Container(
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: finished ? primaryColor : Colors.white,
                   border: finished ? null : Border.all(width: 2),

                 ),
                 child: finished ?
                 const Icon(
                   Icons.check,
                   color: Colors.white,
                   size: 30,
                 )
                     : const SizedBox(
                   width: 30,
                   height: 30,
                 )
             ),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
