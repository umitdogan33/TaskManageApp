import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
  class PlatformDetect {

  TargetPlatform detect(){
    return defaultTargetPlatform;
  }

  bool isWeb(){
    if(kIsWeb){
      return true;
    }
    return false;
  }

   bool isOther(){
    if(kIsWeb == false){
      return true;
    }
    else{
      return false;
    }
  }
}
