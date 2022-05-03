import 'package:besthouse/services/share_preference.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// services
import '../dio.dart';
import '../share_preference.dart';
// models
import '../../models/offer_form.dart';
import '../../models/response/error_response.dart';
import '../../models/response/info_response.dart';

class OfferFormApi {
  static Future<dynamic> postOffer(Offerform offer) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();

    // Extetior Picture
    FormData exteriorPictureFormData = FormData.fromMap({
      "files": await MultipartFile.fromFile(
        offer.picture!.path,
        filename: offer.picture!.path.split("/")[1],
        contentType: MediaType("image", "jpeg"),
      ),
    });
    final exteriorPicture =
        await DioInstance.dio.post("/storage", data: exteriorPictureFormData);
    offer.pictureUrl = exteriorPicture.data[0]["url"];

    // Rooms Pictures
    for (int i = 0; i < offer.rooms.length; i++) {
      List<MultipartFile> roomPicturesFiles = [];

      for (int j = 0; j < offer.rooms[i].pictures.length; j++) {
        roomPicturesFiles.add(
          await MultipartFile.fromFile(
            offer.rooms[i].files![j].path,
            filename: offer.rooms[i].files![j].path.split("/").last,
            contentType: MediaType("image", "jpeg"),
          ),
        );
      }

      FormData roomPicturesFormData = FormData.fromMap({
        "files": roomPicturesFiles,
      });

      final roomPictures =
          await DioInstance.dio.post("/storage", data: roomPicturesFormData);

      for (int j = 0; j < offer.rooms[i].pictures.length; j++) {
        offer.rooms[i].pictures.add(roomPictures.data[j]["url"] as String);
      }
    }

    print('ready ${offer.toJson()}');

    // Send an offer form
    final response = await DioInstance.dio.post("/offer", data: offer.toJson());

    print(response.statusCode);
    if (response.statusCode != 201) {
      return ErrorResponse.fromJson(response.data);
    }

    return InfoResponse.fromJson(response.data);
  }

  static Future<dynamic> getOffer(String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();

    final response = await DioInstance.dio.get("/offer/$id");

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }

    return InfoResponse.fromJson(response.data);
  }

  static Future<dynamic> getOfferList() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.get("/offer");
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }

  static Future<dynamic> deleteOffer(String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.delete("/offer/$id");
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }
}
