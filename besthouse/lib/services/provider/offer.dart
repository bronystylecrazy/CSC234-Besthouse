import 'package:flutter/foundation.dart';

class OfferFormProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String houseId = "";

  void updateHouseId(String id) {
    houseId = id;
    notifyListeners();
  }
}
