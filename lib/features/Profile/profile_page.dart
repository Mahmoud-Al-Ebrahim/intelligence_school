import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 300,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40))),
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(
                flex: 2,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset('assets/svg/back_arrow.svg',
                        color: Colors.white,
                        matchTextDirection: true,
                        height: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    LocaleKeys.lbl_profile.tr(),
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: textColor),
                  )
                ],
              ),
              const Spacer(
                flex: 2,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (false)
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(''),
                    )
                  else
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'user name',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: textColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'class name',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  )
                ],
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.lbl_email.tr(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'email@example.com',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.lbl_phone_number.tr(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '0963615223',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.lbl_type.tr(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'account type',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.lbl_address.tr(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'aleppo - almohafaza',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
          // Container(
          //   width: size.width - 100,
          //   height: 50,
          //   decoration: BoxDecoration(
          //     color: lightPink,
          //     borderRadius: BorderRadius.circular(30)
          //   ),
          //   child: Center(
          //     child:  Text(LocaleKeys.lbl_ask_for_update.tr() , style: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 14
          //     ),),
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
