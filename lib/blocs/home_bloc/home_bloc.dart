import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/locale_keys.g.dart';
import '../../service/api_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<AddHomeWork>(_onAddHomeWork);
    on<GetExams>(_onGetExams);
    on<GetAttendance>(_onGetAttendance);
    on<StartExam>(_onStartExam);
    on<RateStudent>(_onRateStudent);
    on<AssignHomeWorkToStudent>(_onAssignHomeWorkToStudent);
    on<Pay>(_onPay);
    on<StoreStudentMark>(_onStoreStudentMark);
    on<GetMyPayments>(_onGetMyPayments);
    on<AddAttendance>(_onAddAttendance);
    on<GetAllUsers>(_onGetAllUsers);
    on<GetAllReports>(_onGetAllReports);
    on<GetReportDetails>(_onGetReportDetails);
    on<GetUserLessons>(_onGetUserLessons);
    on<GetAllSections>(_onGetAllSections);
  }

  // AllSectionsModel? allSectionsModel;
  // AttendanceModel? attendanceModel;
  // AllUsersModel? allUsersModel;
  // ExamsModel? examsModel;
  // MyPaymentsModel? myPaymentsModel;
  // ReportsModel? reportsModel;
  // ReportDetailsModel? reportDetailsModel ;
  // LessonsModel? lessonsModel;

  FutureOr<void> _onAddHomeWork(
      AddHomeWork event, Emitter<HomeState> emit) async {
    emit(AddHomeWorkInProgress());
    await ApiService.postMethod(
        endPoint: 'homework/add',
        formData: FormData.fromMap({
          'text': event.text,
          'end_date': event.date,
          'teacher_id': event.teacherId,
          'type_section_id': event.typeSectionId
        })).then((response) {
      print(response.data);
      int homeworkId = response.data['data']['id'];
      add(AssignHomeWorkToStudent(homeworkId, event.users));
    }).catchError((error) {
      print(error);
      emit(AddAttendanceFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(AddAttendanceFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetExams(GetExams event, Emitter<HomeState> emit) async {
    emit(GetExamsInProgress());
    await ApiService.getMethod(
        endPoint: 'user/examps',
        queryParameters: {'user_id': event.userId.toString()}).then((response) {
      print(response.data);
      // examsModel = ExamsModel.fromJson(response.data);
      emit(GetExamsDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetExamsFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(GetExamsFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetAttendance(
      GetAttendance event, Emitter<HomeState> emit) async {
    emit(GetAttendanceInProgress());
    await ApiService.getMethod(
        endPoint: 'user/attendance',
        queryParameters: {'user_id': event.userId.toString()}).then((response) {
      print(response.data);
      // attendanceModel = AttendanceModel.fromJson(response.data);
      emit(GetAttendanceDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetAttendanceFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(GetAttendanceFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onStartExam(StartExam event, Emitter<HomeState> emit) async {
    emit(StartExamInProgress());
    await ApiService.getMethod(endPoint: 'user/user_start_examp',queryParameters: {
      'user_id':event.userId.toString(),
      'examp_id':event.examId.toString(),
    }).then((response) {
      print(response.data);
      add(GetExams(event.userId));
      emit(StartExamDoneSuccessfully(event.examId!));
    }).catchError((error) {
      print(error);
      emit(StartExamFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(StartExamFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetUserLessons(
      GetUserLessons event, Emitter<HomeState> emit) async {
    emit(GetUserLessonsInProgress());
    await ApiService.getMethod(endPoint: 'user/user_lessons').then((response) {
      print(response.data);
      // lessonsModel = LessonsModel.fromJson(response.data);
      emit(GetUserLessonsDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetUserLessonsFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(GetUserLessonsFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetAllUsers(
      GetAllUsers event, Emitter<HomeState> emit) async {
    emit(GetAllUsersInProgress());
    await ApiService.getMethod(endPoint: 'user').then((response) {
      print(response.data);
      // allUsersModel = AllUsersModel.fromJson(response.data);
      emit(GetAllUsersDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetAllUsersFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(GetAllUsersFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onAddAttendance(
      AddAttendance event, Emitter<HomeState> emit) async {
    emit(AddAttendanceInProgress());
    await ApiService.getMethod(endPoint: 'secretary/add_users_attendance',body: {
      'attendance_day' : event.attendanceDay,
      'user_ids' : event.userIds,
    }).then((response) {
      emit(AddAttendanceDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(AddAttendanceFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(AddAttendanceFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onPay(Pay event, Emitter<HomeState> emit) async {
    emit(PayInProgress());
    await ApiService.postMethod(
        endPoint: 'payment/pay',
        formData: FormData.fromMap({
          'user_id': event.userId,
          'amount': event.amount,
          'stripeToken': 'tok_visa',
          'payment_id': event.paymentId
        })).then((response) {
      print(response.data);
      add(GetMyPayments(event.userId));
    }).catchError((error) {
      print(error);
      emit(PayFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(PayFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onAssignHomeWorkToStudent(
      AssignHomeWorkToStudent event, Emitter<HomeState> emit) async {
    await ApiService.postMethod(
        endPoint: 'homework/add_hw_to_users',
        formData: FormData.fromMap({
          'homework_id': event.homeWorkId,
          'user_ids': event.users,
        })).then((response) {
      print(response.data);
      emit(AddHomeWorkDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(AddHomeWorkFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(AddHomeWorkFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onRateStudent(
      RateStudent event, Emitter<HomeState> emit) async {
    emit(RateStudentInProgress());
    await ApiService.postMethod(
        endPoint: 'teacher/rate_student',
        formData: FormData.fromMap({
          'teacher_id': event.teacherId,
          'user_id': event.userId,
          'grading': event.rate,
        })).then((response) {
      print(response.data);
      emit(RateStudentDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(RateStudentFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(RateStudentFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }


  FutureOr<void> _onGetAllSections(GetAllSections event, Emitter<HomeState> emit) async{
    emit(GetAllSectionsInProgress());
    await ApiService.getMethod(endPoint: 'section').then((response) {
      print(response.data);
      // allSectionsModel = AllSectionsModel.fromJson(response.data);
      emit(GetAllSectionsDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetAllSectionsFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(GetAllSectionsFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetMyPayments(GetMyPayments event, Emitter<HomeState> emit) async {

    emit(GetMyPaymentsInProgress());
    await ApiService.getMethod(endPoint: 'payment/studnet_payment',queryParameters: {
      'user_id':event.userId.toString()
    }).then((response) {
      print(response.data);
      // myPaymentsModel = MyPaymentsModel.fromJson(response.data);
      emit(GetMyPaymentsDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetMyPaymentsFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(GetMyPaymentsFailed(LocaleKeys.something_went_wrong.tr()));
    });

  }

  FutureOr<void> _onStoreStudentMark(StoreStudentMark event, Emitter<HomeState> emit) async{
    emit(StoreStudentMarkInProgress());
    await ApiService.getMethod(endPoint: 'payment/store_mark',queryParameters: {
      'user_id':event.userId.toString(),
      'exam_id':event.examId.toString(),
      'mark':event.mark.toString(),
    }).then((response) {
      print(response.data);
      emit(StoreStudentMarkDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(StoreStudentMarkFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(StoreStudentMarkFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetAllReports(GetAllReports event, Emitter<HomeState> emit) async{
    emit(GetAllReportsInProgress());
    await ApiService.getMethod(endPoint: 'user/get_reports',queryParameters: {
      'user_id':event.userId.toString(),
    }).then((response) {
      print(response.data);
      // reportsModel = ReportsModel.fromJson(response.data);
      emit(GetAllReportsDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetAllReportsDoneFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(GetAllReportsDoneFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

  FutureOr<void> _onGetReportDetails(GetReportDetails event, Emitter<HomeState> emit) async {
    emit(GetReportDetailsInProgress());
    await ApiService.getMethod(endPoint: 'user/show_report',queryParameters: {
      'user_id':event.userId.toString(),
      'report_id':event.userId.toString(),
    }).then((response) {
      print(response.data);
      // reportDetailsModel = ReportDetailsModel.fromJson(response.data);
      emit(GetReportDetailsDoneSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetReportDetailsFailed(error.response.data['message']));
    }).onError((error, stackTrace) {
      print(error);
      emit(GetReportDetailsFailed(LocaleKeys.something_went_wrong.tr()));
    });
  }

}
