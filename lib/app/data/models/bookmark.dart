class Bookmark {
  final String courseId;
  final String moduleId;
  final int positionInSeconds;

  Bookmark({
    required this.courseId,
    required this.moduleId,
    required this.positionInSeconds,
  });

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'moduleId': moduleId,
      'positionInSeconds': positionInSeconds,
    };
  }

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      courseId: json['courseId'],
      moduleId: json['moduleId'],
      positionInSeconds: json['positionInSeconds'],
    );
  }
}
