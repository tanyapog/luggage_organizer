import 'package:flutter/material.dart';

class AppPadding {
  const AppPadding._();

  static const _h = 25.0;
  static const _v = 15.0;

  static const vertical15 = EdgeInsets.symmetric(vertical: _v);
  static const horizontal = EdgeInsets.symmetric(horizontal: _h);
  static const right16 = EdgeInsets.only(right: 16);
  static const fullScreenForm = EdgeInsets.symmetric(horizontal: _h, vertical: _v);
  static const fullScreenList = EdgeInsets.symmetric(horizontal: 8, vertical: _v);
}