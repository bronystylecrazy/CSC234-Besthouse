import 'package:besthouse/services/share_preference.dart';
// services
import '../dio.dart';
import '../share_preference.dart';
// models
import '../../models/house.dart';
import '../../models/house_detail.dart';
import '../../models/response/error_response.dart';
import '../../models/response/info_response.dart';

class SearchApi {
  static Future<dynamic> getNearByHouses(double? long, double? lat) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.get(
      "/search/near?lat=$lat&long=$long",
    );
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }

    return InfoResponse.fromJson(response.data);
  }

  static Future<dynamic> search(Map<String, dynamic> reqJson) async {
    final response = await DioInstance.dio.post("/search", data: reqJson);
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }
}
