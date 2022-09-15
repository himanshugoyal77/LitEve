import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double widthInPx = 1080;
  static double heightInPx = 1920;
  static double defaultSize = 21;
  static MediaQueryData? _mediaQueryData;
  static double? pixelRatio;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultHeight;
  static double? defaultWidth;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    pixelRatio = _mediaQueryData!.devicePixelRatio;
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    defaultHeight = defaultSize * screenHeight! / heightInPx;
    defaultWidth = defaultSize * screenWidth! / widthInPx;
  }
}

class Contants {
  static Color scaffoldPColor = const Color.fromARGB(255, 30, 54, 148);

  static List<Map<String, String>> imgList = [
    {"img": "assets/img/aiw.jpg", "name": "AI Warriers"},
    {"img": "assets/img/csi.jpg", "name": "CSI Vesit"},
    {"img": "assets/img/isa.jpg", "name": "ISA Vesit"},
    {"img": "assets/img/iste.png", "name": "ISTE Vesit"},
    {"img": "assets/img/sport.jpg", "name": "SPORTS "}
  ];

  static Map<int, Color> color = {
    50: Color.fromARGB(255, 255, 255, 255),
    100: Color.fromARGB(255, 255, 255, 255),
  };
  static MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);
}
