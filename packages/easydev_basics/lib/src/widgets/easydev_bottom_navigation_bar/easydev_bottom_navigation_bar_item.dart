import 'package:easydev_basics/easydev_basics.dart';
import 'package:flutter/widgets.dart';

/// Simple class containing label and icon of bottom navigation bar item. Indicator shows circle
/// on top right of icon, if set to true.
class EasyDevBottomNavigationBarItem {
  EasyDevBottomNavigationBarItem({
    required this.icon,
    this.label,
    this.needIndicator = false,
  });

  /// Icon of the item.
  final IconData icon;

  /// Label of the item.
  final String? label;

  /// If true shows circle of [EasyDevBottomNavigationBar.indicatorColor] on top right of icon.
  final bool needIndicator;
}
