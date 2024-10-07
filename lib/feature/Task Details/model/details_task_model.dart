class DetailsTaskModel {
  final String id;
  final String status;
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String createdAt;
  final String updatedAt;

  DetailsTaskModel({
    required this.id,
    required this.status,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetailsTaskModel.fromJson(Map<String, dynamic> json) {
    return DetailsTaskModel(
      id: json['_id']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      desc: json['desc']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'status': status,
      'image': image,
      'title': title,
      'desc': desc,
      'priority': priority,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
