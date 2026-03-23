import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/core/constants/size_constant.dart';
import 'package:riot_tracker/app/ui/views/widget_tree/card_widget.dart';
import 'package:riot_tracker/app/ui/widgets/text_widget.dart';

import '../../../core/constants/color_constants.dart';
import '../widget_tree/widget_tree_view_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final profileIcon = dotenv.env['PROFILE_ICON'];
  final rankIcon = dotenv.env['RANK_ICON'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WidgetTreeViewController>();

    return Scaffold(
      body: Obx(() {
        return controller.isLoading.value
            ? Scaffold(body: Center(child: CircularProgressIndicator()))
            : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    spacing: 12,
                    children: [
                      CardWidget(
                        child: Column(
                          children: [
                            _buildUserInforWidget(controller),
                            _buildRankWidget(controller),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
      }),
    );
  }

  Widget _buildRankWidget(WidgetTreeViewController controller) {
    final ranks = controller.account.value?.ranks ?? [];
    return CarouselSlider.builder(
      itemCount: ranks.length,
      itemBuilder: (context, index, realIndex) {
        final rank = ranks[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: CardWidget(
            color: AppColors.yellow.withValues(alpha: 0.2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  "$rankIcon/${rank.tier?.toLowerCase()}.png",
                ),
                Text(rank.queueDisplayName ?? ""),
                Text("${rank.leaguePoints} LP"),
                Text("${rank.tier} ${rank.rank}"),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        viewportFraction: 0.8,
        height: 350
      ),
    );

  }

  Widget _buildUserInforWidget(WidgetTreeViewController controller) {
    return Row(
      spacing: 10,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            "$profileIcon/${controller.account.value?.profileIconId}.png",
          ),
          radius: 32,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: "${controller.account.value?.gameName}",
              size: AppTextSize.body_large,
            ),
            Text(
              "#${controller.account.value?.tagLine}",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Level ${controller.account.value?.summonerLevel}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
