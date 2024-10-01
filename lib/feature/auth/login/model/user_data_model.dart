class UserData {
  late final String phone;
  late final String password;
  late final String displayName;
  late final int experienceYears;
  late final String address;
  late final String level;

  UserData({
    required this.phone,
    required this.password,
    required this.displayName,
    required this.experienceYears,
    required this.address,
    required this.level,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    displayName = json['displayName'];
    experienceYears = json['experienceYears'];
    address = json['address'];
    level = json['level'];
  }
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'displayName': displayName,
      'experienceYears': experienceYears,
      'address': address,
      'level': level,
    };
  }
}
