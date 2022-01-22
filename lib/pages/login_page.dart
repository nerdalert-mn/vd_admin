import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vd_admin/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final usernameCtr = TextEditingController();

  final pwdCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginCtr = Get.find<LoginController>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: FlutterLogo(
                  size: Get.size.width * 0.33,
                ),
              ),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        child: TextFormField(
                          controller: usernameCtr,
                          onChanged: (s) {
                            loginCtr.username.value = s;
                          },
                          decoration: InputDecoration(
                              hintText: 'Нэвтрэх нэр',
                              suffixIcon: Obx(() {
                                if (loginCtr.username.isNotEmpty) {
                                  return IconButton(
                                      onPressed: () {
                                        loginCtr.username.value = '';
                                        usernameCtr.clear();
                                      },
                                      icon: const Icon(Icons.clear));
                                }
                                return const Icon(Icons.email);
                              })),
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        child: TextFormField(
                          controller: pwdCtr,
                          onChanged: (p) {
                            loginCtr.password.value = p;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Нууц үг',
                              suffixIcon: Obx(() {
                                if (loginCtr.password.isNotEmpty) {
                                  return IconButton(
                                      onPressed: () {
                                        loginCtr.password.value = '';
                                        pwdCtr.clear();
                                      },
                                      icon: const Icon(Icons.clear));
                                }
                                return const Icon(Icons.lock);
                              })),
                        )),
                    Container(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                            onPressed: () {
                              loginCtr.login();
                            },
                            child: const Text('Нэвтрэх')))
                  ],
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Нууц үг сэргээх'))
            ],
          ),
        ),
      ),
    );
  }
}
