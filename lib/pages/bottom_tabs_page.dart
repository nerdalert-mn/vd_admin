import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vd_admin/pages/history_page.dart';
import 'package:vd_admin/pages/home_page.dart';
import 'package:vd_admin/pages/profile_page.dart';

class BottomTabsPage extends StatelessWidget {
  const BottomTabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: const [
        HomePage(),
        HistoryPage(),
        ProfilePage(),
        // const CameraPage()
      ],
      items: [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            activeColorPrimary: Get.theme.primaryColor),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.history),
            activeColorPrimary: Get.theme.primaryColor),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            activeColorPrimary: Get.theme.primaryColor),
        // PersistentBottomNavBarItem(
        //     icon: const Icon(Icons.camera),
        //     activeColorPrimary: Get.theme.primaryColor),
      ],
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
