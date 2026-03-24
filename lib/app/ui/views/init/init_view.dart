import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:riot_tracker/app/core/constants/assets_constant.dart';
import 'package:riot_tracker/app/core/constants/color_constants.dart';
import 'package:riot_tracker/app/core/constants/size_constant.dart';
import 'package:riot_tracker/app/ui/widgets/text_widget.dart';
import '../../widgets/text_form_field_widget.dart';
import 'init_controller.dart';

class InitView extends GetView<InitViewController> {
  InitView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset(initLottie),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FittedBox(
                        child: TextWidget(text: "Riot Tracker",color: AppColors.red, size: AppTextSize.heading_large,),
                      ),
                      height20,
                      TextFormFieldWidget(
                        controller: controller.gameNameController,
                        hintText: "Tên Ingame",
                        validMessage: "Vui lòng nhập ingame",
                      ),
                      height10,
                      TextFormFieldWidget(
                        controller: controller.tagLineController,
                        hintText: "Tag ID",
                        validMessage: "Vui lòng nhập tag id",
                      ),
                      height10,
                      Obx(() => Text(controller.error.value)),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            controller.login();
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}