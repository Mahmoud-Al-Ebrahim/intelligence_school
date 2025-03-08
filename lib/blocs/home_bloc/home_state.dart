part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class AddHomeWorkInProgress extends HomeState {}
class GetExamsInProgress extends HomeState {}
class GetAttendanceInProgress extends HomeState {}
class StartExamInProgress extends HomeState {}
class RateStudentInProgress extends HomeState {}
class AssignHomeworkInProgress extends HomeState {}
class PayInProgress extends HomeState {}
class StoreStudentMarkInProgress extends HomeState {}
class AddAttendanceInProgress extends HomeState {}
class GetAllUsersInProgress extends HomeState {}
class GetUserLessonsInProgress extends HomeState {}
class GetAllSectionsInProgress extends HomeState {}
class GetMyPaymentsInProgress extends HomeState {}
class GetAllReportsInProgress extends HomeState {}
class GetReportDetailsInProgress extends HomeState {}

class GetAllReportsDoneSuccessfully extends HomeState {}
class GetReportDetailsDoneSuccessfully extends HomeState {}
class StoreStudentMarkDoneSuccessfully extends HomeState {}
class GetMyPaymentsDoneSuccessfully extends HomeState {}
class AddHomeWorkDoneSuccessfully extends HomeState {}
class GetExamsDoneSuccessfully extends HomeState {}
class GetAttendanceDoneSuccessfully extends HomeState {}
class StartExamDoneSuccessfully extends HomeState {
  final int examId;
  StartExamDoneSuccessfully(this.examId);
}
class RateStudentDoneSuccessfully extends HomeState {}
class PayDoneSuccessfully extends HomeState {}
class AddAttendanceDoneSuccessfully extends HomeState {}
class GetAllUsersDoneSuccessfully extends HomeState {}
class GetUserLessonsDoneSuccessfully extends HomeState {}
class GetAllSectionsDoneSuccessfully extends HomeState {}

class AddHomeWorkFailed extends HomeState {
  final String message;
  AddHomeWorkFailed(this.message);
}

class GetAllReportsDoneFailed extends HomeState {
  final String message;
  GetAllReportsDoneFailed(this.message);
}

class GetReportDetailsFailed extends HomeState {
  final String message;
  GetReportDetailsFailed(this.message);
}
class StoreStudentMarkFailed extends HomeState {
  final String message;
  StoreStudentMarkFailed(this.message);
}
class GetAllSectionsFailed extends HomeState {
  final String message;
  GetAllSectionsFailed(this.message);
}
class GetExamsFailed extends HomeState {
  final String message;
  GetExamsFailed(this.message);
}
class GetAttendanceFailed extends HomeState {
  final String message;
  GetAttendanceFailed(this.message);
}
class StartExamFailed extends HomeState {
  final String message;
  StartExamFailed(this.message);
}
class RateStudentFailed extends HomeState {
  final String message;
  RateStudentFailed(this.message);
}
class GetMyPaymentsFailed extends HomeState {
  final String message;
  GetMyPaymentsFailed(this.message);
}
class AssignHomeworkFailed extends HomeState {
  final String message;
  AssignHomeworkFailed(this.message);
}
class PayFailed extends HomeState {
  final String message;
  PayFailed(this.message);
}
class AddAttendanceFailed extends HomeState {
  final String message;
  AddAttendanceFailed(this.message);
}
class GetAllUsersFailed extends HomeState {
  final String message;
  GetAllUsersFailed(this.message);
}
class GetUserLessonsFailed extends HomeState {
  final String message;
  GetUserLessonsFailed(this.message);
}

