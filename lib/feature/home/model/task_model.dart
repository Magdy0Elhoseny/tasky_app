import 'package:get/get.dart';

class Task {
  final String id;
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String createdAt;
  final String updatedAt;

  Task({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    try {
      return Task(
        id: json['_id']?.toString() ?? '',
        image: json['image']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        desc: json['desc']?.toString() ?? '',
        priority: json['priority']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        createdAt: json['createdAt']?.toString() ?? '',
        updatedAt: json['updatedAt']?.toString() ?? '',
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load tasks data');
      rethrow;
    }
  }
}
