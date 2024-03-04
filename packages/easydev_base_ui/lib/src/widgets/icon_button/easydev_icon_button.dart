import 'package:flutter/widgets.dart';

/// Simple button with [icon] in it.
///
///
/// Example of using [EasyDevIconButton].
/// ```dart
/// EasyDevIconButton(
///   CommunityMaterialIcons.close,
///   onTap: () {
///     // Add your onTap code here!
///   },
/// ),
/// ```
///
///
/// This sample produces variants of EasyDevIconButton.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_icon_button_example.dart
class EasyDevIconButton extends StatelessWidget {
  /// Create icon button.
  const EasyDevIconButton(
    this.icon, {
    super.key,
    this.size,
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.color,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
    this.padding,
    this.onTap,
  });

  /// Icon of the button.
  final IconData icon;

  /// Callback that calls when button is tapped.
  final VoidCallback? onTap;

  /// The size of the icon in logical pixels.
  ///
  /// Icons occupy a square with width and height equal to size.
  final double? size;

  /// The fill for drawing the icon.
  ///
  /// Requires the underlying icon font to support the `FILL` [FontVariation]
  /// axis, otherwise has no effect. Variable font filenames often indicate
  /// the supported axes. Must be between 0.0 (unfilled) and 1.0 (filled),
  /// inclusive.
  ///
  /// Can be used to convey a state transition for animation or interaction.
  final double? fill;

  /// The stroke weight for drawing the icon.
  ///
  /// Requires the underlying icon font to support the `wght` [FontVariation]
  /// axis, otherwise has no effect. Variable font filenames often indicate
  /// the supported axes. Must be greater than 0.
  final double? weight;

  /// The grade (granular stroke weight) for drawing the icon.
  ///
  /// Requires the underlying icon font to support the `GRAD` [FontVariation]
  /// axis, otherwise has no effect. Variable font filenames often indicate
  /// the supported axes. Can be negative.
  ///
  /// Grade and [weight] both affect a symbol's stroke weight (thickness), but
  /// grade has a smaller impact on the size of the symbol.
  ///
  /// Grade is also available in some text fonts. One can match grade levels
  /// between text and symbols for a harmonious visual effect. For example, if
  /// the text font has a -25 grade value, the symbols can match it with a
  /// suitable value, say -25.
  final double? grade;

  /// The optical size for drawing the icon.
  ///
  /// Requires the underlying icon font to support the `opsz` [FontVariation]
  /// axis, otherwise has no effect. Variable font filenames often indicate
  /// the supported axes. Must be greater than 0.
  ///
  /// For an icon to look the same at different sizes, the stroke weight
  /// (thickness) must change as the icon size scales. Optical size offers a way
  /// to automatically adjust the stroke weight as icon size changes.
  final double? opticalSize;

  /// The color to use when drawing the icon.
  final Color? color;

  /// A list of [Shadow]s that will be painted underneath the icon.
  ///
  /// Multiple shadows are supported to replicate lighting from multiple light
  /// sources.
  ///
  /// Shadows must be in the same order for [Icon] to be considered as
  /// equivalent as order produces differing transparency.
  final List<Shadow>? shadows;

  /// Semantic label for the icon.
  ///
  /// Announced in accessibility modes (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  final String? semanticLabel;

  /// The text direction to use for rendering the icon.
  final TextDirection? textDirection;

  /// Padding of the button.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          size: size,
          fill: fill,
          weight: weight,
          grade: grade,
          opticalSize: opticalSize,
          color: color,
          shadows: shadows,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        ),
      ),
    );
  }
}
