import 'dart:io';

import 'package:besthouse/services/share_preference.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

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

  static Future<dynamic> resgister(String username, String password, String email, String firstname,
      String lastname, String tel) async {
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

  static Future<dynamic> getUser() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.get(
      "/profile",
    );
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }

  static Future<dynamic> updateUser(String username, String firstname, String lastname, String tel,
      String line, String facebook) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.patch("/profile", data: {
      "username": username,
      "firstname": firstname,
      "lastname": lastname,
      "tel": tel,
      "line_id": line,
      "facebook": facebook
    });
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }

  static Future<Response<dynamic>> uploadProfilePicture(File file) async {
    FormData exteriorPictureFormData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split("/")[1],
        contentType: MediaType("image", "jpeg"),
      ),
    });
    final exteriorPicture = await DioInstance.dio.post("/storage", data: exteriorPictureFormData);
    DioInstance.dio
        .patch("/profile/picture", data: {"picture_url": exteriorPicture.data[0]['url']});
    return exteriorPicture;
  }
}
