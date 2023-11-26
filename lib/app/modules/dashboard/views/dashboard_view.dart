import 'package:edu_care/app/data/course_data.dart';
import 'package:edu_care/app/routes/app_pages.dart';
import 'package:edu_care/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/continue_course_button.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () async {
                  await authController.signOut();
                },
                child: const Text('Logout'),
              ),
            ];
          })
        ],
      ),
      drawer: const Drawer(),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) => Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(left: 24, right: 24, top: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(courses[index].cover),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          courses[index].level,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          courses[index].title,
                          style: const TextStyle(
                            color: primaryTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/video.png',
                              height: 15,
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              courses[index].totalLessons,
                              style: const TextStyle(
                                color: secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/time.png',
                              height: 15,
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              courses[index].length,
                              style: const TextStyle(
                                color: secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ContinueCourseButton(
                      onTap: () {
                        Get.toNamed(
                          Routes.COURSE_PLAYER,
                          arguments: courses[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
