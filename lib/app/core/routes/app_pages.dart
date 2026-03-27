import 'package:get/get.dart';
import 'package:riot_tracker/app/bindings/account_binding.dart';
import 'package:riot_tracker/app/bindings/champion_detail_binding.dart';
import 'package:riot_tracker/app/presentations/views/champions/champion_detail_view.dart';
import 'package:riot_tracker/app/presentations/views/init/init_view.dart';
import 'package:riot_tracker/app/presentations/views/setting/setting_view.dart';
import 'package:riot_tracker/app/presentations/views/splash/splash_view.dart';
import 'package:riot_tracker/app/presentations/views/widget_tree/widget_tree_view.dart';

import '../../bindings/widget_tree_binding.dart';
import '../../presentations/views/collection/collection_view.dart';
import '../../presentations/views/profile/profile_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: AppRoutes.init,
      page: () => InitView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: AppRoutes.widgetTree,
      page: () => WidgetTreeView(),
      binding: WidgetTreeViewBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileView(),
      binding: WidgetTreeViewBinding(),
    ),
    GetPage(
      name: AppRoutes.collection,
      page: () => CollectionView(),
      binding: WidgetTreeViewBinding(),
    ),
    GetPage(
      name: AppRoutes.setting,
      page: () => SettingView(),
    ),
    GetPage(
      name: AppRoutes.championDetail,
      page: () => ChampionDetailView(),
      binding: ChampionDetailBinding()
    ),
  ];
}
