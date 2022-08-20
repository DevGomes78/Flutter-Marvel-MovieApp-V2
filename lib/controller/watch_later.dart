import 'package:flutter/material.dart';
import 'package:marvel/data/models/marvel_models.dart';

class Watchlater extends ChangeNotifier {
  List<Data> listLater = [];

  void listLaterOnly(Data data) {
    if (listLater.contains(data)) {
    } else {
      listLater.add(data);
      notifyListeners();
    }
  }

  void removeFavorites(Data data) {
    listLater.remove(data);
    notifyListeners();
  }
}
