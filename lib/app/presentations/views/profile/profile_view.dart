import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:riot_tracker/app/core/constants/assets_constant.dart';
import 'package:riot_tracker/app/core/constants/size_constant.dart';
import 'package:riot_tracker/app/domain/account/entities/match_history.dart';
import 'package:riot_tracker/app/presentations/views/profile/profile_view_controller.dart';
import '../../../core/constants/color_constants.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/image_network_widget.dart';
import '../../widgets/text_widget.dart';
import '../widget_tree/widget_tree_view_controller.dart';

class ProfileView extends GetView<ProfileViewController> {
  const ProfileView({super.key});

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
                      CardWidget(child: _buildMasteryWidget(accountController)),
                    ],
                  ),
                ),
              ),
            );
      }),
    );
  }

  Widget _buildMasteryWidget(WidgetTreeViewController accountController) {
    final championImage = dotenv.env["CHAMPION_IMG_URL"];
    final masteryList = accountController.account.value?.championMastery ?? [];

    return masteryList.isEmpty
        ? _buildNoDataWidget("No mastery champion")
        : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: "Mastery", size: AppTextSize.body_large),
                TextButton(onPressed: () {}, child: Text("View all")),
              ],
            ),
            CarouselSlider.builder(
              itemCount: masteryList.length,
              itemBuilder: (context, index, realIndex) {
                final mastery = masteryList[index];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        height: 300,
                        width: 200,
                        imageUrl: mastery.championName == "Fiddlesticks" ? '$championImage/centered/FiddleSticks_0.jpg' : '$championImage/centered/${mastery.championName}_0.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextWidget(text: mastery.championName,
                          size: AppTextSize.body_medium,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Divider(),
                          ),
                          Text("Mastery",style: TextStyle(
                            color: AppColors.white,
                            fontSize: AppTextSize.body_small.value
                          ),),
                          Text("${mastery.championLevel}",style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: AppTextSize.body_large.value,
                            fontStyle: FontStyle.italic
                          ),),
                        ],
                      ),
                    )
                  ],
                );
              },
              options: CarouselOptions(
                height: 300,
                viewportFraction: 0.6,
                enlargeCenterPage: true,
              ),
            ),
          ],
        );
  }

  Widget _buildWinrateWidget(WidgetTreeViewController accountController) {
    Color getWinRateColor(double rate) {
      return switch (rate) {
        < 30 => AppColors.blue.withValues(alpha: 0.6),
        >= 30 && < 50 => AppColors.blue,
        >= 50 && < 75 => AppColors.red.withValues(alpha: 0.7),
        _ => AppColors.red,
      };
    }

    return controller.listMatch.isEmpty && controller.hasMore.value
        ? LottieBuilder.asset(loadingLottie)
        : Row(
          spacing: 10,
          children: [
            Column(
              spacing: 16,
              children: [
                CircularPercentIndicator(
                  radius: 60,
                  lineWidth: 7,
                  percent: controller.winRate.value / 100,
                  center: FittedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${(controller.winRate.value).toStringAsFixed(0)}%",
                          style: TextStyle(fontSize: 24),
                        ),
                        TextWidget(
                          text: "WIN RATE",
                          size: AppTextSize.body_medium,
                        ),
                      ],
                    ),
                  ),
                  progressColor: getWinRateColor(controller.winRate.value),
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                ElevatedButtonWidget(text: "View Detail", onPressesd: () {

                })
              ],
            ),
            _buildListMatchWidget(accountController),
          ],
        );
  }

  Widget _buildListMatchWidget(WidgetTreeViewController accountController) {
    final championIcon = dotenv.env['CHAMPION_ICON'];
    final itemIcon = dotenv.env['ITEM_ICON'];

    return Expanded(
      child: SizedBox(
        height: 300,
        child: Obx(() {
          return ListView.builder(
            itemCount:
                controller.listMatch.length +
                (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.listMatch.length) {
                return Center(child: CircularProgressIndicator());
              }

              final match = controller.listMatch[index];
              final participant = match.participants.firstWhere(
                (p) => p.puuid == accountController.account.value?.puuid,
                orElse: () => match.participants.first,
              );

              return Container(
                height: 90,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1)),
                ),
                child: _buildMatchWidget(championIcon, participant, itemIcon),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildMatchWidget(
    String? championIcon,
    Participant participant,
    String? itemIcon,
  ) {
    return Row(
      spacing: 5,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            spacing: 2,
            children: [
              ImageNetworkWidget(
                imageUrl: participant.championName == "Fiddlesticks" ? "$championIcon/FiddleSticks.png" : "$championIcon/${participant.championName}.png",
                size: 40,
              ),
              _buildSpellWidget(participant),
            ],
          ),
        ),

        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${participant.kills}/${participant.deaths}/${participant.assists}",
                style: TextStyle(fontSize: AppTextSize.body_medium.value),
              ),

              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: participant.items.length,
                  itemBuilder: (context, index) {
                    final image = participant.items[index];

                    if (image == 0) {
                      return const SizedBox(width: 30);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: ImageNetworkWidget(
                        imageUrl: "$itemIcon/$image.png",
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpellWidget(Participant participant) {
    final spellIcon = dotenv.env['SPELL_ICON'];
    return Row(
      spacing: 2,
      children: [
        ImageNetworkWidget(
          imageUrl: "$spellIcon/${participant.summonerSpell1Name}.png",
          size: 20,
        ),

        ImageNetworkWidget(
          imageUrl: "$spellIcon/${participant.summonerSpell2Name}.png",
          size: 20,
        ),
      ],
    );
  }

  Widget _buildRankWidget(WidgetTreeViewController accountController) {
    final rankIcon = dotenv.env['RANK_ICON'];

    return Obx(() {
      return accountController.account.value?.ranks?.isEmpty == true
          ? _buildNoDataWidget("No rank data")
          : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider.builder(
                itemCount: accountController.account.value?.ranks?.length,
                itemBuilder: (context, index, realIndex) {
                  final rank = accountController.account.value?.ranks?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CardWidget(
                      color: AppColors.blue.withValues(alpha: 0.1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            "$rankIcon/${rank?.tier?.toLowerCase()}.png",
                          ),
                          Text(rank?.queueDisplayName ?? ""),
                          Text("${rank?.leaguePoints} LP"),
                          Text("${rank?.tier} ${rank?.rank}"),
                        ],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  height: 330,
                  onPageChanged: (index, reason) {
                    accountController.currentIndexSlider.value = index;
                  },
                ),
              ),
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  accountController.account.value?.ranks?.length ?? 0,
                  (index) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            accountController.currentIndexSlider.value == index
                                ? AppColors.blue
                                : Colors.grey.shade400,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
    });
  }

  Widget _buildUserInforWidget(WidgetTreeViewController accountController) {
    final profileIcon = dotenv.env['PROFILE_ICON'];
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

  Widget _buildNoDataWidget(String title) {
    return CardWidget(
      color: AppColors.blue.withValues(alpha: 0.1),
      child: Center(child: Text(title)),
    );
  }
}
