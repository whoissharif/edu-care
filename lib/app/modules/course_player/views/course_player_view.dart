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

  // Format duration to a readable format
  String formatDuration(int seconds) {
    final Duration duration = Duration(seconds: seconds);
    return [
      if (duration.inHours > 0) '${duration.inHours}h',
      if (duration.inMinutes.remainder(60) > 0)
        '${duration.inMinutes.remainder(60)}m',
      '${duration.inSeconds.remainder(60)}s',
    ].join(' ');
  }

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
                    title: Text(
                      module.title,
                      style: const TextStyle(
                        color: primaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      module.description,
                      style: const TextStyle(
                        color: secondaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                    tileColor:
                        playerController.currentModuleIndex.value == index
                            ? Colors.grey.withOpacity(.2)
                            : Colors.white,
                    onTap: () {
                      // Navigate to the selected module
                      playerController.currentModuleIndex.value = index;
                      playerController.updateVideoPlayer();
                    },
                    // Bookmarks icon [shows each module's bookmarks]
                    trailing: playerController.currentModuleIndex.value == index
                        ? GestureDetector(
                            onTap: () {
                              var a = playerController
                                  .getModuleBookmarks(module.id);
                              //  print(a.map((e) => e.positionInSeconds));
                              a.isNotEmpty
                                  ? Get.defaultDialog(
                                      title: 'Bookmarks for \n${module.title}',
                                      content: SizedBox(
                                        height: 300,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (var bookmark in a)
                                                ListTile(
                                                  title: Text(
                                                    'Bookmark - ${formatDuration(bookmark.positionInSeconds)}',
                                                  ),
                                                  onTap: () {
                                                    playerController
                                                        .seekToSpecicTime(bookmark
                                                            .positionInSeconds);
                                                    Get.back();
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Get.snackbar(
                                      'No Bookmarks',
                                      'There are no bookmarks for this module.',
                                      backgroundColor: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: const Icon(
                                Icons.bookmarks,
                                color: Colors.white,
                              ),
                            ),
                          )
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
