class InfoResponse {
  final dynamic data;
  final String message;

  InfoResponse(this.data, this.message);

  factory InfoResponse.fromJson(Map<String, dynamic> json) {
    return InfoResponse(json["data"], json["message"]);
  }
}
