import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:riot_tracker/app/core/constants/assets_constant.dart';
import 'package:riot_tracker/app/core/constants/color_constants.dart';
import 'package:riot_tracker/app/core/constants/size_constant.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';
import 'package:riot_tracker/app/ui/views/splash/splash_view_controller.dart';

class SplashView extends GetView<SplashViewController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(valueListenable: isDarkModeNotifier, builder: (context, isDarkMode, child) {
          return Container(
            decoration: BoxDecoration(
                gradient: isDarkMode ? AppColors.darkGradient : AppColors.lightGradient
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(initLottie),
                height20,
                Text("Riot Tracker",style: TextStyle(
                    fontFamily: "FrizQuadrata",
                    color: AppColors.red,
                    letterSpacing: 10,
                    fontSize: 42,
                    fontWeight: FontWeight.w400
                ),),
              ],
            ),
          );
        },),
      )
    );
  }
}
