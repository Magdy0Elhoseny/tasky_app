// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileModel {
  final String id;
  final String displayName;
  final String username;
  final String roles;
  final String active;
  final String experienceYears;
  final String address;
  final String level;
  final String createdAt;
  final String updatedAt;
  ProfileModel({
    required this.id,
    required this.displayName,
    required this.username,
    required this.roles,
    required this.active,
    required this.experienceYears,
    required this.address,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      displayName: json['displayName'] ?? '',
      username: json['username'] ?? '',
      roles: (json['roles'] as List<dynamic>).join(', '),
      active: json['active'].toString(),
      experienceYears: json['experienceYears'].toString(),
      address: json['address'] ?? '',
      level: json['level'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
