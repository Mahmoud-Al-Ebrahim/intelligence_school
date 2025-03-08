part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String name;
  final int type;
  final String password;
  final String email;

  SignUpEvent({
    required this.name,
    required this.type,
    required this.password,
    required this.email,
  });
}

class CompleteProfileEvent extends AuthEvent {
  final File image;
  final String phone;
  final String address;
  final String? className;
  final String? subjectId;
  final String? description;

  CompleteProfileEvent({
    this.className,
    this.subjectId,
    this.description,
    required this.image,
    required this.address,
    required this.phone,
  });
}

class SendOtpEvent extends AuthEvent {
  final String email;

  SendOtpEvent({
    required this.email,
  });
}

class VerifyOtpEvent extends AuthEvent {
  final String email;
  final String code;

  VerifyOtpEvent({
    required this.email,
    required this.code,
  });
}

class LoginEvent extends AuthEvent {
  final String password;
  final String email;

  LoginEvent({
    required this.password,
    required this.email,
  });
}

class GetProfileInfoEvent extends AuthEvent{
}

class GetAllClassesEvent extends AuthEvent{
}

class GetAllSubjectsEvent extends AuthEvent{
}

class GetAllSectionsEvent extends AuthEvent{
}
class UpdatePasswordEvent extends AuthEvent{
  final String password;
  final String email;
  final String code;
  UpdatePasswordEvent({
    required this.password,
    required this.code,
    required this.email,
  });
}

class LogoutEvent extends AuthEvent{

}
class SolveHomeWork extends AuthEvent {
  final int userId;
  final int homeworkId;

  SolveHomeWork(this.userId , this.homeworkId);
}

class UpdateProfileEvent extends AuthEvent{
  final String firstName;
  final String lastName;
  final String phoneNumber;

  UpdateProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}