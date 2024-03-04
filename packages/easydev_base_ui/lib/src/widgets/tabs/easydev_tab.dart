import 'package:flutter/widgets.dart';

class EasyDevTab extends StatelessWidget implements PreferredSizeWidget {
  const EasyDevTab({
    super.key,
    this.text,
    this.height,
    this.child,
  }) : assert(
            (text != null && child == null) || (text == null && child != null),
            'You can\'t provide both text and child');

  /// The text to display as the tab's label.
  final String? text;

  /// The widget to be used as the tab's label.
  /// Must not be used in combination with [text].
  final Widget? child;

  /// The height of the tab.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final Widget label = text != null
        ? Text(text!, softWrap: false, overflow: TextOverflow.fade)
        : child!;
    return SizedBox(
      height: height ?? 46.0,
      child: Center(
        widthFactor: 1.0,
        child: label,
      ),
    );
  }

  @override
  Size get preferredSize {
    if (height != null) {
      return Size.fromHeight(height!);
    } else {
      return const Size.fromHeight(46.0);
    }
  }
}