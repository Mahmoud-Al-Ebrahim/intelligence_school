

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intelligence_school/features/authentication/verification_number_fields.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../generated/locale_keys.g.dart';
import '../../service/show_message.dart';
import '../../theme/colors.dart';
import 'dart:ui' as ui;

import '../../widgets/custom_text_input.dart';
import '../../widgets/loading_indicator/loader_indicator.dart';
import '../custom_widget/drop_down_menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int currentMode = 0;

  int secondsDuration = 130;
  late CountdownTimerController countdownTimerController;
  late int endTime;

  late TextEditingController _confirmPasswordController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  final List<FocusNode> _nodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  String? code;

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
    _confirmPasswordController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  void onEnd() {
    countdownTimerController.disposeTimer();
  }

  @override
  void initState() {
    regex = RegExp(pattern);
    _confirmPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
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
                    currentMode == 0
                        ? LocaleKeys.lbl_sign_in.tr()
                        : LocaleKeys.lbl_forget_password.tr(),
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
            padding: const EdgeInsetsDirectional.only(
                top: 20.0, start: 20, end: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentMode == 0) ...{
                  CustomTextInput(
                      iconUrl: 'assets/auth_icons/email.svg',
                      focusNode: _nodes[0],
                      controller: _emailController,
                      labelText: LocaleKeys.lbl_email.tr()),
                  CustomTextInput(
                      iconUrl: 'assets/auth_icons/password_icon.svg',
                      focusNode: _nodes[1],
                      controller: _passwordController,
                      labelText: LocaleKeys.lbl_create_new_password.tr()),
                  SizedBox(
                    height: 20,
                  ),
                } else
                  if (currentMode == 1) ...{
                    CustomTextInput(
                        iconUrl: 'assets/auth_icons/email.svg',
                        focusNode: _nodes[0],
                        controller: _emailController,
                        labelText: LocaleKeys.lbl_email.tr()),
                  } else
                    if (currentMode == 2) ...{
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          VerificationNumberFields(
                            onChanged: (value) {
                              code = value;
                            },
                            onCompleted: (value) {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (countdownTimerController.isRunning) {
                                      showMessage(
                                          LocaleKeys.lbl_please_wait.tr());
                                      return;
                                    }
                                    countdownTimerController =
                                        CountdownTimerController(
                                            endTime: endTime, onEnd: onEnd);
                                    if (_emailController.text.isEmpty) {
                                      showMessage(
                                          LocaleKeys.lbl_email_not_empty.tr());
                                      return;
                                    } else if (!regex
                                        .hasMatch(_emailController.text)) {
                                      showMessage(
                                          LocaleKeys.lbl_invalid_email.tr());
                                      return;
                                    }
                                    BlocProvider.of<AuthBloc>(context).add(
                                        SendOtpEvent(
                                            email: _emailController.text));
                                  },
                                  child: Text(
                                    LocaleKeys.lbl_send_again.tr(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: secondaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(end: 15.0),
                                  child: CountdownTimer(
                                    widgetBuilder: (_, remainingTime) {
                                      String seconds = remainingTime?.sec ==
                                          null
                                          ? '00'
                                          : (remainingTime!.sec!) < 10
                                          ? '0${remainingTime.sec}'
                                          : '${remainingTime.sec}';
                                      String minutes = remainingTime?.min ==
                                          null
                                          ? '00'
                                          : (remainingTime!.min!) < 10
                                          ? '0${remainingTime.min}'
                                          : '${remainingTime.min}';
                                      return Text(
                                        '$minutes : $seconds ',
                                      );
                                    },
                                    controller: countdownTimerController,
                                    onEnd: onEnd,
                                    endTime: endTime,
                                    endWidget: const SizedBox(),
                                  ),
                                ),
                              ])
                        ],
                      )
                    },
                if (currentMode == 3) ...{
                  CustomTextInput(
                      iconUrl: 'assets/auth_icons/password_icon.svg',
                      focusNode: _nodes[1],
                      controller: _passwordController,
                      labelText: LocaleKeys.lbl_create_new_password.tr()),
                  CustomTextInput(
                      iconUrl: 'assets/auth_icons/password_icon.svg',
                      focusNode: _nodes[2],
                      controller: _confirmPasswordController,
                      labelText: LocaleKeys.lbl_confirm_new_password.tr()),
                },
              ],
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            // buildWhen: (p, c) =>
            //     c is SignUpInProgress ||
            //     c is SignUpFailed ||
            //     c is SignUpDoneSuccessfully,
            listener: (context, state) {
              if (state is LogInDoneSuccessfully) {
                BlocProvider.of<AuthBloc>(context).add(GetProfileInfoEvent());
                Navigator.of(context).pushNamedAndRemoveUntil('wait',(route) => false,);
              }
              if (state is SendOtpDoneSuccessfully) {
                if(currentMode != 2) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    setState(() {
                      currentMode = 2;
                    });
                  });
                }else{
                  endTime = DateTime
                      .now()
                      .millisecondsSinceEpoch + 1000 * secondsDuration;
                  countdownTimerController = CountdownTimerController(
                      endTime: endTime, onEnd: onEnd);
                }
              }

              if (state is VerifyOtpDoneSuccessfully) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    currentMode = 3;
                  });
                });
              }
              if (state is UpdatePasswordDoneSuccessfully) {
                showMessage(LocaleKeys.lbl_password_updated.tr());
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    currentMode = 0;
                  });
                });
              }
              if (state is LoginFailed) {
                showMessage(state.errorMessage);
              }
              if (state is VerifyOtpFailed) {
                showMessage(state.errorMessage);
              }
              if (state is SendOtpFailed) {
                showMessage(state.errorMessage);
              }
              if (state is UpdatePasswordFailed) {
                showMessage(state.errorMessage);
              }
            },
            builder: (context, state) {
              if (state is LoginInProgress ||
                  state is VerifyOtpInProgress ||
                  state is SendOtpInProgress ||
                  state is UpdatePasswordInProgress) {
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
                      if (currentMode == 0) {
                        onTapFunction();
                        return;
                      }
                      if (currentMode == 1) {
                        endTime = DateTime
                            .now()
                            .millisecondsSinceEpoch + 1000 * secondsDuration;
                        countdownTimerController = CountdownTimerController(
                            endTime: endTime, onEnd: onEnd);
                        if (_emailController.text.isEmpty) {
                          showMessage(LocaleKeys.lbl_email_not_empty.tr());
                          return;
                        } else if (!regex.hasMatch(_emailController.text)) {
                          showMessage(LocaleKeys.lbl_invalid_email.tr());
                          return;
                        }
                        BlocProvider.of<AuthBloc>(context)
                            .add(SendOtpEvent(email: _emailController.text));
                      }
                      if (currentMode == 2) {
                        if ((code?.length ?? 0) != 6) {
                          showMessage(LocaleKeys.please_enter_otp.tr());
                          return;
                        }
                        BlocProvider.of<AuthBloc>(context).add(VerifyOtpEvent(
                            email: _emailController.text, code: code!));
                      }
                      if (currentMode == 3) {
                        if (_passwordController.text.length < 8) {
                          showMessage(LocaleKeys.lbl_password_8_char.tr());
                          return;
                        } else if (_confirmPasswordController.text !=
                            _passwordController.text) {
                          showMessage(
                              LocaleKeys.lbl_passwords_must_matched.tr());
                          return;
                        }
                        BlocProvider.of<AuthBloc>(context).add(
                            UpdatePasswordEvent(
                                code: code!,
                                email: _emailController.text,
                                password: _passwordController.text));
                      }
                    },
                    child: Container(
                      width: size.width - 40,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: tertiaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                            currentMode == 0
                                ? LocaleKeys.lbl_sign_in.tr()
                                : currentMode == 1
                                ? LocaleKeys.lbl_generate_otp.tr()
                                : currentMode == 2
                                ? LocaleKeys.lbl_verify.tr()
                                : LocaleKeys.lbl_submit.tr(),
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  if(currentMode == 0)...{
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.donot_have_account.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, 'signup');
                          },
                          child: Text(
                            LocaleKeys.lbl_sign_up.tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: tertiaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  },
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (currentMode == 0) {
                        setState(() {
                          currentMode = 1;
                        });
                      } else {
                        endTime = DateTime
                            .now()
                            .millisecondsSinceEpoch +
                            1000 * secondsDuration;
                        countdownTimerController =
                            CountdownTimerController(
                                endTime: endTime, onEnd: onEnd);
                        setState(() {
                          currentMode = 0;
                        });
                      }
                    },
                    child: Text(
                      currentMode == 0
                          ? LocaleKeys.lbl_forget_password.tr()
                          : LocaleKeys.lbl_cancel.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: tertiaryColor,
                      ),
                    ),
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
    if (_emailController.text.isEmpty) {
      showMessage(LocaleKeys.lbl_email_not_empty.tr());
      return;
    } else if (!regex.hasMatch(_emailController.text)) {
      showMessage(LocaleKeys.lbl_invalid_email.tr());
      return;
    } else if (_passwordController.text.length < 8) {
      showMessage(LocaleKeys.lbl_password_8_char.tr());
      return;
    }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showMessage(LocaleKeys.lbl_check_internet.tr());
      return;
    }
    Navigator.of(context).pushNamedAndRemoveUntil('home',(route) => false,);
    return ;
    BlocProvider.of<AuthBloc>(context).add(LoginEvent(
      email: _emailController.text,
      password: _passwordController.text,
    ));
    //showMessage('SignUp Successfully');
  }
}
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty || newValue.text.length > 9) {
      return oldValue;
    }
    return newValue;
  }
}

