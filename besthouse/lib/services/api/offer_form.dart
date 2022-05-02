import 'package:dio/dio.dart';
import 'package:http_parser/src/media_type.dart';
import '../../models/offer_form.dart';
import '../dio.dart';
// models
import '../../models/response/error_response.dart';
import '../../models/response/info_response.dart';

class OfferFormApi {
  static Future<dynamic> postOffer(Offer offer) async {
    for (int i = 0; i < offer.rooms.length; i++) {
      List<MultipartFile> files = [];

      for (int j = 0; j < offer.rooms[i].pictures.length; j++) {
        var pic = offer.rooms[i].pictures[j];
        var file = await MultipartFile.fromFile(pic.path,
            filename: pic.path.split('/').last, contentType: MediaType('image', 'jpeg'));
        files.add(file);
      }

      offer.rooms[i].files = files;
    }

    offer.file = await MultipartFile.fromFile(offer.pictureUrl.path,
        filename: offer.pictureUrl.path.split('/').last);

    FormData formData = FormData.fromMap(offer.toJson());

    print('formData: ${formData.files}');

    var response = await DioInstance.dio.post("/storage", data: formData);
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }
}
