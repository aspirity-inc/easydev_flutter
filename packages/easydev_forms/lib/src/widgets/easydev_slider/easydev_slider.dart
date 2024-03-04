import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'handle_painter.dart';
import 'package:easydev_forms/src/widgets/easydev_slider/slider_input.dart';
import 'package:easydev_forms/src/widgets/easydev_slider/tooltip_painter.dart';
import 'package:easydev_forms/src/widgets/easydev_slider/track_painter.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

/// [EasyDevSlider] is slider that can return position between minimum and maximum values
/// depending on handle position. If [showButtons] is true, slider will have some buttons,
/// that return value with [buttonStepAmount] added, but not exceeding [min] and [max] values.
/// Slider with input can have [EasyDevTextField] input, so user can enter value manually.
/// Slider with [divisions] provided only return discrete set of values. Divisions
/// split difference in min and max value with by itself. For example: if we provide
/// divisions equal 5 with min equal 0 and max equal 10, divisions will be 0,2,4,6,8,10.
/// [showTooltip] property shows tooltip of selected value.
///
/// Example of using [EasyDevSlider] with input and label and buttons.
/// ```dart
/// EasyDevSlider(
///    title: 'Title',
///    showLabel: true,
///    showInput: true,
///    inputPosition: SliderInputPosition.right,
///    value: value,
///    onChanged: (double value) {
///    ...
///    },
/// ),
/// ```
///
/// Default slider
/// ```dart
/// EasyDevSlider(
///    showButtons: false,
///    value: value,
///    onChanged: (double value) {
///    ...
///    },
/// ),
/// ```
///
/// [inputPosition] defines position of input. When it is equal to [SliderInputPosition.top],
/// input is positioned on top of slider, and below label, if it is equal
/// to [SliderInputPosition.bottom] it is positioned below slider, if [inputPosition] is
/// [SliderInputPosition.right] it is positioned right of slider.
/// [title] is positioned on top of slider, providing way to express what value is selected.
/// Handle is object that is dragged by user to select a value.
/// Tooltip is shown on top of handle, with currently selected value.
/// Track is line where slider alongside that handle is dragged.
/// [selectedTrackColor] color of track from start of a track and before handle.
/// [unselectedTrackColor] color of track after handle to end of a track.
/// [showEdgeValues] representing [min] and [max] values in slider on edges of slider track.
///
/// This sample shows app with [EasyDevSlider].
///
/// See code in example/lib/pages/examples/slider_example.dart
///
/// See also:
///
///  * [EasyDevRangeSlider], slider for picking range values.
class EasyDevSlider extends StatefulWidget {
  /// Create a slider.
  const EasyDevSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
    this.showLabel = false,
    this.showInput = false,
    this.inputPosition = SliderInputPosition.bottom,
    this.formatValue,
    this.min = 0,
    this.max = 1,
    this.buttonStepAmount = 0.1,
    this.divisions,
    this.handleColor,
    this.selectedTrackColor,
    this.unselectedTrackColor,
    this.tooltipColor,
    this.buttonsColor,
    this.disabledColor,
    this.tooltipTextColor,
    this.showEdgeValues,
    this.showTooltip,
    this.showButtons,
    this.padding,
    this.buttonSpacing,
    this.buttonSize,
    this.sliderTrackThickness,
    this.sliderHandleSize,
    this.sliderHandleWidth,
  })  : assert(min <= max),
        assert(value >= min && value <= max,
            'Value $value is not between minimum $min and maximum $max'),
        assert(divisions == null || divisions > 0);

  /// Current value of slider. Cannot be less than [min] and more that [max].
  final double value;

  /// Callback that will run when value changes.
  final ValueChanged<double> onChanged;

  /// Title of slider. Title is positioned on top of track.
  final String? title;

  /// Show label left to title, label is formatted value, which can be changed
  /// by providing [formatValue] callback.
  final bool showLabel;

  /// Show input for slider. Input is [EasyDevTextFormField], with decorations. It's position
  /// depends on [inputPosition].
  final bool showInput;

  /// Position of input relative to slider.  When it is equal to [SliderInputPosition.top],
  /// input is positioned on top of slider, and below label, if it is equal
  /// to [SliderInputPosition.bottom] it is positioned below slider, if [inputPosition] is
  /// [SliderInputPosition.right] it is positioned right of slider.
  final SliderInputPosition inputPosition;

  /// Minimum value, should be less than [max] value.
  final double min;

  /// Maximum value, should be more than [min] value.
  final double max;

  /// The amount by which the value changes when the side buttons are pressed.
  final double buttonStepAmount;

  /// The number of discrete parts the slider is divided into
  final int? divisions;

  /// Slider handle color.
  final Color? handleColor;

  /// Slider track color of selected part.
  final Color? selectedTrackColor;

  /// Slider track color of not selected part.
  final Color? unselectedTrackColor;

  /// Side buttons color.
  final Color? buttonsColor;

  /// Disabled side buttons color.
  final Color? disabledColor;

  /// Tooltip color.
  final Color? tooltipColor;

  /// Tooltip text color.
  final Color? tooltipTextColor;

  /// Function showing what text should be displayed on the tooltip, on the label and in the inputs.
  final String Function(double)? formatValue;

  /// Show maximum and minimum value on horizontal edges of track.
  final bool? showEdgeValues;

  /// If true, shows tooltip with value on top of slider handle.
  final bool? showTooltip;

  /// Shows buttons that changes value by [buttonStepAmount]. Left button is subtracting
  /// [buttonStepAmount] from value until it reaches [min]. Right button is adding
  /// [buttonStepAmount] to value until it reaches [max]
  final bool? showButtons;

  /// Slider padding.
  final EdgeInsets? padding;

  /// Spacing between edge buttons and slider.
  final double? buttonSpacing;

  /// Edge buttons size.
  final double? buttonSize;

  /// Slider track thickness.
  final double? sliderTrackThickness;

  /// Slider handle size.
  final double? sliderHandleSize;

  /// Slider handle width.
  final double? sliderHandleWidth;

  @override
  State<EasyDevSlider> createState() => _EasyDevSliderState();
}

class _EasyDevSliderState extends State<EasyDevSlider> {
  late Color? _handleColor;
  late Color? _selectedTrackColor;
  late Color? _unselectedTrackColor;
  late Color? _buttonsColor;
  late Color? _disabledColor;
  late Color? _tooltipColor;
  late Color? _tooltipTextColor;
  late bool _showEdgeValues;
  late bool _showTooltip;
  late bool _showButtons;
  late EdgeInsets _padding;
  late double _buttonSpacing;
  late double _buttonSize;
  late double _sliderTrackThickness;
  late double _sliderHandleSize;
  late double _sliderHandleWidth;
  late TextStyle? _sliderTextStyle;
  late TextStyle? _tooltipTextStyle;
  late TextStyle? _titleTextStyle;
  late TextStyle? _labelTextStyle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setAndUpdateFields();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    setAndUpdateFields();
  }

  void setAndUpdateFields() {
    final theme = EasyDevTheme.of(context);
    final sliderTheme = theme.sliderTheme;

    _handleColor = widget.handleColor ??
        sliderTheme?.handleColor ??
        theme.colorPalette.greySwatch.backgroundColor;
    _selectedTrackColor = widget.selectedTrackColor ??
        sliderTheme?.selectedTrackColor ??
        (theme.brightness == Brightness.light
            ? (theme.colorPalette.secondarySwatch?[200] ?? theme.colorPalette.secondarySwatch)
            : theme.colorPalette.tertiarySwatch);
    _unselectedTrackColor = widget.unselectedTrackColor ??
        sliderTheme?.unselectedTrackColor ??
        theme.colorPalette.greySwatch.disabledColor;
    _buttonsColor = widget.buttonsColor ??
        sliderTheme?.buttonsColor ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.greySwatch.onSurfaceColor
            : theme.colorPalette.secondarySwatch?[50]);
    _disabledColor = widget.disabledColor ??
        sliderTheme?.disabledColor ??
        theme.colorPalette.greySwatch.tappedSurfaceColor;
    _tooltipColor = widget.tooltipColor ??
        sliderTheme?.tooltipColor ??
        (theme.brightness == Brightness.light
            ? (theme.colorPalette.secondarySwatch?[200] ?? theme.colorPalette.secondarySwatch)
            : theme.colorPalette.greySwatch.onPrimary);
    _tooltipTextColor = widget.tooltipTextColor ??
        sliderTheme?.tooltipTextColor ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.greySwatch.onSurfaceBright
            : theme.colorPalette.primarySwatch[500]);
    _showEdgeValues = widget.showEdgeValues ?? sliderTheme?.showEdgeValues ?? true;
    _showTooltip = widget.showTooltip ?? sliderTheme?.showTooltip ?? true;
    _showButtons = widget.showButtons ?? sliderTheme?.showButtons ?? true;
    _padding = widget.padding ?? sliderTheme?.padding ?? const EdgeInsets.all(8);
    _buttonSpacing = widget.buttonSpacing ?? sliderTheme?.buttonSpacing ?? 12;
    _buttonSize = widget.buttonSize ?? sliderTheme?.buttonSize ?? 20;
    _sliderTrackThickness = widget.sliderTrackThickness ?? sliderTheme?.sliderTrackThickness ?? 4;
    _sliderHandleSize = widget.sliderHandleSize ?? sliderTheme?.sliderHandleSize ?? 20;
    _sliderHandleWidth = widget.sliderHandleWidth ?? sliderTheme?.sliderHandleWidth ?? 4;
    _sliderTextStyle = theme.typography?.captionStyle;
    _tooltipTextStyle = theme.typography?.tooltipStyle;
    _titleTextStyle = theme.typography?.body2Style;
    _labelTextStyle = theme.typography?.subheading2Style;
  }

  var _tooltipVisible = false;
  late double _value;
  InputState inputState = InputState.enabled;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _controller.text = _formatValue(_value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    final sliderInput = SliderInput(
      controller: _controller,
      min: widget.min,
      max: widget.max,
      onChanged: (value) {
        if (value != null) {
          widget.onChanged(widget.divisions != null ? _getClosestDiscreteValue(value) : value);
        }
      },
    );

    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null || widget.showLabel) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title ?? '',
                  style: _titleTextStyle,
                ),
                Text(
                  _formatValue(widget.value),
                  style: _labelTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
          if (widget.showInput && widget.inputPosition == SliderInputPosition.top) ...[
            sliderInput,
            const SizedBox(
              height: 10,
            ),
          ],
          if (_showTooltip)
            Row(
              children: [
                if (_showButtons)
                  SizedBox(
                    width: _buttonSpacing + _buttonSize,
                  ),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    var span = TextSpan(
                      text: _formatValue(widget.value),
                      style: _tooltipTextStyle?.copyWith(
                        color: _tooltipTextColor,
                      ),
                    );
                    final textPainter = TextPainter(
                      text: span,
                      maxLines: 1,
                      textScaler: MediaQuery.of(context).textScaler,
                      textDirection: TextDirection.ltr,
                    )..layout();
                    return SizedBox(
                      height: 35 + textPainter.height,
                      child: _tooltipVisible
                          ? CustomPaint(
                              painter: TooltipPainter(
                                value: widget.value,
                                min: widget.min,
                                max: widget.max,
                                sliderHandleRadius: _sliderHandleSize / 2,
                                textPainter: textPainter,
                                tooltipColor: _tooltipColor ??
                                    theme.colorPalette.secondarySwatch?[200] ??
                                    theme.colorPalette.secondarySwatch ??
                                    theme.colorPalette.primarySwatch,
                              ),
                            )
                          : Container(),
                    );
                  }),
                ),
                if (_showButtons)
                  SizedBox(
                    width: _buttonSpacing + _buttonSize,
                  ),
                if (widget.showInput && widget.inputPosition == SliderInputPosition.right)
                  const SizedBox(
                    width: 96,
                  )
              ],
            ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    if (_showEdgeValues)
                      const SizedBox(
                        height: 10,
                      ),
                    Row(
                      children: [
                        if (_showButtons)
                          GestureDetector(
                            onTap: () => widget.divisions == null
                                ? _handleButtonTap(widget.value - widget.buttonStepAmount)
                                : _handleMinusTapWithDivisions(),
                            child: Icon(
                              CommunityMaterialIcons.minus_circle,
                              size: _buttonSize,
                              color: _roundValue(widget.value) == widget.min
                                  ? _disabledColor
                                  : _buttonsColor,
                            ),
                          ),
                        if (_showButtons)
                          SizedBox(
                            width: _buttonSpacing,
                          ),
                        Expanded(
                          child: GestureDetector(
                            child: SizedBox(
                              height: _sliderHandleSize > _sliderTrackThickness
                                  ? _sliderHandleSize + 1
                                  : _sliderTrackThickness + 1,
                              child: CustomPaint(
                                painter: TrackPainter(
                                  value: widget.value,
                                  max: widget.max,
                                  min: widget.min,
                                  sliderTrackThickness: _sliderTrackThickness,
                                  sliderHandleRadius: _sliderHandleSize / 2,
                                  unselectedTrackColor: _unselectedTrackColor ??
                                      theme.colorPalette.greySwatch.greyColor,
                                  selectedTrackColor: _selectedTrackColor ??
                                      theme.colorPalette.secondarySwatch?[400] ??
                                      theme.colorPalette.secondarySwatch ??
                                      theme.colorPalette.primarySwatch,
                                  divisions: widget.divisions,
                                ),
                                child: CustomPaint(
                                  painter: HandlePainter(
                                    value: widget.value,
                                    max: widget.max,
                                    min: widget.min,
                                    sliderHandleRadius: _sliderHandleSize / 2,
                                    sliderHandleWidth: _sliderHandleWidth,
                                    handleColor:
                                        _handleColor ?? theme.colorPalette.greySwatch.greyColor,
                                    selectedTrackColor: _selectedTrackColor ??
                                        theme.colorPalette.secondarySwatch?[400] ??
                                        theme.colorPalette.secondarySwatch ??
                                        theme.colorPalette.primarySwatch,
                                    divisions: widget.divisions,
                                  ),
                                ),
                              ),
                            ),
                            onHorizontalDragUpdate: (details) => _onDragUpdate(context, details),
                            onHorizontalDragStart: (details) => _onDragStart(context, details),
                            onHorizontalDragEnd: (details) => _hideTooltip(),
                            onVerticalDragEnd: (details) => _hideTooltip(),
                            onTapUp: (details) => _hideTooltip(),
                            onTapDown: (details) => _onTapDown(details),
                          ),
                        ),
                        if (_showButtons)
                          SizedBox(
                            width: _buttonSpacing,
                          ),
                        if (_showButtons)
                          GestureDetector(
                            onTap: () => widget.divisions == null
                                ? _handleButtonTap(widget.value + widget.buttonStepAmount)
                                : _handlePlusTapWithDivisions(),
                            child: Icon(
                              CommunityMaterialIcons.plus_circle,
                              size: _buttonSize,
                              color: _roundValue(widget.value) == widget.max
                                  ? _disabledColor
                                  : _buttonsColor,
                            ),
                          ),
                      ],
                    ),
                    if (_showEdgeValues)
                      Row(
                        children: [
                          if (_showButtons)
                            SizedBox(
                              width: _buttonSpacing + _buttonSize,
                            ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _formatNumber(widget.min),
                                    style: _sliderTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  _formatNumber(widget.max),
                                  style: _sliderTextStyle,
                                ),
                              ],
                            ),
                          ),
                          if (_showButtons) SizedBox(width: _buttonSpacing + _buttonSize),
                        ],
                      ),
                  ],
                ),
              ),
              if (widget.showInput && widget.inputPosition == SliderInputPosition.right) ...[
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: 80,
                  child: sliderInput,
                ),
              ],
            ],
          ),
          if (widget.showInput && widget.inputPosition == SliderInputPosition.bottom) ...[
            const SizedBox(
              height: 10,
            ),
            sliderInput,
          ],
        ],
      ),
    );
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails details) {
    if (widget.divisions != null) {
      widget.onChanged(_getClosestDiscreteValue(_value));
      setState(() {
        _value = _getClosestDiscreteValue(_value);
      });
    }
    RenderBox box = context.findRenderObject() as RenderBox;
    final edgeButtonsSize = _showButtons ? 2 * _buttonSize + 2 * _buttonSpacing : 0;
    final edgeInputSize =
        widget.showInput && widget.inputPosition == SliderInputPosition.right ? 96 : 0;
    double width =
        box.constraints.maxWidth - _padding.right - _padding.left - edgeButtonsSize - edgeInputSize;
    _updateValue(details.localPosition, width);
  }

  void _onDragStart(BuildContext context, DragStartDetails details) {
    if (widget.divisions != null) {
      widget.onChanged(_getClosestDiscreteValue(_value));
      setState(() {
        _value = _getClosestDiscreteValue(_value);
      });
    }
    setState(() {
      _tooltipVisible = true;
    });

    RenderBox box = context.findRenderObject() as RenderBox;
    final edgeButtonsSize = _showButtons ? 2 * _buttonSize + 2 * _buttonSpacing : 0;
    final edgeInputSize =
        widget.showInput && widget.inputPosition == SliderInputPosition.right ? 96 : 0;
    double width =
        box.constraints.maxWidth - _padding.right - _padding.left - edgeButtonsSize - edgeInputSize;

    _updateValue(details.localPosition, width);
  }

  void _hideTooltip() {
    setState(() {
      _tooltipVisible = false;
    });
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.divisions != null) {
      widget.onChanged(_getClosestDiscreteValue(_value));
      setState(() {
        _value = _getClosestDiscreteValue(_value);
      });
    }
    setState(() {
      _tooltipVisible = true;
    });
  }

  void _updateValue(Offset offset, double width) {
    if (offset.dx <= 0) {
      widget.onChanged(widget.min);
      _controller.text = _formatValue(widget.min);
    } else if (offset.dx >= width) {
      widget.onChanged(widget.max);
      _controller.text = _formatValue(widget.max);
    } else {
      final curValue = widget.min + offset.dx * (widget.max - widget.min) / width;
      if (widget.divisions != null) {
        widget.onChanged(
          _getClosestDiscreteValue(curValue),
        );
        setState(() {
          _value = _getClosestDiscreteValue(curValue);
        });
        _controller.text = _formatValue(_getClosestDiscreteValue(curValue));
      } else {
        widget.onChanged(curValue);
        _controller.text = _formatValue(curValue);
      }
    }
  }

  String _formatNumber(double n) {
    return n
        .toString()
        // Removes insignificant zeros and point if not needed (from 10.0 to 10 or from 10.00100 to 10.001)
        .replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '')
        // Formats number to separate digits in triplets (from 10000000 to 10 000 000)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
  }

  void _handleButtonTap(double newValue) {
    if (newValue <= widget.min) {
      widget.onChanged(widget.min);
      _controller.text = _formatValue(widget.min);
    } else if (newValue >= widget.max) {
      widget.onChanged(widget.max);
      _controller.text = _formatValue(widget.max);
    } else {
      widget.onChanged(newValue);
      _controller.text = _formatValue(newValue);
    }
  }

  void _handlePlusTapWithDivisions() {
    widget.onChanged(_getClosestDiscreteValue(_value + _discreteStep));
    setState(() {
      _value = _getClosestDiscreteValue(_value + _discreteStep);
    });
    _controller.text = _formatValue(_value);
  }

  void _handleMinusTapWithDivisions() {
    widget.onChanged(_getClosestDiscreteValue(_value - _discreteStep));
    setState(() {
      _value = _getClosestDiscreteValue(_value - _discreteStep);
    });
    _controller.text = _formatValue(_value);
  }

  double get _discreteStep => (widget.max - widget.min) / widget.divisions!;

  double _getClosestDiscreteValue(double n) {
    var values = [];
    var curValue = widget.min;
    for (int i = 0; i < widget.divisions!; i++) {
      values.add(curValue);
      curValue += _discreteStep;
    }
    values.add(widget.max);
    return values.reduce(
      (a, b) => (a - n).abs() <= (b - n).abs() ? a : b,
    );
  }

  String _formatValue(double value) {
    return widget.formatValue != null ? widget.formatValue!(value) : value.toStringAsFixed(2);
  }

  double _roundValue(double value) {
    return double.parse(_formatValue(value));
  }
}
