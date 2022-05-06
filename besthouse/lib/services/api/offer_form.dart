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
  /// Create new offer
  static Future<dynamic> postOffer(Offerform offer) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();

    // Extetior Picture
    FormData exteriorPictureFormData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        offer.picture!.path,
        filename: offer.picture!.path.split("/").last,
        contentType: MediaType("image", "jpeg"),
      ),
    });

    final exteriorPicture = await DioInstance.dio.post("/storage", data: exteriorPictureFormData);
    offer.pictureUrl = exteriorPicture.data[0]["url"];

    // Rooms Pictures
    for (int i = 0; i < offer.rooms.length; i++) {
      List<MultipartFile> roomPicturesFiles = [];

      for (int j = 0; j < offer.rooms[i].files!.length; j++) {
        roomPicturesFiles.add(
          await MultipartFile.fromFile(
            offer.rooms[i].files![j].path,
            filename: offer.rooms[i].files![j].path.split("/").last,
            contentType: MediaType("image", "jpeg"),
          ),
        );
      }

      FormData roomPicturesFormData = FormData.fromMap({
        "file": roomPicturesFiles,
      });

      final roomPictures = await DioInstance.dio.post("/storage", data: roomPicturesFormData);

      var tempList = <String>[];
      for (int j = 0; j < offer.rooms[i].files!.length; j++) {
        tempList.add(roomPictures.data[j]["url"] as String);
      }
      offer.rooms[i].pictures = tempList;
    }

    // Send an offer form
    final response = await DioInstance.dio.post("/offer", data: offer.toJson());

    if (response.statusCode != 201) {
      return ErrorResponse.fromJson(response.data);
    }

    return InfoResponse.fromJson(response.data);
  }

  /// Fetch offer detail by house_id
  static Future<dynamic> getOfferInfo(String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();

    final response = await DioInstance.dio.get("/offer/$id");

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }

    return InfoResponse.fromJson(response.data);
  }

  /// Fetch list of offers
  static Future<dynamic> getOfferList() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.get("/offer");
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }

  /// Update offer by house_id
  static Future<dynamic> updateOffer(Offerform offer, String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();

    if (offer.picture != null) {
      // Extetior Picture
      FormData exteriorPictureFormData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          offer.picture!.path,
          filename: offer.picture!.path.split("/").last,
          contentType: MediaType("image", "jpeg"),
        ),
      });

      final exteriorPicture = await DioInstance.dio.post("/storage", data: exteriorPictureFormData);
      offer.pictureUrl = exteriorPicture.data[0]["url"];
    }

    // Rooms pictures
    for (var room in offer.rooms) {
      if (room.files != null) {
        List<MultipartFile> roomPicturesFiles = [];

        for (var file in room.files!) {
          roomPicturesFiles.add(
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split("/").last,
              contentType: MediaType("image", "jpeg"),
            ),
          );
        }

        FormData roomPicturesFormData = FormData.fromMap({
          "file": roomPicturesFiles,
        });

        final roomPictures = await DioInstance.dio.post("/storage", data: roomPicturesFormData);

        for (int j = 0; j < room.files!.length; j++) {
          room.pictures.add(roomPictures.data[j]["url"] as String);
        }
      }
    }

    // Send an edit form
    final response = await DioInstance.dio.patch("/offer/$id", data: offer.toJson());

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }

    return InfoResponse.fromJson(response.data);
  }

  /// Delete offer by house_id
  static Future<dynamic> deleteOffer(String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.delete("/offer/$id");
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }

  /// Change offer status using house_id
  static Future<dynamic> toggleOffer(String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.patch("/offer/toggle/$id");
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }
}
