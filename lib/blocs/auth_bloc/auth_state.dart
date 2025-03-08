part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

 class AuthInitialState extends AuthState{}

class SolveHomeworkInProgress extends AuthState {}

class SolveHomeworkFailed extends AuthState {
  final String message;
  SolveHomeworkFailed(this.message);
}
class SolveHomeworkDoneSuccessfully extends AuthState {}

class GetAllSubjectsInProgress extends AuthState {}
class SendOtpInProgress extends AuthState {}
class GetAllClassesInProgress extends AuthState {}
class VerifyOtpInProgress extends AuthState {}
class SignUpInProgress extends AuthState {}
class LoginInProgress extends AuthState {}
class CompleteProfileInProgress extends AuthState {}
class LogoutInProgress extends AuthState {}
class UpdateProfileInProgress extends AuthState {}
class UpdatePasswordInProgress extends AuthState {}
class GetProfileInProgress extends AuthState {}

class GetAllSubjectsDoneSuccessfully extends AuthState {}
class VerifyOtpDoneSuccessfully extends AuthState {}
class SendOtpDoneSuccessfully extends AuthState {}
class GetAllClassesDoneSuccessfully extends AuthState {}
class CompleteProfileDoneSuccessfully extends AuthState {}
class LogoutDoneSuccessfully extends AuthState {}
class LogInDoneSuccessfully extends AuthState {}
class UpdatePasswordDoneSuccessfully extends AuthState {}
class UpdateProfileDoneSuccessfully extends AuthState {
  //final SignUpModel userModel;
  UpdateProfileDoneSuccessfully(
      //{required this.userModel}
      );
}
class GetProfileDoneSuccessfully extends AuthState {
  final int type ;
  GetProfileDoneSuccessfully(this.type);
}
class SignUpDoneSuccessfully extends AuthState {
  SignUpDoneSuccessfully();
}

class SignUpFailed extends AuthState {
  final String errorMessage;
  SignUpFailed({required this.errorMessage});
}

class GetAllSubjectsFailed extends AuthState {
  final String errorMessage;
  GetAllSubjectsFailed({required this.errorMessage});
}

class VerifyOtpFailed extends AuthState {
  final String errorMessage;
  VerifyOtpFailed({required this.errorMessage});
}

class SendOtpFailed extends AuthState {
  final String errorMessage;
  SendOtpFailed({required this.errorMessage});
}

class GetAllClassesFailed extends AuthState {
  final String errorMessage;
  GetAllClassesFailed({required this.errorMessage});
}

class CompleteProfileFailed extends AuthState {
  final String errorMessage;
  CompleteProfileFailed({required this.errorMessage});
}
class LoginFailed extends AuthState {
  final String errorMessage;
  LoginFailed({required this.errorMessage});
}
class UpdateProfileFailed extends AuthState {
  final String errorMessage;
  UpdateProfileFailed({required this.errorMessage});
}
class UpdatePasswordFailed extends AuthState {
  final String errorMessage;
  UpdatePasswordFailed({required this.errorMessage});
}
class GetProfileInfoFailed extends AuthState {
  final String errorMessage;
  GetProfileInfoFailed({required this.errorMessage});
}
class LogoutFailed extends AuthState {
  final String errorMessage;
  LogoutFailed({required this.errorMessage});
}

class LogInFailed extends AuthState {
  final String errorMessage;
  LogInFailed({required this.errorMessage});
}