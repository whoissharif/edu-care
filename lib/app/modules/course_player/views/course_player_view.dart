import 'package:edu_care/app/data/models/course.dart';
import 'package:edu_care/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/course_player_controller.dart';
import 'widgets/video_player_widget.dart';

class CoursePlayerView extends GetView<CoursePlayerController> {
  CoursePlayerView({Key? key}) : super(key: key);
  final Course course = Get.arguments;

  final CoursePlayerController playerController =
      Get.find<CoursePlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${course.title}'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: VideoPlayerWidget(
              controller: playerController.videoPlayerController,
            ),
          ),

          // Module list
          Expanded(
            child: ListView.builder(
              itemCount: playerController.course.modules.length,
              itemBuilder: (context, index) {
                final module = playerController.course.modules[index];
                return Obx(
                  () => ListTile(
                    title: Text(module.title),
                    subtitle: Text(module.description),
                    tileColor:
                        playerController.currentModuleIndex.value == index
                            ? primaryColor.withOpacity(.2)
                            : Colors.white,
                    onTap: () {
                      // Navigate to the selected module
                      playerController.currentModuleIndex.value = index;
                      playerController.updateVideoPlayer();
                    },
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.bookmark),
                onPressed: () {
                  // Bookmark the current time in the video
                },
              ),
            ],
          ),

          // Next and Previous buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  playerController.previousModule();
                },
                child: Text('Previous Module'),
              ),
              ElevatedButton(
                onPressed: () {
                  playerController.nextModule();
                },
                child: Text('Next Module'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
