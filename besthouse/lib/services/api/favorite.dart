import 'package:besthouse/services/share_preference.dart';
// services
import '../dio.dart';
import '../share_preference.dart';
// models
import '../../models/response/error_response.dart';
import '../../models/response/info_response.dart';

class FavoriteApi {
  static Future<dynamic> getFavoriteHouseList() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.get(
      "/favorite",
    );
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }

  static Future<dynamic> addFavoriteHouse(String houseId) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.post(
      "/favorite",
      data: {"house_id": houseId},
    );
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }
}

// static Future<dynamic> getOfferList() async {
//     DioInstance.dio.options.headers["authorization"] =
//         "Bearer " + SharePreference.prefs.getString("token").toString();
//     var response = await DioInstance.dio.get("/offer");
//     if (response.statusCode != 200) {
//       return ErrorResponse.fromJson(response.data);
//     }
//     return InfoResponse.fromJson(response.data);
//   }