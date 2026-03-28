import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/core/constants/color_constants.dart';
import 'package:riot_tracker/app/core/constants/size_constant.dart';
import 'package:riot_tracker/app/presentations/views/widget_tree/widget_tree_view_controller.dart';
import '../../widgets/text_widget.dart';
import '../champions/champion_view.dart';
import '../profile/profile_view.dart';
import '../setting/setting_view.dart';

class WidgetTreeView extends GetView<WidgetTreeViewController> {
  WidgetTreeView({super.key});

  final List<Widget> listViews = [
    ChampionView(),
    ProfileView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: TextWidget(
          text: "Riot Tracker",
          color: AppColors.red,
          size: AppTextSize.body_large,
        ),
      ),
      body: Obx(() => listViews[controller.selectedPage.value]),
      bottomNavigationBar: NavigationBarTheme(
        data: _navigationBarConfig(),
        child: Obx(
              () => NavigationBar(
            backgroundColor: AppColors.white,
            selectedIndex: controller.selectedPage.value,
            onDestinationSelected: (value) =>
            controller.selectedPage.value = value,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.collections_bookmark),
                label: "Champions",
              ),
              NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
              NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
            ],
          ),
        ),
      ),
    );
  }

  NavigationBarThemeData _navigationBarConfig() {
    return NavigationBarThemeData(
        indicatorColor: AppColors.red,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
              (states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: AppColors.white);
            }
            return IconThemeData(color: AppColors.black);
          },
        ),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(color: AppColors.red);
            }
            return TextStyle(color: AppColors.black);
          },
        ),
      );
  }
}
