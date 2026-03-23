import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/core/constants/color_constants.dart';
import 'package:riot_tracker/app/core/constants/size_constant.dart';
import 'package:riot_tracker/app/ui/views/collection/collection_view.dart';
import 'package:riot_tracker/app/ui/views/setting/setting_view.dart';
import 'package:riot_tracker/app/ui/views/widget_tree/widget_tree_view_controller.dart';
import 'package:riot_tracker/app/ui/widgets/text_widget.dart';

import '../profile/profile_view.dart';

class WidgetTreeView extends GetView<WidgetTreeViewController> {
  WidgetTreeView({super.key});

  final List<Widget> listViews = [
    CollectionView(),
    ProfileView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: TextWidget(text: "Riot Tracker",color: AppColors.red,size: AppTextSize.body_large,)
      ),
      body: Obx(() => listViews[controller.selectedPage.value]),
      bottomNavigationBar: Obx(
            () => NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.collections_bookmark),
              label: "Collection",
            ),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
            NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
          ],
          onDestinationSelected:
              (value) => controller.selectedPage.value = value,
          selectedIndex: controller.selectedPage.value,
        ),
      ),
    );
  }
}
