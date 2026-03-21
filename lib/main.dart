import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/bindings/account_binding.dart';

import 'app/ui/views/init/init_view.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AccountBinding(),
      debugShowCheckedModeBanner: false,
      title: "Riot Tracker",
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => InitView(),
          binding: AccountBinding(),
        ),
      ],
    );
  }
}
