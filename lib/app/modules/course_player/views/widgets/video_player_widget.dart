import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;


  VideoPlayerWidget({required this.controller});


  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}


class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late ChewieController _chewieController;


  @override
  void initState() {
    super.initState();


    // _videoPlayerController =
    //     VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _chewieController = ChewieController(
      videoPlayerController: widget.controller,
      aspectRatio: 16 / 9, // Adjust based on your video aspect ratio
      autoPlay: true,
      looping: false,
      // Other ChewieController configurations as needed
    );
  }


  @override
  void dispose() {
    widget.controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatelessWidget {
//   final VideoPlayerController controller;

//   VideoPlayerWidget({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9, // Adjust the aspect ratio based on your video dimensions
//       child: VideoPlayer(controller),
//     );
//   }
// }

