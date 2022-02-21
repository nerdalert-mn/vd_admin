import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/instance_manager.dart';
import 'package:vd_admin/controller/auth_controller.dart';

class HistorySinglePage extends StatelessWidget {
  final String description;
  final String imageUrl;
  final String id;
  const HistorySinglePage(
      {Key? key,
      required this.description,
      required this.imageUrl,
      required this.id})
      : super(key: key);

  Future<void> markRead() async {
    // final user = Get.find<AuthController>().getLoggedInUser();
    // final ref = FirebaseFirestore.instance
    //     .collection('user_history')
    //     .doc(user!.uid)
    //     .collection('history_check')
    //     .doc(id);
    // final doc = await ref.get();
    // if (doc.exists) {
    //   return;
    // } else {
    //   ref.set({'seenAt': DateTime.now()}, SetOptions(merge: true));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detection'),
      ),
      body: FutureBuilder<void>(
          future: markRead(),
          builder: (context, d) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
