import 'package:easydev_theme/src/theme/dialog_background_mode.dart';
import 'package:flutter/painting.dart';

class EasyDevDatePickerDialogThemeData {
  const EasyDevDatePickerDialogThemeData({
    this.backgroundColor,
    this.outOfDialogColor,
    this.dialogBackgroundMode = DialogBackgroundMode.blur,
    this.selectedColor,
    this.actionColor,
    this.labelColor,
    this.pickerPadding,
    this.pickerMargin,
    this.dialogHeight,
  });

  final Color? backgroundColor;

  final Color? outOfDialogColor;

  final DialogBackgroundMode dialogBackgroundMode;

  final Color? selectedColor;

  final Color? actionColor;

  final Color? labelColor;

  final EdgeInsets? pickerPadding;

  final EdgeInsets? pickerMargin;

  final double? dialogHeight;

  @override
  bool operator ==(Object other) =>
      other is EasyDevDatePickerDialogThemeData &&
      backgroundColor == other.backgroundColor &&
      outOfDialogColor == other.outOfDialogColor &&
      dialogBackgroundMode == other.dialogBackgroundMode &&
      selectedColor == other.selectedColor &&
      actionColor == other.actionColor &&
      labelColor == other.labelColor &&
      pickerPadding == other.pickerPadding &&
      pickerMargin == other.pickerMargin &&
      dialogHeight == other.dialogHeight;

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        outOfDialogColor,
        dialogBackgroundMode,
        selectedColor,
        actionColor,
        labelColor,
        pickerPadding,
        pickerMargin,
        dialogHeight,
      );

  EasyDevDatePickerDialogThemeData copyWith({
    Color? backgroundColor,
    Color? outOfDialogColor,
    DialogBackgroundMode? dialogBackgroundMode,
    Color? selectedColor,
    Color? actionColor,
    Color? labelColor,
    EdgeInsets? pickerPadding,
    EdgeInsets? pickerMargin,
    double? dialogHeight,
  }) =>
      EasyDevDatePickerDialogThemeData(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        outOfDialogColor: outOfDialogColor ?? this.outOfDialogColor,
        dialogBackgroundMode: dialogBackgroundMode ?? this.dialogBackgroundMode,
        selectedColor: selectedColor ?? this.selectedColor,
        actionColor: actionColor ?? this.actionColor,
        labelColor: labelColor ?? this.labelColor,
        pickerPadding: pickerPadding ?? this.pickerPadding,
        pickerMargin: pickerMargin ?? this.pickerMargin,
        dialogHeight: dialogHeight ?? this.dialogHeight,
      );
}
