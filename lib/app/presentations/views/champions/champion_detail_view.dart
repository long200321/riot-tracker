import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:riot_tracker/app/core/constants/color_constants.dart';
import 'package:riot_tracker/app/core/constants/size_constant.dart';
import 'package:riot_tracker/app/domain/champion/entities/champion.dart';
import 'package:riot_tracker/app/presentations/widgets/divider_widget.dart';
import 'package:riot_tracker/app/presentations/widgets/image_network_widget.dart';
import 'package:riot_tracker/app/presentations/widgets/loading_widget.dart';
import 'package:riot_tracker/app/presentations/widgets/text_widget.dart';

import 'champion_detail_view_controller.dart';

class ChampionDetailView extends GetView<ChampionDetailViewController> {
  ChampionDetailView({super.key});
  final champImage = dotenv.env['CHAMPION_IMG_URL'];
  final skillImage = dotenv.env['SPELL_ICON'];
  final passiveIcon = dotenv.env['PASSIVE_ICON'];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final champ = controller.champ;
      final skins = champ.skins ?? [];
      final selectedIndex = controller.selectedSkinIndex.value;

      if (skins.isEmpty || selectedIndex >= skins.length) {
        return const LoadingWidget();
      }

      final selectedSkin = skins[selectedIndex];

      return controller.isLoading.value
          ? const LoadingWidget()
          : Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios_new),
                color: AppColors.red,
              ),
              title: TextWidget(
                text: champ.name,
                color: AppColors.red,
                size: AppTextSize.heading_small,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSplashWidget(champ, selectedSkin),
                  _buildSliderWidget(selectedSkin, skins, champ),
                  _buildLoreWidget(context, champ),
                  _buildSkillWidget(context, champ),
                ],
              ),
            ),
          );
    });
  }

  Widget _buildSkillWidget(BuildContext context, Champion champ) {
    return Column(
      children: [
        DividerWidget(width: MediaQuery.of(context).size.width / 1.5),
        TextWidget(
          text: "Skills",
          color: AppColors.red,
          size: AppTextSize.heading_small,
        ),

        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              _buildSkillDetailWidget(
                imageUrl: "$passiveIcon/${champ.passive?.image}",
                skillName: champ.passive?.name ?? "",
                skillDescription: champ.passive?.description ?? "",
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: champ.spells?.length,
                itemBuilder: (context, index) {
                  final skill = champ.spells?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildSkillDetailWidget(
                      imageUrl: "$skillImage/${skill?.id}.png",
                      skillName: skill?.name ?? "",
                      skillDescription: skill?.description ?? ""
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillDetailWidget({
    required String imageUrl,
    required String skillName,
    required String skillDescription,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            ImageNetworkWidget(imageUrl: imageUrl, size: 40),
            FittedBox(child: Text(skillName,style: TextStyle(
              fontSize: AppTextSize.body_medium.value,
              fontWeight: FontWeight.bold
            ),)),
          ],
        ),
        Text(skillDescription),
      ],
    );
  }

  Widget _buildLoreWidget(BuildContext context, Champion champ) {
    return Column(
      children: [
        DividerWidget(width: MediaQuery.of(context).size.width / 1.5),
        TextWidget(
          text: "Lore",
          color: AppColors.red,
          size: AppTextSize.heading_small,
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
          child: Text(champ.lore ?? ""),
        ),
      ],
    );
  }

  Widget _buildSliderWidget(
    Skin selectedSkin,
    List<Skin> skins,
    Champion champ,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            selectedSkin.name == "default" ? champ.name : selectedSkin.name,
            style: TextStyle(
              color: AppColors.black,
              fontSize: AppTextSize.body_medium.value,
              fontWeight: FontWeight.bold,
            ),
          ),

          CarouselSlider.builder(
            itemCount: skins.length,
            itemBuilder: (context, index, realIndex) {
              final skin = skins[index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: "$champImage/splash/${champ.id}_${skin.num}.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
            options: CarouselOptions(
              height: 120,
              enlargeCenterPage: true,
              viewportFraction: 0.5,
              onPageChanged: (index, reason) {
                controller.selectedSkinIndex.value = index;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplashWidget(Champion champ, Skin selectedSkin) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: "$champImage/splash/${champ.id}_${selectedSkin.num}.jpg",
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
