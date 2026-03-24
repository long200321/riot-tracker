import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:riot_tracker/app/core/constants/size_constant.dart';
import 'package:riot_tracker/app/ui/views/profile/profile_view_controller.dart';
import 'package:riot_tracker/app/ui/views/widget_tree/card_widget.dart';
import 'package:riot_tracker/app/ui/widgets/text_widget.dart';

import '../../../core/constants/color_constants.dart';
import '../widget_tree/widget_tree_view_controller.dart';

class ProfileView extends GetView<ProfileViewController> {
  ProfileView({super.key});

  final profileIcon = dotenv.env['PROFILE_ICON'];
  final rankIcon = dotenv.env['RANK_ICON'];

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<WidgetTreeViewController>();

    return Scaffold(
      body: Obx(() {
        return accountController.isLoading.value
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
                            _buildUserInforWidget(accountController),
                            _buildRankWidget(accountController),
                          ],
                        ),
                      ),
                      CardWidget(child: _buildWinrateWidget(accountController)),
                    ],
                  ),
                ),
              ),
            );
      }),
    );
  }

  Widget _buildWinrateWidget(WidgetTreeViewController accountController) {
    Color getWinRateColor(double rate) {
      final percent = rate * 100;

      return switch (percent) {
        < 30 => AppColors.blue.withValues(alpha: 0.6),
        >= 30 && < 50 => AppColors.blue,
        >= 50 && < 75 => AppColors.red.withValues(alpha: 0.7),
        _ => AppColors.red,
      };
    }

    return Row(
      spacing: 10,
      children: [
        CircularPercentIndicator(
          radius: 60,
          lineWidth: 7,
          percent: accountController.winrate.value,
          center: FittedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${(accountController.winrate.value * 100).toStringAsFixed(0)}%",
                  style: TextStyle(fontSize: 24),
                ),
                TextWidget(text: "WIN RATE", size: AppTextSize.body_medium),
              ],
            ),
          ),
          progressColor: getWinRateColor(accountController.winrate.value),
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        Column(
          spacing: 5,
          children: [
            FittedBox(child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 2)
              ),
            ),),
          ],
        ),
      ],
    );
  }

  Widget _buildRankWidget(WidgetTreeViewController accountController) {
    final ranks = accountController.account.value?.ranks ?? [];
    final RxInt currentIndex = 0.obs;

    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            itemCount: ranks.length,
            itemBuilder: (context, index, realIndex) {
              final rank = ranks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CardWidget(
                  color: AppColors.blue.withValues(alpha: 0.1),
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
              height: 330,
              onPageChanged: (index, reason) {
                currentIndex.value = index;
              },
            ),
          ),
          height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(ranks.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      currentIndex.value == index
                          ? AppColors.blue
                          : Colors.grey.shade400,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInforWidget(WidgetTreeViewController accountController) {
    return Row(
      spacing: 10,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            "$profileIcon/${accountController.account.value?.profileIconId}.png",
          ),
          radius: 32,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: "${accountController.account.value?.gameName}",
              size: AppTextSize.body_large,
            ),
            Text(
              "#${accountController.account.value?.tagLine}",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Level ${accountController.account.value?.summonerLevel}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
