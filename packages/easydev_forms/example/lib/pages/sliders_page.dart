import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example_forms/widgets/page_appbar.dart';
import 'package:example_forms/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class SlidersPage extends StatefulWidget {
  const SlidersPage({super.key});

  @override
  State<SlidersPage> createState() => _SlidersPageState();
}

class _SlidersPageState extends State<SlidersPage> {
  double _sliderValue1 = 0.5;
  double _sliderValue2 = 10000;
  double _sliderValue4 = 0.0005;
  double _sliderValue5 = 0.5;
  double _sliderValue6 = 5;
  RangeValue _sliderRangeValue1 = const RangeValue(0, 1);
  RangeValue _sliderRangeValue2 = const RangeValue(1, 5);
  RangeValue _sliderRangeValue3 = const RangeValue(1, 5);
  RangeValue _sliderRangeValue4 = const RangeValue(2.25, 40.34);
  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Slider',
            child: EasyDevSlider(
              title: 'Title',
              showLabel: true,
              showInput: true,
              inputPosition: SliderInputPosition.right,
              value: _sliderValue1,
              onChanged: (double value) {
                setState(() {
                  _sliderValue1 = value;
                });
              },
            ),
          ),
          WidgetWrapper(
            label: 'Sliders min and max values',
            child: EasyDevSlider(
              value: _sliderValue2,
              min: 10000,
              max: 100000,
              showInput: true,
              inputPosition: SliderInputPosition.top,
              buttonStepAmount: 10000,
              formatValue: (value) => value.toInt().toString(),
              onChanged: (double value) {
                setState(() {
                  _sliderValue2 = value;
                });
              },
            ),
          ),
          WidgetWrapper(
            label: 'Slider with custom track',
            child: EasyDevSlider(
              value: _sliderValue4,
              min: 0,
              max: 0.001,
              showLabel: true,
              sliderHandleSize: 0,
              sliderTrackThickness: 40,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              showButtons: false,
              formatValue: (value) => value.toStringAsFixed(5),
              onChanged: (double value) {
                setState(() {
                  _sliderValue4 = value;
                });
              },
            ),
          ),
          WidgetWrapper(
            label: 'Slider with custom thickness and handle',
            child: Column(
              children: [
                Icon(
                  CommunityMaterialIcons.volume_high,
                  size: 36,
                  color: EasyDevTheme.of(context).colorPalette.greySwatch.greyColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                EasyDevSlider(
                  value: _sliderValue5,
                  sliderHandleSize: 20,
                  sliderTrackThickness: 20,
                  showButtons: false,
                  showEdgeValues: false,
                  showTooltip: false,
                  formatValue: (value) => value.toStringAsFixed(5),
                  onChanged: (double value) {
                    setState(() {
                      _sliderValue5 = value;
                    });
                  },
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Slider with divisions',
            child: EasyDevSlider(
              title: 'Title',
              value: _sliderValue6,
              showInput: true,
              inputPosition: SliderInputPosition.bottom,
              divisions: 9,
              min: -1,
              max: 10,
              formatValue: (value) => value.toStringAsFixed(1),
              onChanged: (double value) {
                setState(() {
                  _sliderValue6 = value;
                });
              },
            ),
          ),
          WidgetWrapper(
            label: 'Range slider',
            child: EasyDevRangeSlider(
              value: _sliderRangeValue1,
              title: 'Title',
              showInput: true,
              inputPosition: SliderInputPosition.top,
              onChanged: (RangeValue value) {
                setState(() {
                  _sliderRangeValue1 = value;
                });
              },
            ),
          ),
          WidgetWrapper(
            label: 'Range slider with minimal range',
            child: EasyDevRangeSlider(
              value: _sliderRangeValue2,
              min: 0,
              max: 10,
              sliderHandleSize: 30,
              showInput: true,
              inputPosition: SliderInputPosition.bottom,
              minimalRange: 2,
              formatValue: (value) => value.toStringAsFixed(1),
              onChanged: (RangeValue value) {
                setState(() {
                  _sliderRangeValue2 = value;
                });
              },
            ),
          ),
          WidgetWrapper(
            label: 'Range slider with divisions',
            child: EasyDevRangeSlider(
              value: _sliderRangeValue3,
              min: -100,
              max: 100,
              showInput: true,
              inputPosition: SliderInputPosition.bottom,
              divisions: 8,
              onChanged: (RangeValue value) {
                setState(() {
                  _sliderRangeValue3 = value;
                });
              },
            ),
          ),
          WidgetWrapper(
            label: 'Range slider with minimal range',
            child: EasyDevRangeSlider(
              value: _sliderRangeValue4,
              min: 0.33,
              max: 88.66,
              divisions: 8,
              showInput: true,
              inputPosition: SliderInputPosition.bottom,
              formatValue: (value) => value.toStringAsFixed(2),
              minimalRange: 20,
              onChanged: (RangeValue value) {
                setState(() {
                  _sliderRangeValue4 = value;
                });
              },
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Sliders page',
      ),
    );
  }
}
