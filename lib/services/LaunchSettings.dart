import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manage_app/services/DeviceIdService.dart';
import 'package:task_manage_app/services/UserService.dart';

class LaunchSettings {
  void Settings() async {
    OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);

    OneSignal.shared.setAppId("ffb3d8b2-1f64-45f5-b70c-7cdc7cc18689");
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});

    var device = await OneSignal.shared.getDeviceState();

    var sp = await SharedPreferences.getInstance();
    var firstOpen = sp.getBool("firstOpen") ?? true;
    if(firstOpen == true){
      sp.setBool("notipermission", true);
      sp.setBool("notiemail", true);
      sp.setBool("firstOpen", false);
    }
    print(device!.userId.toString());
    DeviceIdService().addDevice(device!.userId.toString());
  }
}
