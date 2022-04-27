import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vd_admin/controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final usernameCtr = TextEditingController();
  final pwdCtr = TextEditingController();
  final passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final loginCtr = Get.find<AuthController>();
    final login = () {
      if (_formKey.currentState?.validate() ?? false) {
        loginCtr.login(context);
      }
    };
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Image.asset(
                  'assets/logo.png',
                  width: Get.size.width * 0.33,
                  height: Get.size.width * 0.33,
                ),
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          child: TextFormField(
                            autofocus: true,
                            controller: usernameCtr,
                            onChanged: (s) {
                              loginCtr.username.value = s;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Нэвтрэх нэрээ оруулна уу';
                              }
                              return null;
                            },
                            onFieldSubmitted: (s) {
                              FocusScope.of(context)
                                  .requestFocus(passwordFocus);
                            },
                            textInputAction: TextInputAction.next,
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
                            focusNode: passwordFocus,
                            controller: pwdCtr,
                            onChanged: (p) {
                              loginCtr.password.value = p;
                            },
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Нууц үгээ оруулна уу';
                              }
                              return null;
                            },
                            onFieldSubmitted: (s) {
                              login();
                            },
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
                      Obx(() {
                        if (loginCtr.isLoginLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                                onPressed: login,
                                child: const Text('Нэвтрэх')));
                      }),
                    ],
                  ),
                ),
              ),
              Obx(() {
                if (loginCtr.isLoginLoading.value) {
                  return const SizedBox();
                }
                return TextButton(
                    onPressed: () {
                      Get.find<AuthController>().sendPasswordReset(context);
                    },
                    child: const Text('Нууц үг сэргээх'));
              })
            ],
          ),
        ),
      ),
    );
  }
}
