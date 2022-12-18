import 'dart:async';

import 'package:counter/app/app_prefs.dart';
import 'package:counter/app/di.dart';
import 'package:counter/presentation/resources/assets_manager.dart';
import 'package:counter/presentation/resources/color_manager.dart';
import 'package:counter/presentation/resources/routes_manger.dart';
import 'package:counter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();
  _startDelay() {
    _timer = Timer(const Duration(seconds: 5), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPreferences
            .isOnBoardingScreenViewed()
            .then((isOnboardingScreenViewed) {
          if (isOnboardingScreenViewed) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage(ImageAssets.splashLogo)),
            const SizedBox(
              height: AppPadding.p16,
            ),
            CircularProgressIndicator(
              color: ColorManager.white,
            )
          ],
        ),
      ),
    );
  }
}
