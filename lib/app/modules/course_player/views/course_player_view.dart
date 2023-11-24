import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/course_player_controller.dart';

class CoursePlayerView extends GetView<CoursePlayerController> {
  const CoursePlayerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoursePlayerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CoursePlayerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
