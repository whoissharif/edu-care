import 'models/course.dart';

List<Course> courses = [
  Course(
    id: '1',
    title: 'Introduction to Flutter',
    description: 'Learn the basics of Flutter framework.',
    cover:
        'https://interactivecares-courses.com/wp-content/uploads/2023/10/website.png',
    level: 'Intermediate',
    totalLessons: '45 Lessons',
    length: '26 Hours',
    modules: [
      Module(
        title: 'Getting Started',
        description: 'Overview of Flutter and Dart.',
        lessons: [
          Lesson(
            title: 'Setting Up Flutter',
            description: 'Installing and configuring Flutter on your machine.',
            videoUrl:
                'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',
          ),
          Lesson(
            title: 'Introduction to Dart',
            description:
                'Understanding the basics of the Dart programming language.',
            videoUrl:
                'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',
          ),
          // Add more lessons as needed
        ],
      ),
      Module(
        title: 'Building UIs',
        description: 'Creating user interfaces with Flutter.',
        lessons: [
          Lesson(
            title: 'Layouts and Widgets',
            description: 'Exploring different layouts and widgets in Flutter.',
            videoUrl:
                'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',
          ),
          Lesson(
            title: 'Styling in Flutter',
            description: 'Applying styles to create visually appealing UIs.',
            videoUrl:
                'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',
          ),
          // Add more lessons as needed
        ],
      ),
      // Add more modules as needed
    ],
  ),
  // Add more courses as needed
];
