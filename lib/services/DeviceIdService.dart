import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class DeviceIdService {
  Future<void> addDevice(String deviceId) async{
    var instance = FirebaseDatabase.instance;
    instance.ref().child("devices/$deviceId").set({"added":"true"});
  }

  void pushNotification(List<String> ids,String content,String heading) async{
    await OneSignal.shared.postNotification(OSCreateNotification(
      playerIds: ids,
      content: content,
      heading: heading,
    ));
  }

  void pushNotificationAll(String content,String heading) async{
    var ref = await FirebaseDatabase.instance.ref("devices").once().then((value){
      print("value $value");
      var data = value.snapshot.value as dynamic;
      List<String> ids = [];
      data.forEach((key,nesne){
        ids.add(key);
      });
    pushNotification(ids, content, heading);
    });
  }
}