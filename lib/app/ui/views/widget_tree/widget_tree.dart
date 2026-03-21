import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/ui/views/init/init_controller.dart';

class WidgetTree extends StatelessWidget {
  WidgetTree({super.key});

  final controller = Get.find<InitViewController>();

  @override
  Widget build(BuildContext context) {
    final account = controller.account;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.handshake),
            Text("Riot Tracker")
          ],
        ),
      ),
      body: Center(
        child: Obx(() => Text("Welcome ${account.value?.gameName}#${account.value?.tagLine}"),),
      ),
    );
  }
}
