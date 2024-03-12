import 'package:get/get.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/daily_login_page_view.dart';

import '../modules/auth_page/bindings/auth_page_binding.dart';
import '../modules/auth_page/views/auth_page_view.dart';
import '../modules/create_job/bindings/create_job_binding.dart';
import '../modules/create_job/views/create_job_view.dart';
import '../modules/declaration_page/bindings/declaration_page_binding.dart';
import '../modules/declaration_page/views/declaration_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/roster_history.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/term_and_condition/bindings/term_and_condition_binding.dart';
import '../modules/term_and_condition/views/term_and_condition_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      bindings: [HomeBinding(), CreateJobBinding()],
    ),
    GetPage(
      name: _Paths.ROSTER_HISTORY_PAGE,
      page: () => const ShowRosterHistoryView(),
      bindings: [HomeBinding(), CreateJobBinding()],
    ),

    GetPage(
      name: _Paths.AUTH_PAGE,
      page: () => const AuthPageView(),
      binding: AuthPageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_JOB,
      page: () => const CreateJobView(),
      binding: CreateJobBinding(),
    ),
    GetPage(
      name: _Paths.DECLARATION_PAGE,
      page: () => const DeclarationPageView(),
      binding: DeclarationPageBinding(),
    ),
    GetPage(
      name: _Paths.DAILY_LOGIN,
      page: () => const DailyLoginPageView(),
    ),
    GetPage(
      name: _Paths.TERM_AND_CONDITION,
      page: () => const TermAndConditionView(),
      binding: TermAndConditionBinding(),
    ),
  ];
}
