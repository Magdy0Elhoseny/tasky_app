class DetailsTaskModel {
  final String id;
  final String status;
  final String image;
  final String title;
  final String desc;
  final String priority;

  DetailsTaskModel({
    required this.id,
    required this.status,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
  });

  factory DetailsTaskModel.fromJson(Map<String, dynamic> json) {
    return DetailsTaskModel(
      id: json['_id']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      desc: json['desc']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
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
    };
  }
}
