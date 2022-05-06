import '../dio.dart';
// models
import '../../models/response/error_response.dart';
import '../../models/response/info_response.dart';

class SearchApi {
  static Future<dynamic> search(Map<String, dynamic> reqJson) async {
    final response = await DioInstance.dio.post("/search", data: reqJson);

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }

    return InfoResponse.fromJson(response.data);
  }
}
