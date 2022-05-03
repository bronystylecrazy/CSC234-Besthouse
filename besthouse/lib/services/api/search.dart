import '../dio.dart';
// models
import '../../models/response/error_response.dart';
import '../../models/response/info_response.dart';

class SearchApi {
  static Future<dynamic> search(String query) async {
    final response = await DioInstance.dio.post("/search");

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }

    final data = response.data;
    return InfoResponse(data.data, data.message);
  }
}
