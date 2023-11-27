class Module {
  final String id;
  final String title;
  final String description;
  final String videoUrl;

  Module({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
  });
}

class Course {
  final String id;
  final String title;
  final String description;
  final List<Module> modules;
  final String cover;
  final String level;
  final String totalModule;
  final String length;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.modules,
    required this.cover,
    required this.level,
    required this.totalModule,
    required this.length,
  });
}
