import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/core/routes/app_routes.dart';
import 'package:riot_tracker/app/core/storage/user_storage.dart';
import 'package:riot_tracker/app/ui/widgets/elevated_button_widget.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButtonWidget(text: "Logout", onPressesd: () async {
          try {
            await UserStorage.clear();
            Get.offAllNamed(AppRoutes.init);
          } catch (e) {
            print(e);
          }
        }),
      ),
    );
  }
}
