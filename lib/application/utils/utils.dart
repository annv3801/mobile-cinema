import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    final data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();

    final byteData = await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }
}
