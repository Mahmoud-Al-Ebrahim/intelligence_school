import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/home/presentation/pages/fee_details_page.dart';
import 'features/home/presentation/pages/homework_page.dart';
import 'features/authentication/presentation/pages/profile_page.dart';
import 'features/attendance/presentation/pages/attendance_page_details.dart';
import 'features/events/presentation/pages/calendar_page.dart';
import 'features/home/presentation/pages/notice_page.dart';
import 'features/multi media/presentation/pages/multi_media_page.dart';
import 'package:intelligence_school/service/api_service.dart';
import 'package:intelligence_school/service/language_service.dart';
import 'package:intelligence_school/service/localization_service.dart';
import 'package:intelligence_school/service/notification/local_notification_service.dart';
import 'package:intelligence_school/splash_page.dart';

import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/fetch_image/fetch_image_cubit.dart';
import 'blocs/focus_node_cubit/focus_node_cubit.dart';
import 'blocs/home_bloc/home_bloc.dart';
import 'blocs/sensitive_connectivity/connectivity_observer.dart';
import 'blocs/sensitive_connectivity/sensitive_connectivity_bloc.dart';
import 'features/examination/presentation/pages/exam_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/pages/notice_details_page.dart';
import 'features/attendance/presentation/pages/annual_attendance_page.dart';
import 'features/authentication/presentation/pages/sign_up_page.dart';
import 'features/chat/presentation/pages/chats_screen.dart';
import 'features/chat/presentation/pages/message_screen.dart';
import 'features/examination/presentation/pages/exams_page.dart';
import 'on_boarding.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  LocalNotificationService().showNotificationWithPayload(message: message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //NotificationProcess().init();
  //NotificationProcess().fcmToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  ApiService.init();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LocalizationService(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => SensitiveConnectivityBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => AuthBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => HomeBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => FocusNodeCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => FetchImageCubit(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            theme: ThemeData.light()
              ..copyWith(
                colorScheme:
                const ColorScheme.light(secondary: Colors.transparent),
              ),
            builder: (context, child) {
              LanguageService(context);
              ConnectivityObserver.createInstance(context);
              return child!;
            },
            debugShowCheckedModeBanner: false,
            home: const SplashPage(),
            routes: {
              'boarding': (context) => const OnBoardingPage(),
              'login': (context) => const LoginPage(),
              'signup': (context) => const SignUpPage(),
              'profile': (context) => const ProfilePage(),
              'home': (context) => const HomePage(),
              'chats-page': (context) => const ChatsScreen(),
              'messages-page': (context) => const MessagesScreen(),
              'exams': (context) => const ExamsPage(),
              'exam': (context) => const ExamPage(),
              'notices': (context) => const NoticePage(),
              'notice-details': (context) => const NoticeDetailsPage(),
              'attendance': (context) => const AnnualAttendancePage(),
              'fee': (context) => const FeeDetailsPage(),
              'media': (context) => const MultiMediaPage(),
              'homework': (context) => const HomeworkPage(),
              'calendar': (context) => const CalendarPage(),
              "attendance_details" : (context)=> const AttendanceDetailsPage()
            },
          );
        }),
      ),
    );
  }
}
