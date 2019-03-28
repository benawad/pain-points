import 'package:flutter/material.dart';

enum PainLevel { low, medium, high }
enum PainSide { left, right }
enum PainLocation { hand, wrist, elbow }

var colorMap = {
  'low': Colors.green,
  'medium': Colors.yellow,
  'high': Colors.red,
};
