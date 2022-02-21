import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vd_admin/controller/new_detection_controller.dart';
import 'package:vd_admin/controller/notification_controller.dart';
import 'package:vd_admin/pages/history_single_page.dart';
import 'package:vd_admin/pages/video_page.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVideoVisible = false;
  final dateFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
  late final VideoPlayerController _controller;

  void toggleVideo() {
    setState(() {
      _isVideoVisible = !_isVideoVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _newDetectionStream = FirebaseFirestore.instance
        .collection('new_detections')
        .limit(1)
        .snapshots();
    final notif = Get.find<NotificationController>();
    final newDetectionCtr = Get.find<NewDetectionController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мэдэгдэл'),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications)),
              // Obx(() {
              //   int count = notif.messages.length + newDetectionCtr.count.value;
              //   if (count == 0) {
              //     return const SizedBox();
              //   }
              //   return Text(count.toString());
              // })
            ],
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
          stream: _newDetectionStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            newDetectionCtr.count.value = snapshot.data?.docs.length ?? 0;
            if (snapshot.data!.docs.isNotEmpty) {
              final doc = snapshot.data!.docs.first;
              final data =
                  snapshot.data!.docs.first.data() as Map<String, dynamic>;
              final formattedTimestamp =
                  dateFormat.format(data['timestamp'].toDate().toLocal());
              final fileName = data['fileName'];
              final imageUrl =
                  'https://firebasestorage.googleapis.com/v0/b/rtvd-test.appspot.com/o/detection_images%2F$fileName?alt=media';
              return Center(
                child: GestureDetector(
                  onTap: () async {
                    await Get.to(() => HistorySinglePage(
                        description: formattedTimestamp,
                        imageUrl: imageUrl,
                        id: doc.id));
                    Future.delayed(const Duration(milliseconds: 100), () {
                      FirebaseFirestore.instance
                          .collection("new_detections")
                          .doc(doc.id)
                          .delete();
                    });
                  },
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
                          formattedTimestamp,
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 49, 190, 175)),
                        padding: const EdgeInsets.all(25),
                        child: Icon(Icons.done,
                            color: Colors.white, size: Get.size.width * 0.2),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Асуудалгүй',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: Get.size.width * 0.65,
                        child: const Text(
                          'Сэжигтэй зүйл илэрсэн тохиолдолд таньд мэдэгдэх болно',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
