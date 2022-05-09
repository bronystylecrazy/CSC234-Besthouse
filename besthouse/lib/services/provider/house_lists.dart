import 'package:besthouse/models/house.dart';
import 'package:flutter/foundation.dart';

class SearchList with ChangeNotifier, DiagnosticableTreeMixin {
  List<House> houses = [];
  bool isLoading = false;

  void updateList(List<House> newHouses) {
    houses = newHouses;
    notifyListeners();
  }

  void changeLoadState(bool value) {
    isLoading = value;
    notifyListeners();
  }
}

class FeatureHousesList with ChangeNotifier, DiagnosticableTreeMixin {
  List<House> houses = [];
  bool isLoading = true;

  void updateList(List<House> newHouses) {
    houses = newHouses;
    notifyListeners();
  }

  void changeLoadState(bool value) {
    isLoading = value;
    notifyListeners();
  }
}

class NearbyHousesList with ChangeNotifier, DiagnosticableTreeMixin {
  List<House> houses = [];
  bool isLoading = true;

  void updateList(List<House> newHouses) {
    houses = newHouses;
    notifyListeners();
  }

  void changeLoadState(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
