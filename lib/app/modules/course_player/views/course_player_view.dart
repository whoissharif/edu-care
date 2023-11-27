import 'package:edu_care/app/data/models/course.dart';
import 'package:edu_care/app/modules/course_player/views/widgets/player_button.dart';
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
            flex: 2,
            child: VideoPlayerWidget(
              controller: playerController.videoPlayerController,
            ),
          ),

          // Module list
          Expanded(
            flex: 4,
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
                    trailing: playerController.currentModuleIndex.value == index
                        ? IconButton(
                            onPressed: () {
                              var a =
                                  playerController.getModuleBookmarks(module.id);
                              print(a.map((e) => e.positionInSeconds));
                            },
                            icon: const Icon(Icons.bookmarks))
                        : const SizedBox(),
                  ),
                );
              },
            ),
          ),

          // Next and Previous buttons
          Container(
            decoration: const BoxDecoration(
              color: primaryTextColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: PlayerButton(
                    onTap: () {
                      playerController.previousModule();
                    },
                    title: 'Previous',
                  ),
                ),
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    color: Colors.white,
                    width: 20,
                    thickness: 1,
                  ),
                ),
                Expanded(
                  child: PlayerButton(
                    onTap: () {
                      playerController.nextModule();
                    },
                    title: 'Next',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          playerController.bookmarkCurrentTime();
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.bookmark_add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
