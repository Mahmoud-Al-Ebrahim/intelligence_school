
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../app/vedio_player.dart';


class VideoCard extends StatelessWidget {
  const VideoCard({Key? key}) : super(key: key);

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
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 130,
              child: MYVideoPlayer(
                url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
              ),
            ),
            SizedBox(height: 10,),
             Text( 'c++ for begginers', style: TextStyle(
                fontSize: 16
            ),),
             Text( 'explanation of if statement', style: TextStyle(
                fontSize: 13,
                color: Colors.white
            ),),
          ],
        ),
      ),
    );
  }
}
