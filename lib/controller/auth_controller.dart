import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vd_admin/controller/alert_controller.dart';
import 'package:vd_admin/pages/bottom_tabs_page.dart';
import 'package:vd_admin/pages/home_page.dart';
import 'package:vd_admin/pages/login_page.dart';

class AuthController extends GetxController {
  final username = ''.obs;
  final password = ''.obs;
  final isLoginLoading = false.obs;
  final isLogoutLoading = false.obs;
  StreamSubscription? _authSubscription;
  User? _user;
  @override
  onInit() {
    super.onInit();
    _authSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Get.offAll(() => LoginPage());
        isLoginLoading.value = false;
      } else {
        _user = user;
        Get.offAll(() => const BottomTabsPage());
        final fcmToken = await FirebaseMessaging.instance.getToken();
        FirebaseFirestore.instance.collection('users').doc(user.uid).set(
            {'email': user.email, 'type': 'normal', 'fcmToken': fcmToken},
            SetOptions(merge: true));
      }
    });
  }

  User? getLoggedInUser() {
    return _user;
  }

  @override
  onClose() {
    _authSubscription?.cancel();
    super.onClose();
  }

  Future<void> login(BuildContext context) async {
    isLoginLoading.value = true;
    try {
      print(username.value);
      print(password.value);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: username.value, password: password.value);
      Get.offAll(() => const BottomTabsPage());
    } on FirebaseAuthException catch (e) {
      final alertCtr = Get.find<AlertController>();
      if (e.code == 'user-not-found') {
        alertCtr.showError(context, 'User not found');
      } else {
        alertCtr.showError(context, 'User or password is wrong');
      }
      isLoginLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLogoutLoading.value = true;
    await FirebaseAuth.instance.signOut();
    isLogoutLoading.value = true;
  }

  final isPasswordResetLoading = false.obs;
  Future<void> sendPasswordReset(BuildContext context) async {
    isPasswordResetLoading.value = true;
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _user!.email!);
    Get.find<AlertController>().showSuccess(
        context, 'Нууц үг сэргээх линк илгээгдлээ email хаягаа шалгана уу?');
    isPasswordResetLoading.value = false;
  }
}
