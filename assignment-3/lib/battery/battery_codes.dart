import 'package:battery/battery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BatteryReceiver {
  static final Battery _battery = Battery();

  static void registerBatteryReceiver() {
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      _handleBatteryStateChanged(state);
    });
  }

  static void _handleBatteryStateChanged(BatteryState state) {
    if (state == BatteryState.charging) {
      _battery.batteryLevel.then((batteryLevel) {
        if (batteryLevel >= 90) {
          _showToast("Battery reached 90% charge!");
        }
      });
    }
  }

  static void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
