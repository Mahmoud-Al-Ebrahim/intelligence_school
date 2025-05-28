import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../../blocs/fetch_image/fetch_image_cubit.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../service/show_message.dart';
import '../../../../theme/colors.dart';
import '../../../../widgets/custom_text_input.dart';
import '../../../../widgets/loading_indicator/loader_indicator.dart';
import '../../../app/drop_down_menu.dart';
import '../widgets/fetch_image.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _descriptionController;
  String? className;
  String? subjectName;
  int? subjectId;
  int? type;

  final List<FocusNode> _nodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void dispose() {
    _addressController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    type = BlocProvider.of<AuthBloc>(context).type!;
    if (type == 1) {
      BlocProvider.of<AuthBloc>(context).add(GetAllClassesEvent());
    } else {
      BlocProvider.of<AuthBloc>(context).add(GetAllSubjectsEvent());
    }
    _phoneController = TextEditingController();
    _descriptionController = TextEditingController();
    _addressController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 60,
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
            child: SizedBox(
              height: 150,
              child: Center(
                child: Text(
                  LocaleKeys.lbl_complete_profile.tr(),
                  style: const TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 20.0, start: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FetchImage(),
                CustomTextInput(
                    iconUrl: 'assets/auth_icons/phone.svg',
                    focusNode: _nodes[0],
                    controller: _phoneController,
                    labelText: LocaleKeys.lbl_phone_number.tr()),
                CustomTextInput(
                    iconUrl: 'assets/auth_icons/address.svg',
                    focusNode: _nodes[1],
                    controller: _addressController,
                    labelText: LocaleKeys.lbl_address.tr()),
                SizedBox(
                  height: 20,
                ),
                if (type == 1)...{
                  Text(
                    LocaleKeys.lbl_class.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                    ),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (p, c) =>
                    c is GetAllClassesFailed ||
                        c is GetAllClassesDoneSuccessfully ||
                        c is GetAllClassesInProgress,
                    builder: (context, state) {
                      // if (state is GetAllClassesInProgress ||
                      //     BlocProvider
                      //         .of<AuthBloc>(context)
                      //         .getAllClassesModel ==
                      //         null) {
                      //   return Center(
                      //     child: LoaderIndicator(),
                      //   );
                      // }
                      // if (state is GetAllClassesFailed) {
                      //   return Center(
                      //       child: ErrorText(message: state.errorMessage));
                      // }
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(end: 20.0),
                        child: DropDownMenu<String>(
                          items: ['صف رابع' , 'صف خامس' , 'صف سادس'],
                          // BlocProvider
                          //     .of<AuthBloc>(context)
                          //     .getAllClassesModel!
                          //     .data!
                          //     .map((e) => e.name!)
                          //     .toList(),
                          onChange: (data) {
                            className = data;
                          },
                        ),
                      );
                    },
                  ),
                },
                if (type != 1) ...{
                  CustomTextInput(
                      iconUrl: 'assets/auth_icons/name.svg',
                      focusNode: _nodes[2],
                      controller: _descriptionController,
                      labelText: LocaleKeys.lbl_description.tr()),
                  Text(
                    LocaleKeys.lbl_subject.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                    ),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (p, c) =>
                        c is GetAllSubjectsFailed ||
                        c is GetAllSubjectsDoneSuccessfully ||
                        c is GetAllSubjectsInProgress,
                    builder: (context, state) {
                      // if (state is GetAllSubjectsInProgress ||
                      //     BlocProvider.of<AuthBloc>(context)
                      //             .getAllSubjectsModel ==
                      //         null) {
                      //   return Center(
                      //     child: LoaderIndicator(),
                      //   );
                      // }
                      // if (state is GetAllSubjectsFailed) {
                      //   return Center(
                      //       child: ErrorText(message: state.errorMessage));
                      // }
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(end: 20.0),
                        child: DropDownMenu<String>(
                          items: [],

                          // BlocProvider.of<AuthBloc>(context)
                          //     .getAllSubjectsModel!
                          //     .data!
                          //     .map((e) => e.name!)
                          //     .toList(),
                          onChange: (data) {
                            subjectName = data;
                            // subjectId = BlocProvider.of<AuthBloc>(context)
                            //     .getAllSubjectsModel!
                            //     .data!
                            //     .firstWhere((element) => element == subjectName)
                            //     .id;
                          },
                        ),
                      );
                    },
                  ),
                }
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<AuthBloc, AuthState>(
              buildWhen: (p, c) =>
                  c is CompleteProfileInProgress ||
                  c is CompleteProfileFailed ||
                  c is CompleteProfileDoneSuccessfully,
              listener: (context, state) {
                // if (state is CompleteProfileDoneSuccessfully) {
                //   BlocProvider.of<AuthBloc>(context).add(GetProfileInfoEvent());
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //     'wait',
                //     (route) => false,
                //   );
                // }
                // if (state is CompleteProfileFailed) {
                //   showMessage(state.errorMessage);
                // }
              },
              builder: (context, state) {
                if (state is CompleteProfileInProgress) {
                  return LoaderIndicator();
                }
                return Column(
                  children: [
                    GestureDetector(
                      onTap: onTapFunction,
                      child: Container(
                        width: size.width - 40,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(LocaleKeys.lbl_submit.tr(),
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
              })
        ]));
  }

  onTapFunction() async {
    if (_phoneController.text.isEmpty) {
      showMessage(LocaleKeys.lbl_phone_not_empty.tr());
      return;
    } else if (_addressController.text.isEmpty) {
      showMessage(LocaleKeys.lbl_address_not_empty.tr());
      return;
    } else if (className == null && type == 1) {
      showMessage(LocaleKeys.lbl_class_not_empty.tr());
      return;
    } else if (_descriptionController.text.isEmpty && type == 2) {
      showMessage(LocaleKeys.lbl_description_not_empty.tr());
      return;
    } else if (subjectId == null && type == 2) {
      showMessage(LocaleKeys.lbl_subject_not_empty.tr());
      return;
    } else if (context.read<FetchImageCubit>().image == null) {
      showMessage(LocaleKeys.lbl_image_not_empty.tr());
      return;
    }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showMessage(LocaleKeys.lbl_check_internet.tr());
      return;
    }
      Navigator.of(context).pushNamedAndRemoveUntil(
        'home',
        (route) => false,
      );
    return ;
    BlocProvider.of<AuthBloc>(context).add(CompleteProfileEvent(
      phone: _phoneController.text,
      image: context.read<FetchImageCubit>().image!,
      address: _addressController.text,
      description: _descriptionController.text,
      subjectId: subjectId.toString(),
      className: className!,
    ));
    //showMessage('SignUp Successfully');
  }

  int getTypeFromItsName(String name) {
    if (name == LocaleKeys.lbl_student.tr()) {
      return 0;
    }
    if (name == LocaleKeys.lbl_teacher.tr()) {
      return 1;
    }
    return 2;
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
