class RequestResponseModel {
  late int code;
  late bool status;
  late String msg;
  dynamic data;

  RequestResponseModel({
    required this.code,
    required this.status,
    required this.msg,
    this.data,
  });

  RequestResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? false;
    msg = json["message"] ?? "";
    data = json["data"];
    code = json["code"] ?? 0;
  }
}
