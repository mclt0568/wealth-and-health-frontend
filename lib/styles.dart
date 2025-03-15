import 'dart:ui';

import 'package:flutter/material.dart';

class AppStyles {
  static const Color accentBackground = Color.fromARGB(255, 194, 242, 213);
  static const Color accentForeground = Color.fromARGB(255, 40, 119, 62);
  static const Color primaryBackground = Color(0xFFFFFFFF);
  static const Color secondaryBackground = Color(0xFFF3F3F3);
  static const Color primaryForeground = Color(0xFF393939);
  static const Color secondaryForeground = Color(0xFF666666);

  static const BoxShadow shadow = BoxShadow(
    blurRadius: 5,
    // spreadRadius: -3,
    offset: Offset(0, 3),
    color: Color(0x77C5C5C5),
  );

  static const TextStyle title = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w300,
    color: AppStyles.primaryForeground,
  );

  static const TextStyle welcomeMessage = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    color: AppStyles.primaryForeground,
  );

  static const TextStyle paragraph = TextStyle(
    fontSize: 20,
    color: AppStyles.primaryForeground,
  );
  static const TextStyle accentedParagraph = TextStyle(
    fontSize: 20,
    color: AppStyles.accentForeground,
  );
}
