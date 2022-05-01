class InfoResponse {
  final bool success = true;
  final dynamic data;
  final String message;
  final int status = 200;

  InfoResponse(this.data, this.message);

  factory InfoResponse.fromJson(Map<String, dynamic> json) {
    return InfoResponse(json["data"], json["message"]);
  }
}
