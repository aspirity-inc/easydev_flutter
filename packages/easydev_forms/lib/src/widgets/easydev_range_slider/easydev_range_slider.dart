import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_range_slider/range_handle_painter.dart';
import 'package:easydev_forms/src/widgets/easydev_range_slider/range_slider_input.dart';
import 'package:easydev_forms/src/widgets/easydev_range_slider/range_tooltip_painter.dart';
import 'package:easydev_forms/src/widgets/easydev_range_slider/range_track_painter.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

/// [EasyDevRangeSlider] is slider that can return [RangeValue], that contains two positions
/// between minimum and maximum values. Range value is changed by [onChanged] callback,
/// when moving handles, when [minimalRange] is specified, [RangeValue] difference between
/// [RangeValue.start] and [RangeValue.end] cannot be less then [minimalRange].
/// [minimalHandleDrawingRange] is not affecting [minimalRange], it is just adding visual
/// padding to two handles.
/// Slider with input can have two [EasyDevTextField] inputs, so user can enter values manually.
/// Slider with [divisions] provided only return discrete set of values. Divisions
/// split difference in min and max value with by itself. For example: if we provide
/// divisions equal 5 with min equal 0 and max equal 10, divisions will be 0,2,4,6,8,10.
/// [showTooltip] property shows tooltip on top of last moved handle.
/// [formatValue] callback provides callback for formatting value in tooltip and inputs
/// For example: 10$ instead of value of 10.0.
///
/// Example of using [EasyDevSlider] with text field.
/// ```dart
/// EasyDevRangeSlider(
///    title: 'Title',
///    showInput: true,
///    value: RangeValue(0,1),
///    inputPosition: SliderInputPosition.top,
///    onChanged: (double value) {
///    ...
///    },
/// ),
/// ```
///
/// [inputPosition] defines position of input. When it is equal to [SliderInputPosition.top],
/// input is positioned on top of slider, and below label, if it is equal
/// to [SliderInputPosition.bottom] it is positioned below slider, slider cannot have
/// [SliderInputPosition.right], as inputs will be too big.
/// [title] is positioned on top of slider, providing way to express what value is selected.
/// Handles are objects that is dragged by user to select a range value.
/// Tooltip is shown on top of dragged handle.
/// Track is line where slider alongside that handles are dragged.
/// [selectedTrackColor] color of between handles.
/// [unselectedTrackColor] color of track outside of handles.
/// [showEdgeValues] representing [min] and [max] values in slider on edges of slider track.
///
/// This sample shows app with [EasyDevRangeSlider].
///
/// See code in example/lib/pages/examples/range_slider_example.dart
///
/// See also:
///
///  * [EasyDevSlider], slider for selecting single value.
class EasyDevRangeSlider extends StatefulWidget {
  /// Create a slider.
  EasyDevRangeSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
    this.showInput = false,
    this.inputPosition = SliderInputPosition.top,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.minimalRange,
    this.handleColor,
    this.selectedTrackColor,
    this.unselectedTrackColor,
    this.tooltipColor,
    this.tooltipTextColor,
    this.formatValue,
    this.showEdgeValues,
    this.showTooltip,
    this.padding,
    this.sliderTrackThickness,
    this.sliderHandleSize,
    this.sliderHandleWidth,
    this.minimalHandleDrawingRange = 5,
  })  : assert(min <= max),
        assert(value.start <= value.end),
        assert(value.start >= min && value.start <= max),
        assert(value.end >= min && value.end <= max),
        assert(divisions == null || divisions > 0),
        assert(minimalRange == null || (value.end - value.start).abs() >= minimalRange,
            'Value ${(value.end - value.start).abs()} is less then $minimalRange'),
        assert(inputPosition != SliderInputPosition.right);

  /// Current value of slider.
  final RangeValue value;

  /// Callback that will run when value changes.
  final ValueChanged<RangeValue> onChanged;

  /// Title of slider
  final String? title;

  /// Show input for slider
  final bool showInput;

  /// Position of input relative to slider
  final SliderInputPosition inputPosition;

  /// Minimum value
  final double min;

  /// Maximum value
  final double max;

  /// The number of discrete parts the slider is divided into
  final int? divisions;

  /// Minimal range between values.
  final double? minimalRange;

  /// Slider handle color.
  final Color? handleColor;

  /// Slider track color of selected part.
  final Color? selectedTrackColor;

  /// Slider track color of not selected part.
  final Color? unselectedTrackColor;

  /// Tooltip color.
  final Color? tooltipColor;

  /// Tooltip text color.
  final Color? tooltipTextColor;

  /// Function showing what text should be displayed on the tooltip and in the inputs.
  final String Function(double)? formatValue;

  /// Show maximum and minimum value.
  final bool? showEdgeValues;

  /// Show tooltip.
  final bool? showTooltip;

  /// Slider padding.
  final EdgeInsets? padding;

  /// Slider track thickness.
  final double? sliderTrackThickness;

  /// Slider handle size.
  final double? sliderHandleSize;

  /// Slider handle width.
  final double? sliderHandleWidth;

  /// Minimal range between drawn handles. Does not depend on minimal range between values.
  final double minimalHandleDrawingRange;

  @override
  State<EasyDevRangeSlider> createState() => _EasyDevRangeSliderState();
}

class _EasyDevRangeSliderState extends State<EasyDevRangeSlider> {
  late Color? _handleColor;
  late Color? _selectedTrackColor;
  late Color? _unselectedTrackColor;
  late Color? _tooltipColor;
  late Color? _tooltipTextColor;
  late bool _showEdgeValues;
  late bool _showTooltip;
  late EdgeInsets _padding;
  late double _sliderTrackThickness;
  late double _sliderHandleSize;
  late double _sliderHandleWidth;
  late TextStyle? _sliderTextStyle;
  late TextStyle? _tooltipTextStyle;
  late TextStyle? _titleTextStyle;

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
    final colorPalette = theme.colorPalette;
    final sliderTheme = theme.sliderTheme;

    _handleColor = widget.handleColor ??
        sliderTheme?.handleColor ??
        colorPalette.greySwatch.backgroundColor ??
        colorPalette.greySwatch.surfaceColor;
    _selectedTrackColor = widget.selectedTrackColor ??
        sliderTheme?.selectedTrackColor ??
        (theme.brightness == Brightness.light
            ? (theme.colorPalette.secondarySwatch?[200] ?? theme.colorPalette.secondarySwatch)
            : theme.colorPalette.tertiarySwatch);
    _unselectedTrackColor = widget.unselectedTrackColor ??
        sliderTheme?.unselectedTrackColor ??
        theme.colorPalette.greySwatch.disabledColor;
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
    _padding = widget.padding ?? sliderTheme?.padding ?? const EdgeInsets.all(8);
    _sliderTrackThickness = widget.sliderTrackThickness ?? sliderTheme?.sliderTrackThickness ?? 4;
    _sliderHandleSize = widget.sliderHandleSize ?? sliderTheme?.sliderHandleSize ?? 20;
    _sliderHandleWidth = widget.sliderHandleWidth ?? sliderTheme?.sliderHandleWidth ?? 4;
    _sliderTextStyle = theme.typography?.captionStyle;
    _tooltipTextStyle = theme.typography?.tooltipStyle;
    _titleTextStyle = theme.typography?.body2Style;
  }

  var _leftTooltipVisible = false;
  var _rightTooltipVisible = false;
  bool _rightMoving = false;
  bool _leftMoving = false;
  bool _leftIsAbove = false;
  late RangeValue _value;
  final _startInputController = TextEditingController();
  final _endInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _value = widget.divisions != null ? _getClosestDiscreteValues(widget.value) : widget.value;

    _startInputController.text = _formatValue(
      widget.divisions != null ? _getClosestDiscreteValue(_value.start) : _value.start,
    );
    _endInputController.text = _formatValue(
      widget.divisions != null ? _getClosestDiscreteValue(_value.end) : _value.end,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    final rangeInput = RangeSliderInput(
      min: widget.min,
      max: widget.max,
      currentValue: _value,
      minimalRange: widget.minimalRange,
      startController: _startInputController,
      endController: _endInputController,
      formatValue: _formatValue,
      onStartChanged: (value) {
        if (value != null) {
          final newValue = RangeValue(
            widget.divisions != null ? _getClosestDiscreteValue(value) : value,
            widget.divisions != null
                ? _getClosestDiscreteValue(widget.value.end)
                : widget.value.end,
          );
          widget.onChanged(newValue);
          setState(() {
            _value = newValue;
          });
        }
      },
      onEndChanged: (value) {
        if (value != null) {
          final newValue = RangeValue(
            widget.divisions != null
                ? _getClosestDiscreteValue(widget.value.start)
                : widget.value.start,
            widget.divisions != null ? _getClosestDiscreteValue(value) : value,
          );
          widget.onChanged(newValue);
          setState(() {
            _value = newValue;
          });
        }
      },
    );

    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: _titleTextStyle,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
          if (widget.showInput && widget.inputPosition == SliderInputPosition.top) ...[
            rangeInput,
            const SizedBox(
              height: 10,
            ),
          ],
          if (_showTooltip)
            Row(
              children: [
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    var spanLeft = TextSpan(
                      text: _formatValue(widget.value.start),
                      style: _tooltipTextStyle?.copyWith(
                        color: _tooltipTextColor,
                      ),
                    );
                    final textPainterLeft = TextPainter(
                      text: spanLeft,
                      maxLines: 1,
                      textScaler: MediaQuery.of(context).textScaler,
                      textDirection: TextDirection.ltr,
                    )..layout();
                    var spanRight = TextSpan(
                      text: _formatValue(widget.value.end),
                      style: _tooltipTextStyle?.copyWith(
                        color: _tooltipTextColor,
                      ),
                    );
                    final textPainterRight = TextPainter(
                      text: spanRight,
                      maxLines: 1,
                      textScaler: MediaQuery.of(context).textScaler,
                      textDirection: TextDirection.ltr,
                    )..layout();
                    return SizedBox(
                      height: 35 + textPainterLeft.height,
                      child: _leftTooltipVisible || _rightTooltipVisible
                          ? CustomPaint(
                              painter: RangeTooltipPainter(
                                value: widget.value,
                                showStartTooltip: _leftTooltipVisible,
                                showEndTooltip: _rightTooltipVisible,
                                min: widget.min,
                                max: widget.max,
                                sliderHandleRadius: _sliderHandleSize / 2,
                                textPainterLeft: textPainterLeft,
                                textPainterRight: textPainterRight,
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
              ],
            ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: SizedBox(
                    height: _sliderHandleSize > _sliderTrackThickness
                        ? _sliderHandleSize + 1
                        : _sliderTrackThickness + 1,
                    child: CustomPaint(
                      painter: RangeTrackPainter(
                        value: widget.value,
                        max: widget.max,
                        min: widget.min,
                        sliderTrackThickness: _sliderTrackThickness,
                        sliderHandleRadius: _sliderHandleSize / 2,
                        sliderHandleWidth: _sliderHandleWidth,
                        handleColor: _handleColor ?? theme.colorPalette.greySwatch.greyColor,
                        unselectedTrackColor:
                            _unselectedTrackColor ?? theme.colorPalette.greySwatch.greyColor,
                        selectedTrackColor: _selectedTrackColor ??
                            theme.colorPalette.secondarySwatch?[400] ??
                            theme.colorPalette.secondarySwatch ??
                            theme.colorPalette.primarySwatch,
                        divisions: widget.divisions,
                      ),
                      child: CustomPaint(
                        painter: RangeHandlePainter(
                          value: widget.value,
                          minimalHandleDrawingRange: widget.minimalHandleDrawingRange,
                          max: widget.max,
                          min: widget.min,
                          leftIsAbove: _leftIsAbove,
                          sliderHandleRadius: _sliderHandleSize / 2,
                          sliderHandleWidth: _sliderHandleWidth,
                          handleColor: _handleColor ?? theme.colorPalette.greySwatch.greyColor,
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
                  onHorizontalDragEnd: (details) => _handleUp(),
                  onVerticalDragEnd: (details) => _handleUp(),
                  onTapUp: (details) => _handleUp(),
                  onTapDown: (details) => _onTapDown(details),
                ),
              ),
            ],
          ),
          if (_showEdgeValues)
            Row(
              children: [
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
              ],
            ),
          if (widget.showInput && widget.inputPosition == SliderInputPosition.bottom) ...[
            const SizedBox(
              height: 10,
            ),
            rangeInput
          ],
        ],
      ),
    );
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails details) {
    if (widget.divisions != null) {
      widget.onChanged(_getClosestDiscreteValues(_value));
      _startInputController.text = _formatValue(_getClosestDiscreteValues(_value).start);
      _endInputController.text = _formatValue(_getClosestDiscreteValues(_value).end);
      setState(() {
        _value = _getClosestDiscreteValues(_value);
      });
    }
    RenderBox box = context.findRenderObject() as RenderBox;
    double width = box.constraints.maxWidth - _padding.right - _padding.left;
    final curValue = widget.min + details.localPosition.dx * (widget.max - widget.min) / width;

    final isRightSelected = (curValue - _value.start).abs() > (curValue - _value.end).abs() ||
        (_value.end == _value.start && (details.primaryDelta ?? 0) > 0);
    final isLeftSelected = (curValue - _value.start).abs() < (curValue - _value.end).abs() ||
        (_value.end == _value.start && (details.primaryDelta ?? 0) < 0);

    setState(() {
      _leftTooltipVisible = isLeftSelected;
      _rightTooltipVisible = isRightSelected;
    });

    _updateValue(curValue, isLeftSelected, isRightSelected);
  }

  void _onDragStart(BuildContext context, DragStartDetails details) {
    if (widget.divisions != null) {
      widget.onChanged(_getClosestDiscreteValues(_value));
      _startInputController.text = _formatValue(_getClosestDiscreteValues(_value).start);
      _endInputController.text = _formatValue(_getClosestDiscreteValues(_value).end);
      setState(() {
        _value = _getClosestDiscreteValues(_value);
      });
    }

    RenderBox box = context.findRenderObject() as RenderBox;
    double width = box.constraints.maxWidth - _padding.right - _padding.left;

    final curValue = widget.min + details.localPosition.dx * (widget.max - widget.min) / width;

    final isRightSelected = (curValue - _value.start).abs() > (curValue - _value.end).abs();
    final isLeftSelected = (curValue - _value.start).abs() < (curValue - _value.end).abs();

    setState(() {
      _leftTooltipVisible = isLeftSelected;
      _rightTooltipVisible = isRightSelected;
      _leftIsAbove = isLeftSelected;
    });

    _updateValue(curValue, isLeftSelected, isRightSelected);
  }

  void _handleUp() {
    setState(() {
      _leftTooltipVisible = false;
      _rightTooltipVisible = false;
      _rightMoving = false;
      _leftMoving = false;
    });
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.divisions != null) {
      widget.onChanged(_getClosestDiscreteValues(_value));
      _startInputController.text = _formatValue(_getClosestDiscreteValues(_value).start);
      _endInputController.text = _formatValue(_getClosestDiscreteValues(_value).end);
      setState(() {
        _value = _getClosestDiscreteValues(_value);
      });
    }

    RenderBox box = context.findRenderObject() as RenderBox;
    double width = box.constraints.maxWidth - _padding.right - _padding.left;

    final curValue = widget.min + details.localPosition.dx * (widget.max - widget.min) / width;

    final isLeftSelected = (curValue - _value.start).abs() < (curValue - _value.end).abs() ||
        (_value.end == _value.start);
    final isRightSelected = (curValue - _value.start).abs() > (curValue - _value.end).abs() ||
        (_value.end == _value.start);

    setState(() {
      _leftTooltipVisible = isLeftSelected;
      _rightTooltipVisible = isRightSelected;
      _leftIsAbove = isLeftSelected;
    });
  }

  void _updateValue(double curValue, bool isLeftSelected, bool isRightSelected) {
    if (!_leftMoving && !_rightMoving) {
      setState(() {
        _rightMoving = isRightSelected;
        _leftMoving = isLeftSelected;
        _leftIsAbove = isLeftSelected;
      });
    }

    var newValue = curValue;
    if (widget.divisions != null) {
      newValue = _getClosestDiscreteValue(newValue);
    }

    if (_rightMoving) {
      newValue = newValue <= _value.start ? _value.start : newValue;
      newValue = newValue >= widget.max ? widget.max : newValue;

      if (widget.minimalRange != null) {
        if ((newValue - _value.start).abs() <= widget.minimalRange!) {
          newValue = _value.end;
        }
      }

      widget.onChanged(RangeValue(_value.start, newValue));
      _startInputController.text = _formatValue(_value.start);
      _endInputController.text = _formatValue(newValue);
      setState(() {
        _value = RangeValue(_value.start, newValue);
      });
    } else if (_leftMoving) {
      newValue = newValue >= _value.end ? _value.end : newValue;
      newValue = newValue <= widget.min ? widget.min : newValue;

      if (widget.minimalRange != null) {
        if ((newValue - _value.end).abs() <= widget.minimalRange!) {
          newValue = _value.start;
        }
      }

      widget.onChanged(RangeValue(newValue, _value.end));
      _startInputController.text = _formatValue(newValue);
      _endInputController.text = _formatValue(_value.end);
      setState(() {
        _value = RangeValue(newValue, _value.end);
      });
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

  RangeValue _getClosestDiscreteValues(RangeValue n) {
    return RangeValue(_getClosestDiscreteValue(n.start), _getClosestDiscreteValue(n.end));
  }

  String _formatValue(double value) {
    return widget.formatValue != null ? widget.formatValue!(value) : value.toStringAsFixed(2);
  }
}
