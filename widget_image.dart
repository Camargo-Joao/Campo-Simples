import 'package:flutter/material.dart';

Widget widgetImage(String path, double size) {
  return Image.asset(
    path,
    height: size,
    errorBuilder: (context, error, stackTrace) {
      return Icon(Icons.error, size: 200);
    },
  );
}
