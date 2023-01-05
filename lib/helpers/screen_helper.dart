import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

class ScreenHelper {
  static const Size defaultMockpupSize = Size(360, 690);
  static late ScreenHelper _instance;

  ScreenHelper._internal();

  factory ScreenHelper() {
    return _instance;
  }

  late Size uiSize;

  late double _pixelRatio;
  late double _screenWidth;
  late double _screenHeight;
  late double _statusBarHeight;
  late double _bottomBarHeight;
  late double _textScaleFactor;

  static void init(BoxConstraints constraints,
      {Size mockpuSize = defaultMockpupSize}) {
    _instance = ScreenHelper._internal()
      ..uiSize = mockpuSize
      .._screenWidth = constraints.maxWidth
      .._screenHeight = constraints.maxHeight;

    final window = WidgetsBinding.instance?.window ?? ui.window;
    _instance._pixelRatio = window.devicePixelRatio;
    _instance._statusBarHeight = window.padding.top;
    _instance._bottomBarHeight = window.padding.bottom;
    _instance._textScaleFactor = window.textScaleFactor;
  }

  double get screenWith => _screenWidth;

  double get screenHeight => _screenHeight;

  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  double get textScaleFactor => _textScaleFactor;

  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  double setWidth(num width) => width * scaleWidth;

  double setHeight(num height) => height * scaleHeight;

  double radius(num r) => r * scaleText;

  double setSp(num fontSize) => fontSize * scaleText;
}

extension SizeExtension on num {
  double get w => ScreenHelper().setWidth(this);

  double get h => ScreenHelper().setHeight(this);

  double get r => ScreenHelper().radius(this);

  double get sp => ScreenHelper().setSp(this);
}
