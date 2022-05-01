import '../dio.dart';
// models
import '../../models/response/error_response.dart';
import '../../models/response/info_response.dart';

class UserApi {
  static Future<dynamic> login(String username, String password) async {
    var response = await DioInstance.dio
        .post("/user/signin", data: {"username": username, "password": password});
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }
}
