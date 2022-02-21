import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vd_admin/controller/auth_controller.dart';
import 'package:vd_admin/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.person,
                              size: Get.size.width * 0.2, color: Colors.pink),
                          Text(
                            auth.getLoggedInUser()?.email ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                        title: Container(
                      height: 45,
                      child: Obx(() {
                        if (auth.isPasswordResetLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                            onPressed: () {
                              auth.sendPasswordReset(context);
                            },
                            child: Text('Нууц үг солих'));
                      }),
                    )),
                    ListTile(title: Container(
                      child: Obx(() {
                        if (auth.isLogoutLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return TextButton(
                            onPressed: () {
                              auth.logout();
                            },
                            child: Text('Гарах'));
                      }),
                    )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
