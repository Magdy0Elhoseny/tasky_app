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
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      priority: json['priority'] ?? '',
      dueDate: json['dueDate'] ?? '',
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