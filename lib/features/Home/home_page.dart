import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../theme/colors.dart';
import 'homework_section.dart';
import 'my_drawer.dart';
import 'notice_board_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc ;
  late AuthBloc authBloc ;
  late int userId = -1;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    //userId = authBloc.homeModel!.id!;
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetExams(userId));
    homeBloc.add(GetAttendance(userId));
    homeBloc.add(GetMyPayments(userId));
    homeBloc.add(GetUserLessons(userId));
    homeBloc.add(GetAllReports(userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: primaryColor,
        actions:  [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed('chats-page');
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 20.0),
              child: SvgPicture.asset('assets/svg/chat.svg')
            ),
          ),
        ],
        title:  Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('profile');
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 15.0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children:  [
                    if(
                    false
                    //authBloc.homeModel?.image != null
                    )
                     CircleAvatar(
                      backgroundImage: NetworkImage(
                          ''//authBloc.homeModel!.image!
                      ),
                      radius: 21,
                    )
                    else  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(Icons.person , size: 10,color: Colors.grey.shade400,),
                      ),
                      radius: 21,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 3),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    'user name', //authBloc.homeModel!.account!.name!,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor),
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  'class level',
                  //authBloc.homeModel!.className!,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor),
                )
              ],
            )
          ],
        ),
        // flexibleSpace: Container(
        //   height: 115 + MediaQuery.of(context).viewPadding.top,
        //   decoration: const BoxDecoration(
        //     color: Colors.white,
        //   ),
        // ),
      ),
      body:  const Column(
        children:[
          NoticeBoardSection(),
          // Expanded(child: HomeWorkSection(
          // )),
        ],
      ),
    );
  }
}
