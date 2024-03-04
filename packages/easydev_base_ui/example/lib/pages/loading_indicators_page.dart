import 'dart:async';

import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example/widgets/page_appbar.dart';
import 'package:example/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class LoadingIndicatorsPage extends StatefulWidget {
  const LoadingIndicatorsPage({super.key});

  @override
  State<LoadingIndicatorsPage> createState() => _LoadingIndicatorsPageState();
}

class _LoadingIndicatorsPageState extends State<LoadingIndicatorsPage> {
  int value = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (value == 100) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() {
          value = value + 2;
        });
      }
    });
  }

  void _restartTimer() {
    setState(() {
      timer.cancel();
      value = 0;
    });
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (value == 100) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() {
          value = value + 2;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          const WidgetWrapper(
            label: 'Empty progress bar',
            child: EasyDevProgressBar(
              percentage: 0,
            ),
          ),
          const WidgetWrapper(
            label: '50% progress bar',
            child: EasyDevProgressBar(
              percentage: 0.5,
            ),
          ),
          const WidgetWrapper(
            label: 'Full progress bar',
            child: EasyDevProgressBar(
              percentage: 1,
            ),
          ),
          WidgetWrapper(
            label: 'Restartable progress indicator',
            child: Column(
              children: [
                EasyDevProgressBar(
                  percentage: value / 100,
                ),
                EasyDevButton(
                  text: 'Restart',
                  onTap: _restartTimer,
                  disabled: timer.isActive,
                ),
              ],
            ),
          ),
          const WidgetWrapper(
            label: 'Small circular loading indicator',
            child: CircularLoadingIndicator(
              type: IndicatorType.small,
            ),
          ),
          const WidgetWrapper(
            label: 'Medium circular loading indicator',
            child: CircularLoadingIndicator(
              type: IndicatorType.medium,
            ),
          ),
          const WidgetWrapper(
            label: 'Large circular loading indicator',
            child: CircularLoadingIndicator(
              type: IndicatorType.large,
            ),
          ),
          const WidgetWrapper(
            label: 'Infinite progress bar',
            child: EasyDevInfiniteProgressBar(
              width: 202,
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Loading indicators page',
      ),
    );
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}
