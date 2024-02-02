import 'dart:math';

import 'package:flutter/material.dart';

final Map<ActColor, Color> _colorsMap = {
  ActColor.pink: Colors.pink,
  ActColor.red: Colors.red,
  ActColor.orange: Colors.orange,
  ActColor.deepOrange: Colors.deepOrange,
  ActColor.amber: Colors.amber,
  ActColor.yellow: Colors.yellow,
  ActColor.lime: Colors.lime,
  ActColor.lightGreen: Colors.lightGreen,
  ActColor.green: Colors.green,
  ActColor.teal: Colors.teal,
  ActColor.cyan: Colors.cyan,
  ActColor.lightBlue: Colors.lightBlue,
  ActColor.blue: Colors.blue,
  ActColor.indigo: Colors.indigo,
  ActColor.purple: Colors.purple,
  ActColor.deepPurple: Colors.deepPurple,
  ActColor.blueGrey: Colors.blueGrey,
  ActColor.brown: Colors.brown,
  ActColor.grey: Colors.grey,
};

enum ActColor {
  pink,
  red,
  orange,
  deepOrange,
  amber,
  yellow,
  lime,
  lightGreen,
  green,
  teal,
  cyan,
  lightBlue,
  blue,
  indigo,
  purple,
  deepPurple,
  blueGrey,
  brown,
  grey,
}

extension ActColorExtension on ActColor {
  Color get backgroundColor {
    final matchColor = _colorsMap[this] ?? Colors.grey;
    return matchColor.withAlpha(20);
  }
  Color get borderColor {
    final matchColor = _colorsMap[this] ?? Colors.grey;
    return matchColor.withAlpha(180);
  }
  Color get color {
    final matchColor = _colorsMap[this] ?? Colors.grey;
    return matchColor;
  }
	Color withOpacity(int value, int maxValue) {
    final matchColor = _colorsMap[this] ?? Colors.grey;
		double opacity = pow((value * 1.0) / maxValue, 1.25).toDouble();
		return matchColor.withOpacity(opacity < 0.2 ? 0.2 : opacity);
	}
}
