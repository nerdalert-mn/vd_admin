import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final VideoPlayerController _controller;

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
    return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container());
  }
}
