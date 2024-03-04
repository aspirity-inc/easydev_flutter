import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatter tests', () {
    test('add separator on third index', () {
      expect(
        DateFormatter(startsFromYear: false, separator: '-', validateDate: (value) {})
            .formatEditUpdate(
          const TextEditingValue(
            text: '12',
            selection: TextSelection.collapsed(offset: 2),
          ),
          const TextEditingValue(
            text: '123',
            selection: TextSelection.collapsed(offset: 3),
          ),
        ),
        const TextEditingValue(
          text: '12-3',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );
    });

    test('add separator on fifth index', () {
      expect(
        DateFormatter(startsFromYear: false, separator: '-', validateDate: (value) {})
            .formatEditUpdate(
          const TextEditingValue(
            text: '12-34',
            selection: TextSelection.collapsed(offset: 5),
          ),
          const TextEditingValue(
            text: '12-345',
            selection: TextSelection.collapsed(offset: 6),
          ),
        ),
        const TextEditingValue(
          text: '12-34-5',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );
    });

    test('removing separator should fail', () {
      expect(
        DateFormatter(startsFromYear: false, separator: '-', validateDate: (value) {})
            .formatEditUpdate(
          const TextEditingValue(
            text: '12-34',
            selection: TextSelection.collapsed(offset: 3),
          ),
          const TextEditingValue(
            text: '1234',
            selection: TextSelection.collapsed(offset: 2),
          ),
        ),
        const TextEditingValue(
          text: '12-34',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );
    });

    test('removing digit before separator should move digits which placed after separator', () {
      expect(
        DateFormatter(startsFromYear: false, separator: '-', validateDate: (value) {})
            .formatEditUpdate(
          const TextEditingValue(
            text: '12-34',
            selection: TextSelection.collapsed(offset: 2),
          ),
          const TextEditingValue(
            text: '1-34',
            selection: TextSelection.collapsed(offset: 1),
          ),
        ),
        const TextEditingValue(
          text: '13-4',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );
    });

    test('removing last digit after separator should remove separator', () {
      expect(
        DateFormatter(startsFromYear: false, separator: '-', validateDate: (value) {})
            .formatEditUpdate(
          const TextEditingValue(
            text: '13-4',
            selection: TextSelection.collapsed(offset: 4),
          ),
          const TextEditingValue(
            text: '13-',
            selection: TextSelection.collapsed(offset: 3),
          ),
        ),
        const TextEditingValue(
          text: '13',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );
    });

    test('max length', () {
      expect(
        DateFormatter(startsFromYear: false, separator: '-', validateDate: (value) {})
            .formatEditUpdate(
          const TextEditingValue(
            text: '13-45-6789',
            selection: TextSelection.collapsed(offset: 10),
          ),
          const TextEditingValue(
            text: '13-45-67894',
            selection: TextSelection.collapsed(offset: 11),
          ),
        ),
        const TextEditingValue(
          text: '13-45-6789',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );
    });

    test('Unacceptable symbols', () {
      expect(
        DateFormatter(startsFromYear: false, separator: '-', validateDate: (value) {})
            .formatEditUpdate(
          const TextEditingValue(
            text: '13-45-67',
            selection: TextSelection.collapsed(offset: 8),
          ),
          const TextEditingValue(
            text: '13-45-67a',
            selection: TextSelection.collapsed(offset: 9),
          ),
        ),
        const TextEditingValue(
          text: '13-45-67',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );
    });
  });
}
