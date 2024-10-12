class AddTaskModel {
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String dueDate;

  AddTaskModel({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.dueDate,
  });

  factory AddTaskModel.fromJson(Map<String, dynamic> json) {
    return AddTaskModel(
      image: json['image'] as String? ?? '',
      title: json['title'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      priority: json['priority'] as String? ?? '',
      dueDate: json['dueDate'] as String? ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'desc': desc,
      'priority': priority,
      'dueDate': dueDate,
    };
  }
}


// {
//     "image"  : "path.png",
//     "title" : "title",
//     "desc" : "desc",
//     "priority" : "low",//low , medium , high
//     "dueDate" : "2024-05-15"
// }