import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example_forms/widgets/page_appbar.dart';
import 'package:example_forms/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class InputNumberPage extends StatelessWidget {
  const InputNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              'Minimum number - 0, Maximum number - 5',
              style: context.easyDevTheme.typography?.subheading2Style,
            ),
          ),
          WidgetWrapper(
            label: 'Default number input',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevInputNumber(
                  initialValue: 0,
                  maxValue: 5,
                  valueChanged: (int value) {},
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Number inputs page',
      ),
    );
  }
}
