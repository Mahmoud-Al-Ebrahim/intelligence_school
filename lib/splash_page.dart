import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intelligence_school/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import 'generated/locale_keys.g.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  onSplash() async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    bool viewed = sharedPreferences.getBool('on boarding viewed') ?? false;
    bool thereIsToken = sharedPreferences.getString('token') != null;
    if (thereIsToken) {
      BlocProvider.of<AuthBloc>(context).add(GetProfileInfoEvent());
    }
    Future.delayed(const Duration(seconds: 2), () {
      if(mounted && !dontNavigate) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          !viewed ? 'boarding' : thereIsToken ? 'wait' : 'login', (
            route) => false,);
      }
    });
  }
bool dontNavigate = false;
  @override
  void initState() {
    onSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is GetProfileDoneSuccessfully) {
          dontNavigate = true;
          Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
        }
      },
      child: Scaffold(
        body: Container(
            color: primaryColor,
            height: double.infinity,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/graduation-hat.png',
                      color: secondaryColor,
                      height: 300,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      LocaleKeys.stellar.tr(),
                      style: const TextStyle(color: secondaryColor, fontSize: 40),
                    )
                  ],
                ))),
      ),
    );
  }
}
