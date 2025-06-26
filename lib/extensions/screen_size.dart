import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  double getWidth({double multiplied = 1}) {
    return MediaQuery.sizeOf(this).width * multiplied;
  }

  double getHeight({double multiplied = 1}) {
    return MediaQuery.sizeOf(this).height * multiplied;
  }
}
