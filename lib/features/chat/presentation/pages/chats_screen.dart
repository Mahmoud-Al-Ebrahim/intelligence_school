import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../theme/colors.dart';
import '../../data/models/Chat.dart';
import '../widgets/chat_card.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.search , color: Colors.white , size: 30,),
              onPressed: () {},
            ),
          ),
        ],
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
              LocaleKeys.lbl_chats.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: chatsData.length,
        itemBuilder: (context, index) => ChatCard(
          chat: chatsData[index],
          press: () => Navigator.of(context).pushNamed('messages-page'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
    );
  }

}
