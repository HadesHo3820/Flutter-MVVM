import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:counter/domain/model/model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // return android device info
      var build = await deviceInfoPlugin.androidInfo;
      const _androidIdPlugin = AndroidId();
      name = build.brand! + " " + build.model!;
      identifier = await _androidIdPlugin.getId() ?? identifier;
      version = build.version.codename ?? version;
    } else if (Platform.isIOS) {
      // return ios device info
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name! + " " + build.model!;
      identifier = build.identifierForVendor ?? identifier;
      version = build.systemVersion ?? version;
    }
  } on PlatformException {
    // return default data here
    return DeviceInfo(name: name, identifier: identifier, version: version);
  }
  return DeviceInfo(name: name, identifier: identifier, version: version);
}

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
