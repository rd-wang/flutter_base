import 'package:flutter/cupertino.dart';

class RooboContext{
  static BuildContext? _context;

  static BuildContext? get context => _context;

  static set context(BuildContext? value) {
    _context = value;
  }
}