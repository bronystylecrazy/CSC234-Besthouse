class ErrorResponse {
  final bool success;
  final String message;
  final int status;

  ErrorResponse(this.success, this.message, this.status);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(json["success"], json["message"], json["status"]);
  }
}
