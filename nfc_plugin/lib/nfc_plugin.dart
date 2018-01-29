import 'dart:async';

import 'package:flutter/services.dart';

class NfcPlugin {
  static const MethodChannel _channel =
      const MethodChannel('nfc_plugin');

  static Future<bool> isSupported() async {
    bool isSupported = await _channel.invokeMethod('isSupported');
    return isSupported;
  }

  static Future<bool> isEnable() async {
    bool isEnable = await _channel.invokeMethod('isEnable');
    return isEnable;
  }
}
