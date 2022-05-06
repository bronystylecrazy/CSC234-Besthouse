import 'package:besthouse/services/share_preference.dart';
// services
import '../dio.dart';
import '../share_preference.dart';
// models
import '../../models/response/error_response.dart';
import '../../models/response/info_response.dart';
class SearchApi {
  static Future<dynamic> getHousesList(double? long, double? lat) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.post("/search/near", data: {
      "lat": lat,
      "long":long
    });

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }
  
}
