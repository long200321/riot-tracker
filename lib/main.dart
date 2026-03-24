import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/bindings/account_binding.dart';
import 'package:riot_tracker/app/core/routes/app_pages.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';
import 'package:riot_tracker/app/ui/widgets/app_background_widget.dart';

import 'app/core/constants/color_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(AppBackground(child: MyApp()));

  await dotenv.load(fileName: ".env");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, darkMode, _) {
        return GetMaterialApp(
          initialBinding: AccountBinding(),
          debugShowCheckedModeBanner: false,
          title: "Riot Tracker",
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
          ),
          getPages: AppPages.pages,
          builder: (context, child) {
            return AppBackground(
              gradient: darkMode
                  ? AppColors.darkGradient
                  : AppColors.lightGradient,
              child: child!,
            );
          },
        );
      },
    );
  }
}
