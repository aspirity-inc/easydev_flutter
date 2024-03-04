import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_code_input/code_symbol_widget.dart';
import 'package:flutter/widgets.dart';

/// Internal widget for displaying code used in [EnterCodeWithKeyboard]
/// and [EnterCodeField] with additional features to provides simpler code entering experience.
///
///
/// Example of using [CodeWidget].
/// ```dart
/// CodeWidget(
///   value: "1234",
/// ),
/// ```
///
class CodeWidget extends StatelessWidget {
  const CodeWidget({
    super.key,
    required this.value,
    this.codeLength = 4,
    this.inputSize = 32,
    this.spacing = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.codeStyle,
    this.emptyColor,
    this.backgroundColor,
    this.borderColor,
  });

  /// Value of widget, does not show symbols with index more that [codeLength]
  final String value;

  /// Length of code widget. Initially 4.
  final int codeLength;

  /// Spacing between symbols.
  final double spacing;

  /// Size of symbol widget. Multiplied by text scale factor.
  final double inputSize;

  /// Border radius of [CodeSymbolWidget]
  final BorderRadius borderRadius;

  /// Color of symbol in [CodeSymbolWidget]
  final TextStyle? codeStyle;

  /// Color of border without value for [CodeSymbolWidget]
  final Color? emptyColor;

  /// Color of background of [CodeSymbolWidget].
  final Color? backgroundColor;

  /// Color of border with value for [CodeSymbolWidget].
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        codeLength,
        (index) {
          return Padding(
            padding: index - 1 == codeLength
                ? EdgeInsets.zero
                : const EdgeInsets.only(
                    right: 8,
                  ),
            child: CodeSymbolWidget(
              letter: value.length > index ? value[index] : null,
              emptyColor: emptyColor,
              backgroundColor: value.length > index ? null : backgroundColor,
              borderColor: borderColor,
              borderRadius: borderRadius,
              codeStyle: codeStyle,
              size: inputSize,
            ),
          );
        },
      ),
    );
  }
}
