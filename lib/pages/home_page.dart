import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vd_admin/pages/video_page.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVideoVisible = false;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мэдэгдэл'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                Get.to(() => VideoPage());
              },
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
          ),
        ),
      ),
    );
  }
}
