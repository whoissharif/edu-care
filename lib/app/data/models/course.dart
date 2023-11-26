class Lesson {
  final String title;
  final String description;
  final String videoUrl;

  Lesson({
    required this.title,
    required this.description,
    required this.videoUrl,
  });
}

class Module {
  final String title;
  final String description;
  final List<Lesson> lessons;

  Module({
    required this.title,
    required this.description,
    required this.lessons,
  });
}

class Course {
  final String id;
  final String title;
  final String description;
  final List<Module> modules;
  final String cover;
  final String level;
  final String totalLessons;
  final String length;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.modules,
    required this.cover,
    required this.level,
    required this.totalLessons,
    required this.length,
  });
}
