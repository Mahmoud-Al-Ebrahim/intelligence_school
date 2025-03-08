import 'dart:async';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:mime_type/mime_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../service/api_service.dart';
import '../../service/notification/notification_process.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) {});
    on<SolveHomeWork>(_onSolveHomeWork);
    on<GetAllClassesEvent>(_onGetAllClassesEvent);
    on<GetAllSubjectsEvent>(_onGetAllSubjectsEvent);
    on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<CompleteProfileEvent>(_onCompleteProfileEvent);
    on<LoginEvent>(_onLoginEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<UpdatePasswordEvent>(_onUpdatePasswordEvent);
    on<GetProfileInfoEvent>(_onGetProfileInfoEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
  }

  saveId(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('id', id);
  }

  int? accountId;

  String? name;

  // GetAllClassesModel? getAllClassesModel;
  //
  // AllSubjectsModel? getAllSubjectsModel;
  //
  // HomeModel? homeModel;
  int? type;

  FutureOr<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginInProgress());
    await ApiService.postMethod(
        endPoint: 'auth/login',
        formData: FormData.fromMap({
          'password': event.password,
          'email': event.email,
        })).then((response) {
      print(response.data);
      accountId =response.data['user']['id'];
      type =  int.parse(response.data['user']['type']);
      saveId(accountId!);
      name =response.data['user']['name'];
      saveToken(response.data['access_token']);
      ApiService.init();
      emit(LogInDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(LoginFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(LoginFailed(errorMessage: 'something went Wrong'));
    });
  }

  FutureOr<void> _onUpdateProfileEvent(
      UpdateProfileEvent event, Emitter<AuthState> emit) async {
    emit(UpdateProfileInProgress());
    await ApiService.patchMethod(endPoint: 'users/updateMe', body: {
      'first_Name': event.firstName,
      'last_Name': event.lastName,
      'phone_number': event.phoneNumber,
    }).then((response) {
      print(response);
      // emit(GetProfileDoneSuccessfully(
      //     userModel: ProfileModel.fromJson(response.data['data'])));
    }).catchError((error) {
      print(error);
      emit(UpdateProfileFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(UpdateProfileFailed(
          errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onUpdatePasswordEvent(
      UpdatePasswordEvent event, Emitter<AuthState> emit) async {
    emit(UpdatePasswordInProgress());
    await ApiService.postMethod(
        endPoint: 'auth/reset-password',
        formData: FormData.fromMap({
          'email': event.email,
          'code': event.code,
          'password': event.password,
          'password_confirmation': event.password,
        })).then((response) {
      emit(UpdatePasswordDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(UpdatePasswordFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(UpdatePasswordFailed(
          errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetProfileInfoEvent(
      GetProfileInfoEvent event, Emitter<AuthState> emit) async {
    emit(GetProfileInProgress());
    await ApiService.getMethod(endPoint: 'auth/profile').then((response) {
      print(response.data);
      // homeModel = HomeModel.fromJson(response.data);
      // type = int.parse(homeModel!.account!.type!);
      emit(GetProfileDoneSuccessfully(type!));
    }).catchError((error) {
      print(error);
      emit(GetProfileInfoFailed(errorMessage: error.response.data['message']));
      Future.delayed(Duration(seconds: 5 ,),() {
        add(GetProfileInfoEvent());
      },);
    }).onError((error, stackTrace) {
      print(error);
      emit(GetProfileInfoFailed(
          errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
    emit(LogoutInProgress());
    await ApiService.postMethod(endPoint: 'users/logout').then((response) {
      emit(LogoutDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(LogoutFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(LogoutFailed(errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(SignUpInProgress());
    print(event.type);
    await ApiService.postMethod(
        endPoint: 'auth/register',
        formData: FormData.fromMap({
          'email': event.email,
          'password_confirmation': event.password,
          'password': event.password,
          'name': event.name,
          'type': event.type.toString(),
        })).then((response) {
      type = event.type;
      print(response.data);
      accountId = response.data['account']['original']['user']['id'];
      saveId(accountId!);
      name = response.data['account']['original']['user']['name'];
      saveToken(response.data['account']['original']['access_token']);
      ApiService.init();
      emit(SignUpDoneSuccessfully());
    }).catchError((error) {
      print(error);
      print(error.response);
      emit(SignUpFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {
      print(stackTrace);
      print(error);
      emit(SignUpFailed(errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onCompleteProfileEvent(
      CompleteProfileEvent event, Emitter<AuthState> emit) async {
    emit(CompleteProfileInProgress());
    String fileName = event.image.path.split('/').last;
    String mimeType = mime(fileName) ?? '';
    String mimee = mimeType.split('/')[0];
    String type = mimeType.split('/')[1];
    Map<String , dynamic> data = {
      "image": await MultipartFile.fromFile(
        event.image.path,
        filename: fileName,
        contentType: MediaType(mimee, type),
      ),
      'phone': event.phone,
      'address': event.address,
      'account_id': accountId,
      'name': name,
      'fcm_token': NotificationProcess.myFcmToken
    };
    if(this.type == 1){
      data['class_name'] = event.className ;
    }else{
      data['subject_id'] = event.subjectId ;
      data['description'] = event.description ;
    }
    await ApiService.postMethod(
      endPoint: this.type == 1 ? 'user/add' : 'teacher/add',
      formData: FormData.fromMap(data),
    ).then((response) {
      print(response.data);
      emit(CompleteProfileDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(CompleteProfileFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(CompleteProfileFailed(
          errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onSendOtpEvent(
      SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(SendOtpInProgress());
    await ApiService.postMethod(
        endPoint: 'auth/forgot_password',
        formData: FormData.fromMap({
          'email': event.email,
        })).then((response) {
      print(response.data);
      if (response.data['status']) {
        emit(SendOtpDoneSuccessfully());
      } else {
        emit(SendOtpFailed(errorMessage: LocaleKeys.something_went_wrong.tr()));
      }
    }).catchError((error) {
      print(error);
      emit(SendOtpFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(SendOtpFailed(errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onVerifyOtpEvent(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(VerifyOtpInProgress());
    await ApiService.postMethod(
        endPoint: 'auth/verify-reset-code',
        formData: FormData.fromMap({
          'email': event.email,
          'code': event.code,
        })).then((response) {
      print(response.data);
      emit(VerifyOtpDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(VerifyOtpFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(VerifyOtpFailed(errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetAllClassesEvent(
      GetAllClassesEvent event, Emitter<AuthState> emit) async {
    emit(GetAllClassesInProgress());
    await ApiService.getMethod(endPoint: 'type').then((response) {
      print(response.data);
      // getAllClassesModel = GetAllClassesModel.fromJson(response.data);
      emit(GetAllClassesDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetAllClassesFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {

      print(error);
      emit(GetAllClassesFailed(
          errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetAllSubjectsEvent(GetAllSubjectsEvent event, Emitter<AuthState> emit)async {
    emit(GetAllSubjectsInProgress());
    await ApiService.getMethod(endPoint: 'subject').then((response) {
      print(response.data);
      // getAllSubjectsModel = AllSubjectsModel.fromJson(response.data);
      emit(GetAllSubjectsDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetAllSubjectsFailed(errorMessage: error.response.data['message']));
    }).onError((error, stackTrace) {

      emit(GetAllSubjectsFailed(
          errorMessage: LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onSolveHomeWork(SolveHomeWork event, Emitter<AuthState> emit) async{
    emit(SolveHomeworkInProgress());
    await ApiService.getMethod(endPoint: 'user/solve_hw',queryParameters: {
      'user_id':event.userId.toString(),
      'homework_id':event.homeworkId.toString(),
    }).then((response) {
      print(response.data);
      // List<Homework> homeWorks = List.of(homeModel!.homework ?? []);
      // int index = homeWorks.indexWhere((element) => element.id == event.homeworkId);
      // homeWorks[index] = homeWorks[index].copyWith(
      //   answer: 1
      // );
      // homeModel = homeModel!.copyWith(
      //   homework: homeWorks
      // );
      emit(SolveHomeworkDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(SolveHomeworkFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(SolveHomeworkFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

}
