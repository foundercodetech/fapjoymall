import 'package:fapjoymall/model/notification_model.dart';
import 'package:flutter/material.dart';


class NotificationProvider with ChangeNotifier {
  NotificationModel? notificationData;

  NotificationModel? get notificationDataStore => notificationData;

  void setnotification(NotificationModel notidata) {
    notificationData = notidata;
    notifyListeners();
  }
}