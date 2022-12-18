import 'package:counter/app/di.dart';
import 'package:counter/presentation/forgot_password/forgot_password.dart';
import 'package:counter/presentation/login/login.dart';
import 'package:counter/presentation/main/main_view.dart';
import 'package:counter/presentation/onboarding/onboarding.dart';
import 'package:counter/presentation/register/register.dart';
import 'package:counter/presentation/resources/string_manager.dart';
import 'package:counter/presentation/splash/splash.dart';
import 'package:counter/presentation/store_detail/store_detail.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (_) => const OnboardingView(),
        );
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => const RegisterView(),
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordView(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (_) => const MainView(),
        );
      case Routes.storeDetailRoute:
        return MaterialPageRoute(
          builder: (_) => const StoreDetailView(),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
