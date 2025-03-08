part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class AddHomeWork extends HomeEvent {
  final String text;
  final String date;
  final int teacherId;
  final int typeSectionId;
  final List<int> users;


  AddHomeWork(this.text, this.date, this.teacherId, this.typeSectionId,this.users);
}

class GetExams extends HomeEvent {
  final int userId;

  GetExams(this.userId);
}

class GetAttendance extends HomeEvent {
  final int userId;

  GetAttendance(this.userId);
}

class StartExam extends HomeEvent {
  final int examId;
  final int userId;

  StartExam(this.examId, this.userId);
}

class RateStudent extends HomeEvent {
  final double rate;
  final int userId;
  final int teacherId;

  RateStudent(this.rate, this.userId, this.teacherId);
}

class AssignHomeWorkToStudent extends HomeEvent {
  final int homeWorkId;
  final List<int> users;

  AssignHomeWorkToStudent(this.homeWorkId, this.users);
}

  class Pay extends HomeEvent {
  final int userId;
  final int paymentId;
  final String amount;

  Pay(this.userId, this.paymentId, this.amount);
}

class GetMyPayments extends HomeEvent{
  final int userId;
  GetMyPayments(this.userId);
}

class StoreStudentMark extends HomeEvent{
  final int examId;
  final int userId;
  final int mark;
  StoreStudentMark(this.userId , this.examId , this.mark);
}

class AddAttendance extends HomeEvent {
  final String attendanceDay;
  final List<int> userIds;

  AddAttendance(this.attendanceDay, this.userIds);
}

class GetAllSections extends HomeEvent {}

class GetAllUsers extends HomeEvent {}
class GetAllReports extends HomeEvent {
  final int userId;

  GetAllReports(this.userId);
}

class GetReportDetails extends HomeEvent {
  final int userId;
  final int reportId;

  GetReportDetails(this.userId , this.reportId);
}


class GetUserLessons extends HomeEvent {
  final int userId;

  GetUserLessons(this.userId);
}
