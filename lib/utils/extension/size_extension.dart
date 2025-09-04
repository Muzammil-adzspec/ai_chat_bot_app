import 'package:flutter/material.dart';

extension SizeExtension on int {
  Widget get w => SizedBox(width: toDouble());

  Widget get h => SizedBox(height: toDouble());
}