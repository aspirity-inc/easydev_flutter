import 'package:flutter/services.dart';

/// {@macro flutter.services.text_formatter}
/// Formatter for masked digits. Can be used to format inputs on phone numbers,
/// bank card, etc.
///
/// Example of using digit mask input formatter.
/// ```dart
/// DigitMaskedInputFormatter(mask: '(###) ###-##-##')
/// ```
///
class DigitMaskedInputFormatter extends TextInputFormatter {
  DigitMaskedInputFormatter({
    required this.mask,
    this.maskSymbol = '#',
  }) : assert(maskSymbol.length == 1);

  /// Mask of formatter.
  final String mask;

  /// Symbols of masks that represent digits.
  /// Can be overriden from '#' to any other symbol.
  final String maskSymbol;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > mask.length) return oldValue;

    final oldValueDigitsText = oldValue.text.replaceAll(RegExp(r'[^\d]'), '');
    String digitsText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    TextSelection newSelection = newValue.selection;

    if (oldValue.text.length > newValue.text.length &&
        oldValueDigitsText.length == digitsText.length) {
      for (var i = newValue.selection.end - 1; i >= 0; i--) {
        if (mask[i] == maskSymbol) {
          digitsText = oldValue.text.replaceRange(i, i + 1, '').replaceAll(RegExp(r'[^\d]'), '');
          newSelection = TextSelection.collapsed(offset: i);
          break;
        }
      }
    }

    final maskedDigitsText = formatByMask(digitsText);

    if ((newValue.selection.start > maskedDigitsText.length) ||
        newValue.selection.start == newValue.text.length) {
      newSelection = TextSelection.collapsed(offset: maskedDigitsText.length);
    }

    return TextEditingValue(text: maskedDigitsText, selection: newSelection);
  }

  String formatByMask(String text) {
    int unmaskedIndex = 0;
    String maskedText = '';

    for (var i = 0; i < mask.length; i++) {
      try {
        if (mask[i] == maskSymbol) {
          maskedText += text[unmaskedIndex];
          unmaskedIndex++;
        } else if (unmaskedIndex != text.length) {
          if (mask[i] == text[unmaskedIndex]) {
            maskedText += text[unmaskedIndex];
            unmaskedIndex++;
          } else {
            maskedText += mask[i];
          }
        }
      } on RangeError {
        break;
      }
    }

    return maskedText;
  }
}
