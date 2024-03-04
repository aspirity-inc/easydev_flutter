# easydev_forms

---

This package containts widgets for entering information in application that use EasyDev UI Kit.

This package includes checkboxes, radio buttons, switches, select, multiselect, sliders, range sliders, code and number inputs, date picker, date range picker, date input and date range input.

## Installation

---

To use this package, add easydev_forms as a dependency in your pubspec.yaml file.

## Usage

---

Import package into your code:

```
import "package:easydev_forms/easydev_forms.dart";
```

Note that all of widgets of this package must be wrapped in `EasyDevTheme`. You can provide theme manually using `EasyDevTheme` (from easydev_theme package), `Theme` or `CupertinoTheme` or wrap it with widgets, which provide theme automatically such as `EasyDevApp` (from easydev_basics), `MaterialApp` or `CupertinoApp`.

#### Basics

---

##### EasyDevCheckbox

![Screen 1](https://i.ibb.co/ZzCcbWL/checkbox.png)

Checkboxes allow users to make selections from multiple options simultaneously, providing a convenient way to indicate preferences, choices, or actions to be taken. `EasyDevCheckbox` requires `selected`, `onSelect` and `value` properties. `selected` shows whether checkbox is selected, `onSelect` provides a callback for tapping and `value` is used for representing value in `EasyDevCheckbox`. Other fields can be used to customize appearance of `EasyDevCheckbox`.

```
...
List<int> selectedCheckboxValues = [];
final int checkbox1Value = 1;
...
EasyDevCheckbox(
  selected: selectedCheckboxValues.contains(widget.checkbox1Value),
  onSelect: (value) {
    setState(() {
      if (selectedCheckboxValues.contains(value)) {
        selectedCheckboxValues.remove(value);
      } else {
        selectedCheckboxValues.add(value);
      }
    });
  },
  value: widget.checkbox1Value,
),
```

##### EasyDevRadioButton

![Screen 2](https://i.ibb.co/52gQ2r7/radio.png)

Radio buttons is used for enabling users to make mutually exclusive selections from a set of options. `EasyDevRadioButton` requires `selected`, `onSelect` and `value` properties. `selected` shows whether radio button is selected, `onSelect` provides a callback for tapping and `value` is used for representing value in `EasyDevRadioButton`. Other fields can be used to customize appearance of `EasyDevRadioButton`.

```
...
final int radio1Value = 1;
int? selectedRadioValue;
...
EasyDevRadioButton(
  selected: selectedRadioValue == widget.radio1Value,
  radioType: RadioType.classic,
  onSelect: (value) => setState(
      () => selectedRadioValue = selectedRadioValue == value ? null : value),
  value: widget.radio1Value,
),
```

##### EasyDevSwitch

![Screen 3](https://i.ibb.co/6m3sH5L/switch.png)

Switches offer a convenient way for users to toggle between two states, such as turning a feature on or off. `EasyDevSwitch` requires `value` and `onSelect` properties. `value` represents current state of `EasyDevSwitch` and `onSelect` provides a callback for tapping. Other fields can be used to customize appearance of `EasyDevSwitch`.
To create switch that adapts to current platform you can use `EasyDevSwitch.adaptive`.

```
...
bool switchValue = false;
...
EasyDevSwitch(
  value: switchValue,
  onSelect: (value) {
    setState(() {
      switchValue = !value;
    });
  },
),
```

##### EasyDevSelect

![Screen 4](https://i.ibb.co/5X3HjST/Screenshot-1707890595.png)

![Screen 5](https://i.ibb.co/F6wXNyT/Screenshot-1707890621.png)

Select widgets allow users to choose from a predefined list of options, streamlining data entry and minimizing errors. `EasyDevSelect` requires `selectedValue`, `values`, `onSelected` and `hint` properties. `selectedValue` represents selected value. `values` is a list of `EasyDevSelectItem` that are shown for user. `onSelected` provides a callback for selecting a value. `hint` is shown in select when `selectedValue` is null.

`withBottomSheet` provides an opportunity to chose options displaying type: `OverlayEntry` or `EasyDevBottomSheet`. Other fields can be used to customize appearance of `EasyDevSelect`.

```
...
int? value;
...
EasyDevSelect<int>(
  withBottomSheet: true,
  selectedValue: value,
  values: List.generate(
    20,
    (index) => EasyDevSelectItem(
        value: index,
      name: 'Option ${index + 1}',
      enabled: index < 15,
    ),
  ),
  onSelected: (newValue) {
    setState(() {
      value = newValue;
    });
  },
  hint: 'Select option',
),
```

##### EasyDevMultiSelect

![Screen 6](https://i.ibb.co/M95t1VC/Screenshot-1707891459.png)

![Screen 7](https://i.ibb.co/mSdgCWn/Screenshot-1707891416.png)

![Screen 8](https://i.ibb.co/zQXWm48/Screenshot-1707891424.png)

Multi-select widgets enable users to efficiently choose multiple options from a list, facilitating the selection of diverse or overlapping preferences or categories. `EasyDevMultiSelect` requires `selectedValues`, `items` and `valuesChanged` properties. `selectedValues` represents selected values of widget, `items` is a list of `EasyDevMultiselectItem` that are shown for user, `valuesChanged` provides a callback for changing values.

`withBottomSheet` provides an opportunity to chose options displaying type: `OverlayEntry` or `EasyDevBottomSheet`. Other fields can be used to customize appearance of `EasyDevMultiSelect`.

```
...
List<int> selectedValues = [];
...
EasyDevMultipleSelect<int>(
  maxHeight: 400,
  selectedValues: selectedValues,
  items: List.generate(
    20,
    (index) => EasyDevMultiselectItem(
      value: index,
      name: 'Option ${index + 1}',
      enabled: index < 15,
    ),
  ),
  valuesChanged: (newValue) {
    setState(() {
      selectedValues = newValue;
    });
  },
  hint: 'Select option',
),
```

##### EasyDevSlider

![Screen 9](https://i.ibb.co/mTP3NcQ/2024-02-14-13-26-05.png)

![Screen 10](https://i.ibb.co/dWgr7Mk/2024-02-14-13-25-49.png)

![Screen 11](https://i.ibb.co/1vD7tMk/2024-02-14-13-25-35.png)

Sliders provide an intuitive and interactive way for users to adjust numeric values within a defined range. `EasyDevSlider` requires `value` and `onChanged` properties. `value` represents current numeric value of the slider, `onChanged` provides a callback for changing `value`.

Other useful properties:

- `title` represents title above the slider in left corner.
- `showLabel` shows whether to show a value above the slider in right corner.
- `showInput` shows whether to show an input for slider.
- `inputPosition` determines a position of input if `showInput` is true. There are three position options: `SliderInputPosition.top`, `SliderInputPosition.right` and `SliderInputPosition.bottom`.
- `formatValue` is a function showing what text should be displayed on the tooltip, on the label and in the inputs.
- `min` and `max` determines minimun and maximum values of slider. Defaults to 0 and 1.
- `showButtons` shows whether to show plus and minus buttons on edges of a slider.
- `buttonStepAmount` determines a value that will be added or substracted from current value when button is tapped. Defaults to 0.1.
- `showTooltip` shows whether to show a tooltip.
- `showEdgeValues` shows whether to show min and max values on edges of the slider.
- `divisions`, if this field is not equal to null, than slider will be divided on `divisions` equal parts.

Other fields can be used to customize appearance of `EasyDevSlider`.

```
...
double _sliderValue = 0.5;
...
EasyDevSlider(
  title: 'Title',
  showLabel: true,
  showInput: true,
  inputPosition: SliderInputPosition.right,
  value: _sliderValue,
  onChanged: (double value) {
    setState(() {
      _sliderValue = value;
    });
  },
),
```

##### EasyDevRangeSlider

![Screen 12](https://i.ibb.co/chYVMKP/2024-02-14-13-51-39.png)

![Screen 13](https://i.ibb.co/fHjXJNF/2024-02-14-13-51-30.png)

Range sliders offer users the ability to select a range of values within a specified interval, enabling precise control over numeric input. `EasyDevRangeSlider` requires `value` and `onChanged` properties. `value` represents current value of type `RangeValue` which has numeric `start` and `end` values, `onChanged` provides a callback for changing `value`.

Most other fields are the same as in the `EasyDevSlider` and they were described in the previous section. New field is `minimalRange`, that shows minimal range between `value.start` and `value.end`.

```
...
RangeValue _sliderRangeValue = const RangeValue(0, 1);
...
EasyDevRangeSlider(
  value: _sliderRangeValue,
  title: 'Title',
  showInput: true,
  inputPosition: SliderInputPosition.top,
  onChanged: (RangeValue value) {
    setState(() {
      _sliderRangeValue = value;
    });
  },
),
```

##### Code input

![Screen 14](https://i.ibb.co/P94vSMM/2024-02-14-14-02-00.png)

![Screen 15](https://i.ibb.co/k8Zq2FP/2024-02-14-14-02-14.png)

`EnterCodeWithKeyboard` is used to simplify inputing different code such as PIN codes or OTP codes. `EnterCodeWithKeyboard` requires `value` and `valueChanged` properties. `value` represents current string value of input, `valueChanged` provides a callback for changing `value`.

`EnterCodeState` enum provides ability to change `EnterCodeField` of `EnterCodeWithKeyboard` to different states with their customization:

- `EnterCodeState.enabled` allows entering code.
- `EnterCodeState.loading` shows loading indicator and `loadingHint`.
- `EnterCodeState.success` shows success icon and `successHint`.
- `EnterCodeState.failure` shows failure icon and `errorHint`.

You can use built-in timer functionality using `needTimer` to show it, and `timerText`, `timerButtonText`, `onTimerButtonPressed` to customize it.

```
...
// Code input that successfully loads
EnterCodeState? successState;
var successValue = '';
...
successState != null
    ? EnterCodeWithKeyboard(
        value: successValue,
        title: 'Enter code from message',
        valueChanged: (newValue) async {
          if (newValue.length == 4) {
            setState(() {
              successState = EnterCodeState.loading;
              successValue = newValue;
            });
            await Future.delayed(
              const Duration(seconds: 2),
            );
            setState(() {
              successState = EnterCodeState.success;
            });
            await Future.delayed(
              const Duration(seconds: 2),
            );
            setState(() {
              successState = null;
              successValue = '';
            });
          } else {
            setState(() {
              successValue = newValue;
            });
          }
        },
        state: successState!)
    : CodeInputButton(
        onTap: () {
          setState(() {
            successState = EnterCodeState.enabled;
          });
        },
        text: 'Change PIN code',
      ),
```

##### EasyDevInputNumber

![Screen 16](https://i.ibb.co/VLrfxtd/2024-02-14-15-25-43.png)

`EasyDevInputNumber` provides a simple widget for entering a number. `EasyDevInputNumber` requires `valueChanged` callback for pressing change buttons.

```
EasyDevInputNumber(
  initialValue: 0,
  maxValue: 5,
  valueChanged: (int value) {},
),
```

##### EasyDevDatePicker

![Screen 17](https://i.ibb.co/tcxjrHb/2024-02-14-15-32-30.png)

![Screen 18](https://i.ibb.co/TMQ88HD/2024-02-14-15-32-44.png)

![Screen 19](https://i.ibb.co/QM9PdTP/2024-02-14-15-32-55.png)

Date pickers provide users with an intuitive interface to select dates, ensuring accurate input and minimizing errors in date-related tasks.

`EasyDevDatePicker` fields:

- `startDate`, minimal date available in date picker.
- `endDate`, maximal date available in date picker.
- `onOkTap`, callback for tapping on OK button.
- `onCancelTap`, callback for tapping on CANCEL button.
- `locale`, locale for displayning dates.
- `onDateSelected`, callback for selecting a date.
- `initialDate`, initially selected date in date picker.
- `formatWeekday` and `formatMonth`, functions for formatting weekdays labels and months labels.
- `showDisabledDays`, boolean that shows whether to show days that not included in currently displayed month.
- `decoration`, `DatePickerDecoration`, where you can change text styles and colors of date picker.

```
EasyDevDatePicker(
  endDate: DateTime(2050),
  initialDate: DateTime(2023),
  startDate: DateTime(1800),
  onCancelTap: () {},
  onOkTap: ((value) {}),
),
```

##### EasyDevDateRangePicker

![Screen 20](https://i.ibb.co/5G9CLWf/2024-02-14-15-49-24.png)

Date range pickers provide users with an intuitive interface to select range of dates, ensuring accurate input and minimizing errors in date-related tasks.

`EasyDevDateRangePicker` is mostly similar to `EasyDevDatePicker` that was described in previous section. It differs in using `DateRange` that has date `start` and date `end` instead of `DateTime`.

```
EasyDevDateRangePicker(
  endDate: DateTime(2024, 12),
  startDate: DateTime(1800),
  initialDateRange: DateRange(start: DateTime(2024, 02, 10), end: DateTime(2024, 02, 20)),
  onSelectTap: (value) {},
),
```

##### EasyDevDateInput and EasyDevDateRangeInput

![Screen 21](https://i.ibb.co/Pm2n0SB/2024-02-14-15-58-39.png)

![Screen 22](https://i.ibb.co/tC77DBy/2024-02-14-15-59-27.png)

These are built-in input that can be used for entering dates. They provide formatting and validation for the entered dates. You can use `dateFormat` to provide format of dates. Also you can use `separator` to provide symbol that will divide days, months and years.

```
EasyDevDateInput(
  valueChanged: (String value) {},
  label: 'Date of birth',
  separator: '-',
  dateFormat: DateInputFormat.yyyyddMM(),
),
```

```
EasyDevDateRangeInput(
  startValueChanged: (String value) {},
  endValueChanged: (String value) {},
  startLabel: 'Start date',
  endLabel: 'End date',
),
```
