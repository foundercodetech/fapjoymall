import 'package:fapjoymall/model/howtoplay_model.dart';
import 'package:flutter/material.dart';


class HowtoplayProvider with ChangeNotifier {
  HowtoplayModel? howToPlayData;

  HowtoplayModel? get howToPlayDataStore => howToPlayData;

  void setrules(HowtoplayModel ruledata) {
    howToPlayData = ruledata;
    notifyListeners();
  }
}