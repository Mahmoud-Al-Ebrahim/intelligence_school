import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'dart:ui' as ui;
import '../../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../service/show_message.dart';
import '../../../../theme/colors.dart';
import '../../../../widgets/custom_text_input.dart';
import '../../../../widgets/loading_indicator/loader_indicator.dart';
import '../../../app/drop_down_menu.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _nameController;
  String accountType = LocaleKeys.lbl_student.tr();
  final List<FocusNode> _nodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  final pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  late final RegExp regex;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    regex = RegExp(pattern);
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 300,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/graduation-hat.png',
                    color: secondaryColor,
                    height: 150,
                  ),
                  Text(
                    LocaleKeys.stellar.tr(),
                    style: const TextStyle(color: secondaryColor, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    LocaleKeys.lbl_sign_up.tr(),
                    style: const TextStyle(color: secondaryColor, fontSize: 25),
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsetsDirectional.only(top: 20.0, start: 20, end: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextInput(
                    iconUrl: 'assets/auth_icons/name_icon.svg',
                    focusNode: _nodes[0],
                    controller: _nameController,
                    labelText: LocaleKeys.lbl_name.tr()),
                CustomTextInput(
                    iconUrl: 'assets/auth_icons/email.svg',
                    focusNode: _nodes[1],
                    controller: _emailController,
                    labelText: LocaleKeys.lbl_email.tr()),
                CustomTextInput(
                    iconUrl: 'assets/auth_icons/password_icon.svg',
                    focusNode: _nodes[2],
                    controller: _passwordController,
                    labelText: LocaleKeys.lbl_create_new_password.tr()),
                CustomTextInput(
                    iconUrl: 'assets/auth_icons/password_icon.svg',
                    focusNode: _nodes[3],
                    controller: _confirmPasswordController,
                    labelText: LocaleKeys.lbl_confirm_new_password.tr()),
                Text(
                  LocaleKeys.lbl_type.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: tertiaryColor,
                  ),
                ),
                DropDownMenu<String>(
                  items: [
                    LocaleKeys.lbl_student.tr(),
                    LocaleKeys.lbl_teacher.tr(),
                    LocaleKeys.lbl_secretary.tr(),
                  ],
                  value: accountType,
                  onChange: (data) {
                    accountType = data;
                  },
                ),

              ],
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            // buildWhen: (p, c) =>
            //     c is SignUpInProgress ||
            //     c is SignUpFailed ||
            //     c is SignUpDoneSuccessfully,
            listener: (context, state) {
              if (state is SignUpDoneSuccessfully) {
                Navigator.pushReplacementNamed(
                    context, getTypeFromItsName(accountType) == 2 ? 'wait'  : 'complete-profile-page');
              }
              if (state is SignUpFailed) {
                showMessage(state.errorMessage);
              }
            },
            builder: (context, state) {
              if (state is SignUpInProgress) {
                return LoaderIndicator();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      onTapFunction();
                    },
                    child: Container(
                      width: size.width - 40,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: tertiaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(LocaleKeys.lbl_sign_up.tr(),
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.already_have_account.tr(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                        child: Text(
                          LocaleKeys.lbl_sign_in.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: tertiaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  onTapFunction() async {
    if (_nameController.text.isEmpty) {
      showMessage(LocaleKeys.lbl_name_not_empty.tr());
      return;
    } else if (_emailController.text.isEmpty) {
      showMessage(LocaleKeys.lbl_email_not_empty.tr());
      return;
    } else if (!regex.hasMatch(_emailController.text)) {
      showMessage(LocaleKeys.lbl_invalid_email.tr());
      return;
    } else if (_passwordController.text.length < 8) {
      showMessage(LocaleKeys.lbl_password_8_char.tr());
      return;
    } else if (_confirmPasswordController.text != _passwordController.text) {
      showMessage(LocaleKeys.lbl_passwords_must_matched.tr());
      return;
    }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showMessage(LocaleKeys.lbl_check_internet.tr());
      return;
    }
    Navigator.of(context).pushNamedAndRemoveUntil('home',(route) => false,);
    return;
    BlocProvider.of<AuthBloc>(context).add(SignUpEvent(
      name: _nameController.text,
      email: _emailController.text,
      type: getTypeFromItsName(accountType),
      password: _passwordController.text,
    ));
    //showMessage('SignUp Successfully');
  }

  int getTypeFromItsName(String name) {
    if (name == LocaleKeys.lbl_student.tr()) {
      return 1;
    }
    if (name == LocaleKeys.lbl_teacher.tr()) {
      return 2;
    }
    return 3;
  }
}
