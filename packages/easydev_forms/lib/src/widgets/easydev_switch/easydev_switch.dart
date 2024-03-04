import 'dart:io';

import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Switch that keeps boolean value. It's look can be changed by using different [pinType]
/// values. It can look like iOS style switch, Android style switch and neutral style switch.
/// Switch can be disabled so it will not interact when pressed, outlined switch, has no
/// background color, and have slightly different pin and track style.
///
/// Example of using [EasyDevSwitch] with children.
/// ```dart
/// EasyDevSwitch(
///   value: selected,
///   onSelect: (value) {
///     ...
///   },
///   pinType: PinType.ios,
///  ),
/// ```
///
/// Example of using [EasyDevSwitch.adaptive] fabric constructor.
/// ```dart
///  EasyDevSwitch.adaptive(
///   value: selected,
///   onSelect: (value) {
///    ...
///   },
///   outlined: true
///  ),
/// ```
///
///
/// This sample shows app with [EasyDevRadioButton].
///
/// See code in example/lib/pages/examples/switch_example.dart
///
/// See also:
///
///  * [EasyDevLabelWithSwitch], labeled radiobutton switch.
///  * [EasyDevRadioButton], radio button, usually used for selecting one value from set of values.
///  * [EasyDevCheckbox], checkbox widget.
class EasyDevSwitch extends StatelessWidget {
  /// Create a switch.
  const EasyDevSwitch({
    super.key,
    required this.value,
    required this.onSelect,
    this.height,
    this.width,
    this.selectedTrackColor,
    this.selectedKnobColor,
    this.unselectedTrackColor,
    this.unselectedKnobColor,
    this.disabledTrackColor,
    this.disabledKnobColor,
    this.pinType = PinType.neutral,
    this.disabled = false,
    this.padding,
    this.outlined = false,
  });

  /// Create a switch that styles itself according to current platform. For Android and Fuchsia it
  /// uses [PinType.android], for iOS and macOS it uses [PinType.ios], for other platforms it
  /// uses [PinType.neutral].
  factory EasyDevSwitch.adaptive({
    required bool value,
    required ValueChanged<bool> onSelect,
    Color? selectedTrackColor,
    Color? selectedKnobColor,
    Color? unselectedTrackColor,
    Color? unselectedKnobColor,
    Color? disabledTrackColor,
    Color? disabledKnobColor,
    bool disabled,
    EdgeInsets? padding,
    bool outlined,
  }) = _EasyDevSwitchAdaptive;

  /// Current state of the switch.
  final bool value;

  /// Action to be taken on switch tap.
  final ValueChanged<bool> onSelect;

  /// Height of the switch.
  final double? height;

  /// Width of the switch.
  final double? width;

  /// Color of the track when the switch is enabled and selected.
  final Color? selectedTrackColor;

  /// Color of the knob when the switch is enabled and selected.
  final Color? selectedKnobColor;

  /// Color of the track when the switch is enabled and not selected.
  final Color? unselectedTrackColor;

  /// Color of the knob when the switch is enabled and not selected.
  final Color? unselectedKnobColor;

  /// Color of the track when the switch is disabled.
  final Color? disabledTrackColor;

  /// Color of the knob when the switch is disabled.
  final Color? disabledKnobColor;

  /// Type of the switch pin. Could be [PinType.ios] to look like iOS and macOS style
  /// switch. [PinType.android] look like Material Design style switch. [PinType.neutral]
  /// just switch that is not referred to any design guidelines.
  final PinType pinType;

  /// Whether the switch is disabled.
  final bool disabled;

  /// Padding around the switch.
  final EdgeInsets? padding;

  /// Whether the switch is outlined.
  ///
  /// If it is true, the track color would be transparent
  /// even if it is set in constructor.
  final bool outlined;

  Color? _getTrackColor(EasyDevThemeData theme) {
    final themeBrightness = theme.brightness;

    if (outlined) return null;

    Color? trackColor;
    switch (pinType) {
      case PinType.ios:
        trackColor = _getIosTrackColor(theme);
        break;
      case PinType.android:
        trackColor = _getAndroidTrackColor(theme);
        break;
      case PinType.neutral:
        trackColor = _getNeutralTrackColor(theme);
        break;
    }
    return trackColor ?? themeBrightness.surfaceColor;
  }

  Color _getKnobColor(EasyDevThemeData theme) {
    final themeBrightness = theme.brightness;

    Color? knobColor;
    switch (pinType) {
      case PinType.ios:
        knobColor = _getIosKnobColor(theme);
        break;
      case PinType.android:
        knobColor = _getAndroidKnobColor(theme);
        break;
      case PinType.neutral:
        knobColor = _getNeutralKnobColor(theme);
        break;
    }
    return knobColor ?? themeBrightness.surfaceColor;
  }

  double _getStandardTrackHeight() {
    switch (pinType) {
      case PinType.ios:
        return 24;
      case PinType.android:
        return 24;
      case PinType.neutral:
        return 18;
    }
  }

  double _getTrackHeight(EasyDevThemeData theme) {
    return height ?? theme.switchTheme?.height ?? _getStandardTrackHeight();
  }

  double _getStandardTrackWidth() {
    switch (pinType) {
      case PinType.ios:
        return 40;
      case PinType.android:
        return 40;
      case PinType.neutral:
        return 44;
    }
  }

  double _getTrackWidth(EasyDevThemeData theme) {
    return width ?? theme.switchTheme?.width ?? _getStandardTrackWidth();
  }

  EdgeInsets _getTrackPadding(EasyDevThemeData theme) {
    switch (pinType) {
      case PinType.ios:
        return const EdgeInsets.all(0);
      case PinType.android:
        final border = _getBorder(theme);
        final borderWidth = border?.bottom.width ?? 0;
        return EdgeInsets.all(_getTrackHeight(theme) / 6 - borderWidth);
      case PinType.neutral:
        return const EdgeInsets.all(0);
    }
  }

  double _getKnobWidth(EasyDevThemeData theme) {
    switch (pinType) {
      case PinType.ios:
        final padding = _getTrackPadding(theme);
        final border = _getBorder(theme);
        final borderWidth = (border?.bottom.width ?? 0) + (border?.top.width ?? 0);
        return _getTrackHeight(theme) - padding.top - padding.bottom - borderWidth;
      case PinType.android:
        final padding = _getTrackPadding(theme);
        final border = _getBorder(theme);
        final borderWidth = (border?.bottom.width ?? 0) + (border?.top.width ?? 0);
        return _getTrackHeight(theme) - padding.top - padding.bottom - borderWidth;
      case PinType.neutral:
        return _getTrackWidth(theme) * 0.68;
    }
  }

  Border? _getBorder(EasyDevThemeData theme) {
    return outlined ? Border.all(width: 1, color: _getKnobColor(theme)) : null;
  }

  EdgeInsets _getSwitchPadding(EasyDevThemeData theme) {
    return padding ?? theme.switchTheme?.padding ?? EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    const animationDuration = Duration(milliseconds: 100);

    final knobAlignment = value ? Alignment.centerRight : Alignment.centerLeft;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (details) {
        if (disabled) return;
        onSelect(value);
      },
      child: Padding(
        padding: _getSwitchPadding(theme),
        child: AnimatedContainer(
          height: _getTrackHeight(theme),
          width: _getTrackWidth(theme),
          padding: _getTrackPadding(theme),
          decoration: BoxDecoration(
            color: _getTrackColor(theme),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: _getBorder(theme),
          ),
          alignment: knobAlignment,
          duration: animationDuration,
          child: AnimatedContainer(
            duration: animationDuration,
            width: _getKnobWidth(theme),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: _getKnobColor(theme),
            ),
          ),
        ),
      ),
    );
  }

  _getIosTrackColor(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    final themePalette = theme.colorPalette;
    final switchTheme = theme.switchTheme;

    if (disabled) {
      if (light) {
        return disabledTrackColor ??
            switchTheme?.disabledTrackColor ??
            themePalette.greySwatch.greyColor;
      }
      return disabledTrackColor ??
          switchTheme?.disabledTrackColor ??
          themePalette.greySwatch.tappedSurfaceColor;
    }
    if (value) {
      if (light) {
        return selectedTrackColor ??
            switchTheme?.selectedTrackColor ??
            themePalette.greySwatch.onSurfaceBright ??
            themePalette.greySwatch.onSurfaceColor;
      }
      return selectedTrackColor ??
          switchTheme?.selectedTrackColor ??
          themePalette.tertiarySwatch?[500] ??
          themePalette.tertiarySwatch;
    }
    return unselectedTrackColor ??
        switchTheme?.unselectedTrackColor ??
        themePalette.greySwatch.surfaceColor;
  }

  _getAndroidTrackColor(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    final themePalette = theme.colorPalette;
    final switchTheme = theme.switchTheme;

    if (disabled) {
      return disabledTrackColor ??
          switchTheme?.disabledTrackColor ??
          themePalette.greySwatch.tappedSurfaceColor ??
          themePalette.greySwatch.greyColor;
    }
    if (value) {
      if (light) {
        return selectedTrackColor ??
            switchTheme?.selectedTrackColor ??
            themePalette.secondarySwatch?[400] ??
            themePalette.secondarySwatch;
      }
      return selectedTrackColor ?? switchTheme?.selectedTrackColor ?? themePalette.secondarySwatch;
    }
    if (light) {
      return unselectedTrackColor ??
          switchTheme?.unselectedTrackColor ??
          themePalette.greySwatch.onSurfaceColor;
    }
    return unselectedTrackColor ??
        switchTheme?.unselectedTrackColor ??
        themePalette.greySwatch.greyColor;
  }

  _getNeutralTrackColor(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    final themePalette = theme.colorPalette;
    final switchTheme = theme.switchTheme;

    if (disabled) {
      if (light) {
        return disabledTrackColor ??
            switchTheme?.disabledTrackColor ??
            themePalette.greySwatch.greyColor;
      }
      return disabledTrackColor ??
          switchTheme?.disabledTrackColor ??
          themePalette.greySwatch.tappedSurfaceColor;
    }
    if (value) {
      if (light) {
        return selectedTrackColor ??
            switchTheme?.selectedTrackColor ??
            themePalette.greySwatch.onBackgroundColor ??
            themePalette.greySwatch.onSurfaceColor;
      }
      return selectedTrackColor ??
          switchTheme?.selectedTrackColor ??
          themePalette.secondarySwatch?[600] ??
          themePalette.secondarySwatch;
    }
    if (light) {
      return unselectedTrackColor ??
          switchTheme?.unselectedTrackColor ??
          themePalette.greySwatch.onSurfaceColor;
    }
    return unselectedTrackColor ??
        switchTheme?.unselectedTrackColor ??
        themePalette.greySwatch.surfaceColor;
  }

  _getIosKnobColor(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    final themePalette = theme.colorPalette;
    final switchTheme = theme.switchTheme;

    if (disabled) {
      if (light) {
        return disabledKnobColor ??
            switchTheme?.disabledKnobColor ??
            (outlined
                ? themePalette.greySwatch.greyColor
                : themePalette.greySwatch.tappedSurfaceColor);
      }
      return disabledKnobColor ??
          switchTheme?.disabledKnobColor ??
          (outlined
              ? themePalette.greySwatch.tappedSurfaceColor
              : themePalette.greySwatch.greyColor);
    }
    if (value) {
      if (outlined) {
        if (light) {
          return selectedKnobColor ??
              switchTheme?.selectedKnobColor ??
              themePalette.secondarySwatch?[400] ??
              themePalette.secondarySwatch ??
              themePalette.primarySwatch;
        }
        return selectedKnobColor ??
            switchTheme?.selectedKnobColor ??
            themePalette.secondarySwatch?[400];
      }
      if (light) {
        return selectedKnobColor ??
            switchTheme?.selectedKnobColor ??
            themePalette.secondarySwatch?[300] ??
            themePalette.secondarySwatch ??
            themePalette.primarySwatch;
      }
      return selectedKnobColor ??
          switchTheme?.selectedKnobColor ??
          themePalette.greySwatch.onSurfaceBright;
    }
    if (light) {
      return unselectedKnobColor ??
          switchTheme?.unselectedKnobColor ??
          (outlined
              ? themePalette.greySwatch.onSurfaceColor
              : themePalette.greySwatch.tappedSurfaceColor);
    }
    return unselectedKnobColor ??
        switchTheme?.unselectedKnobColor ??
        (outlined ? themePalette.greySwatch.greyColor : themePalette.greySwatch.dividerColor);
  }

  _getAndroidKnobColor(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    final themePalette = theme.colorPalette;
    final switchTheme = theme.switchTheme;

    if (disabled) {
      if (light) {
        return disabledKnobColor ??
            switchTheme?.disabledKnobColor ??
            (outlined
                ? themePalette.greySwatch.greyColor
                : themePalette.greySwatch.unselectedColor);
      }
      return disabledKnobColor ??
          switchTheme?.disabledKnobColor ??
          (outlined
              ? themePalette.greySwatch.tappedSurfaceColor
              : themePalette.greySwatch.surfaceColor);
    }
    if (value) {
      if (outlined) {
        return selectedKnobColor ??
            switchTheme?.selectedKnobColor ??
            themePalette.secondarySwatch?[400] ??
            themePalette.secondarySwatch;
      }
      if (light) {
        return selectedKnobColor ??
            switchTheme?.selectedKnobColor ??
            themePalette.greySwatch.surfaceColor;
      }
      return selectedKnobColor ??
          switchTheme?.selectedKnobColor ??
          themePalette.greySwatch.surfaceColor;
    }
    if (light) {
      return unselectedKnobColor ??
          switchTheme?.unselectedKnobColor ??
          (outlined
              ? themePalette.greySwatch.onSurfaceColor
              : themePalette.greySwatch.surfaceColor);
    }
    return unselectedKnobColor ??
        switchTheme?.unselectedKnobColor ??
        (outlined ? themePalette.greySwatch.greyColor : themePalette.greySwatch.surfaceColor);
  }

  _getNeutralKnobColor(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    final themePalette = theme.colorPalette;
    final switchTheme = theme.switchTheme;

    if (disabled) {
      if (light) {
        return disabledKnobColor ??
            switchTheme?.disabledKnobColor ??
            (outlined
                ? themePalette.greySwatch.greyColor
                : themePalette.greySwatch.tappedSurfaceColor);
      }
      return disabledKnobColor ??
          switchTheme?.disabledKnobColor ??
          (outlined
              ? themePalette.greySwatch.tappedSurfaceColor
              : themePalette.greySwatch.greyColor);
    }
    if (value) {
      if (outlined) {
        if (light) {
          return selectedKnobColor ??
              switchTheme?.selectedKnobColor ??
              themePalette.secondarySwatch?[400] ??
              themePalette.secondarySwatch ??
              themePalette.primarySwatch;
        }
        return selectedKnobColor ??
            switchTheme?.selectedKnobColor ??
            themePalette.secondarySwatch?[500] ??
            themePalette.secondarySwatch ??
            themePalette.primarySwatch;
      }
      if (light) {
        return selectedKnobColor ??
            switchTheme?.selectedKnobColor ??
            themePalette.secondarySwatch?[400] ??
            themePalette.secondarySwatch ??
            themePalette.primarySwatch;
      }
      return selectedKnobColor ??
          switchTheme?.selectedKnobColor ??
          themePalette.greySwatch.onBackgroundColor;
    }
    if (light) {
      return unselectedKnobColor ??
          switchTheme?.unselectedKnobColor ??
          (outlined
              ? themePalette.greySwatch.onSurfaceColor
              : themePalette.greySwatch.tappedSurfaceColor);
    }
    return unselectedKnobColor ??
        switchTheme?.unselectedKnobColor ??
        (outlined ? themePalette.greySwatch.greyColor : themePalette.greySwatch.onSurfaceBright);
  }
}

class _EasyDevSwitchAdaptive extends EasyDevSwitch {
  _EasyDevSwitchAdaptive({
    required super.value,
    required super.onSelect,
    super.selectedTrackColor,
    super.selectedKnobColor,
    super.unselectedTrackColor,
    super.unselectedKnobColor,
    super.disabledTrackColor,
    super.disabledKnobColor,
    super.disabled = false,
    super.padding,
    super.outlined = false,
  }) : super(pinType: _getPinType());

  static PinType _getPinType() {
    if (Platform.isAndroid || Platform.isFuchsia) return PinType.android;
    if (Platform.isIOS || Platform.isMacOS) return PinType.ios;
    return PinType.neutral;
  }
}
