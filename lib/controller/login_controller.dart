import 'package:get/get.dart';
import 'package:vd_admin/pages/bottom_tabs_page.dart';
import 'package:vd_admin/pages/home_page.dart';

class LoginController extends GetxController {
  final username = ''.obs;
  final password = ''.obs;
  Future<void> login() async {
    Get.offAll(() => const BottomTabsPage());
  }
}
