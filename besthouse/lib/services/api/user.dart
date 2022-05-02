import '../dio.dart';
// models
import '../../models/response/error_response.dart';
import '../../models/response/info_response.dart';

class UserApi {
  static Future<dynamic> login(String username, String password) async {
    var response = await DioInstance.dio.post("/user/signin",
        data: {"username": username, "password": password});
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }

  static Future<dynamic> resgister(String username, String password,
      String email, String firstname, String lastname, String tel) async {
    var response = await DioInstance.dio.post("/user/signup", data: {
      "username": username,
      "password": password,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "tel": tel
    });
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }
}
