import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      margin: const EdgeInsets.only(left: 20 , right: 20 , bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightPink
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 130,
              child: Image.asset('assets/images/graduation-hat.png'),
            ),
            const SizedBox(height: 10,),
            const Text( 'lesson.pdf', style: TextStyle(
                fontSize: 16
            ),),
            Text( 'description of the lesson' , style: TextStyle(
                fontSize: 13,
                color: Colors.white
            ),),
          ],
        ),
      ),
    );
    // return Container(
    //   height: 120,
    //   margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
    //   padding: const EdgeInsets.all(10),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20), color: lightPink),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Container(
    //         width: 70,
    //         height: 90,
    //         decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(15), color: Colors.brown),
    //       ),
    //       const SizedBox(
    //         width: 20,
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: const [
    //           Text(
    //             'Social Science Syllabus',
    //             style: TextStyle(fontSize: 16),
    //           ),
    //           Text(
    //             'Syllabus for 2020batch',
    //             style: TextStyle(fontSize: 13, color: Colors.white),
    //           ),
    //           Text(
    //             '12 pages / 360 KB',
    //             style: TextStyle(fontSize: 13, color: Colors.white),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
