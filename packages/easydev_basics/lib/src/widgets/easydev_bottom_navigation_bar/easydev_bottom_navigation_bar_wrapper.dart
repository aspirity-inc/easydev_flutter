import 'package:easydev_basics/easydev_basics.dart';
import 'package:flutter/material.dart';

/// Internal widget to wrap [EasyDevDevNavigationBarItem] to provide them with decorations.
class EasyDevBottomNavigationBarItemWrapper extends StatelessWidget {
  const EasyDevBottomNavigationBarItemWrapper({
    super.key,
    required this.item,
    required this.selected,
    required this.showLabel,
    required this.iconSize,
    required this.onTap,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    required this.indicatorColor,
    required this.selectedLabelTextStyle,
    required this.unselectedLabelTextStyle,
  });

  final EasyDevBottomNavigationBarItem item;
  final bool selected;
  final bool showLabel;
  final double iconSize;
  final VoidCallback onTap;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final Color? indicatorColor;
  final TextStyle selectedLabelTextStyle;
  final TextStyle unselectedLabelTextStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: iconSize + 5,
            width: iconSize + 8,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                    item.icon,
                    size: iconSize,
                    color: selected ? selectedIconColor : unselectedIconColor,
                  ),
                ),
                if (item.needIndicator)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: indicatorColor,
                      ),
                    ),
                  )
              ],
            ),
          ),
          if (showLabel && item.label != null) ...[
            const SizedBox(
              height: 8,
            ),
            Text(
              item.label!,
              style: selected ? selectedLabelTextStyle : unselectedLabelTextStyle,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ],
      ),
    );
  }
}
