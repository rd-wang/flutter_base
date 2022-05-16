import 'package:flutter/cupertino.dart';

enum ErrorStyle {
  style_1,// 默认
  style_2,// 单词卡
}

class RooboErrorContent {
  static ErrorStyle? _style = ErrorStyle.style_1; // 内容

  static ErrorStyle get style => _style!;

  static set style(ErrorStyle? style) {
    _style = style;
  }
}