import 'package:hive_flutter/adapters.dart';
import 'package:whilabel_renewal/domain/notification_model.dart';

class HiveSingleton {
  static Future<void> setUpHive() async {
    try {
      await Hive.initFlutter();

      if (!Hive.isBoxOpen(NotificationModel.FCM)) {
        await Hive.openBox(NotificationModel.FCM);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  static Box<dynamic> getBox(String boxName){

    final box = Hive.box(NotificationModel.FCM);
    return box;

  }
}