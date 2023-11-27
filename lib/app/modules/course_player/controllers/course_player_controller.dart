import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/course_data.dart';
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



  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }
}
