// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:fapjoymall/model/user_model.dart';
import 'package:fapjoymall/res/api_urls.dart';
import 'package:fapjoymall/res/provider/user_view_provider.dart';
import 'package:fapjoymall/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class FeedbackProvider with ChangeNotifier {

  static void navigateToAccount(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 4);
  }

  UserViewProvider userProvider = UserViewProvider();

  bool _regLoading = false;
  bool get regLoading =>_regLoading;
  setRegLoading(bool value){
    _regLoading=value;
    notifyListeners();
  }
  Future feedbackSubmit(context, String description) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    setRegLoading(true);
    final response = await http.post(
      Uri.parse(ApiUrl.feedback),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userid":token,
        "description":description
      }),
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response);
        print("responsebet");
      }
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
        print("responseData");
      }
      setRegLoading(false);
      FeedbackProvider.navigateToAccount(context);
      return Fluttertoast.showToast(msg: responseData['msg']);
    } else {
      setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['msg']);
    }
  }
}