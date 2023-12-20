import 'package:flutter/material.dart';

/// Shortcut for SizedBox
/// compare: SizedBox(height: 16) vs Box.s16
class Box extends SizedBox {
  final bool isWidth;
  final bool isHeight;

  const Box.s(double size, {
    super.key,
    this.isWidth = true,
    this.isHeight = true,
  }) : super(
    width: isWidth ? size : 0,
    height: isHeight ? size : 0,
  );

  static const s8 = Box.s(8);
  static const s16 = Box.s(16);
  static const s24 = Box.s(24);
  static const s32 = Box.s(32);
  static const s40 = Box.s(40);
  static const s80 = Box.s(80);
}
