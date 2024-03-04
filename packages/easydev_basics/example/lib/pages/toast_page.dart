import 'dart:math';

import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example_basics/widgets/page_appbar.dart';
import 'package:example_basics/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Single line toasts',
            child: Column(
              children: [
                EasyDevToast(
                  onClose: () {},
                  state: ToastState.success,
                  title: 'Success toast',
                ),
                EasyDevToast(
                  onClose: () {},
                  title: 'Informational toast',
                ),
                EasyDevToast(
                  state: ToastState.warning,
                  onClose: () {},
                  title: 'Warning toast',
                ),
                EasyDevToast(
                  onClose: () {},
                  state: ToastState.error,
                  title: 'Error toast',
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Toasts with text',
            child: Column(
              children: [
                EasyDevToast(
                  onClose: () {},
                  state: ToastState.success,
                  title: 'Success toast',
                  subtitle: 'Text',
                ),
                EasyDevToast(
                  onClose: () {},
                  title: 'Informational toast',
                  subtitle: 'Text',
                ),
                EasyDevToast(
                  state: ToastState.warning,
                  onClose: () {},
                  title: 'Warning toast',
                  subtitle: 'Text',
                ),
                EasyDevToast(
                  onClose: () {},
                  state: ToastState.error,
                  title: 'Error toast',
                  subtitle: 'Text',
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Show toast with random state',
            child: EasyDevButton(
              text: 'Show toast',
              onTap: () {
                EasyDevScaffoldMessenger.of(context).showToast(
                  EasyDevToast(
                    title: "This is toast with random state",
                    state: ToastState.values[Random().nextInt(4)],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 64,
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Toasts page',
      ),
    );
  }
}
