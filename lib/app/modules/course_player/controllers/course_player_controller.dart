import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/course_data.dart';
import '../../../data/models/bookmark.dart';
import '../../../data/models/course.dart';

class CoursePlayerController extends GetxController {
  final box = GetStorage();
  late Course course;
  late VideoPlayerController videoPlayerController =
      VideoPlayerController.networkUrl(Uri.parse(''));
  RxInt currentModuleIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initializing course
    course = courses.first;

    // Initialize the video player
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    if (!videoPlayerController.value.isInitialized) {
      videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(course.modules.first.videoUrl))
        ..initialize().then((_) {
          videoPlayerController.play();
          update();
        });
    } else {
      videoPlayerController.seekTo(Duration.zero);
      videoPlayerController.play();
      update();
    }
  }

  void seekToSpecicTime(int seconds) {
    videoPlayerController.seekTo(
      Duration(seconds: seconds),
    );
  }

  void nextModule() {
    if (currentModuleIndex.value < course.modules.length - 1) {
      currentModuleIndex.value++;

      updateVideoPlayer();
    }
  }

  void previousModule() {
    if (currentModuleIndex.value > 0) {
      currentModuleIndex.value--;

      updateVideoPlayer();
    }
  }

  void updateVideoPlayer() {
    videoPlayerController.pause();
    videoPlayerController.seekTo(Duration.zero);
    // videoPlayerController.seekTo(Duration(seconds: getBookmarkedTime()));
    videoPlayerController.play();
    update();
  }

  void bookmarkCurrentTime() {
    final currentTime = videoPlayerController.value.position.inSeconds;
    final bookmark = Bookmark(
      courseId: course.id,
      moduleId: course.modules[currentModuleIndex.value].id,
      positionInSeconds: currentTime,
    );

    // Convert the Bookmark instance to a JSON-encodable format
    final bookmarkMap = jsonEncode(bookmark.toJson());

    // Save bookmark to Get Storage
    final key =
        'bookmark_${course.id}_${course.modules[currentModuleIndex.value].id}';
    final existingBookmarks = box.read<List<dynamic>>(key) ?? [];
    existingBookmarks.add(bookmarkMap);
    box.write(key, existingBookmarks);

    update();
    if (Get.isSnackbarOpen != true) {
      Get.snackbar(
        'Bookmark Added',
        'Bookmark added successfully.',
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  List<Bookmark> getModuleBookmarks(String moduleId) {
    final key = 'bookmark_${course.id}_$moduleId';
    final existingBookmarks = box.read<List<dynamic>>(key) ?? [];
    
    final bookmarks = existingBookmarks
        .map((bookmarkMap) =>
            Bookmark.fromJson(jsonDecode(bookmarkMap as String)))
        .toList();

    return bookmarks;
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }
}
