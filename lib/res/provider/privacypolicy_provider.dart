import 'package:fapjoymall/model/termsconditionModel.dart';
import 'package:flutter/material.dart';


class PrivacyPolicyProvider with ChangeNotifier {
  TcModel? _ppData;

  TcModel? get ppData => _ppData;

  void setPrivacy(TcModel privacyData) {
    _ppData = privacyData;
    notifyListeners();
  }
}