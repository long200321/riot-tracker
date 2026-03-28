import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/core/routes/app_routes.dart';
import 'package:riot_tracker/app/domain/champion/entities/champion.dart';
import 'package:riot_tracker/app/presentations/widgets/loading_widget.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/size_constant.dart';
import '../../widgets/text_widget.dart';
import 'champion_controller.dart';

class ChampionView extends GetView<ChampionController> {
  ChampionView({super.key});

  final champImage = dotenv.env["CHAMPION_IMG_URL"];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? LoadingWidget()
          : Scaffold(
            body: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.champions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final champ = controller.champions[index];
                return _buildChampionWidget(champ);
              },
            ),
          );
    });
  }

  Widget _buildChampionWidget(Champion champ) {
    return GestureDetector(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl:
                champ.id == "Fiddlesticks"
                    ? "$champImage/centered/FiddleSticks_0.jpg"
                    : "$champImage/centered/${champ.id}_0.jpg",
            fit: BoxFit.cover,
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          ),

          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: champ.name,
                  color: AppColors.white,
                  size: AppTextSize.body_medium,
                ),
                Text(
                  champ.title,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppTextSize.body_small.value,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        Get.toNamed(AppRoutes.championDetail, arguments: champ);
      },
    );
  }
}
