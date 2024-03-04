import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example_basics/widgets/page_appbar.dart';
import 'package:example_basics/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class BottomSheetPage extends StatelessWidget {
  const BottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Bottom sheet',
            child: EasyDevButton.primary(
              text: 'Show bottom sheet',
              onTap: () => showEasyDevBottomSheet(
                context: context,
                builder: (context) => EasyDevBottomSheet(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  child: const SizedBox(),
                ),
              ),
            ),
          ),
          WidgetWrapper(
            label: 'Bottom sheet with min height',
            child: EasyDevButton.primary(
              text: 'Show bottom sheet',
              onTap: () => showEasyDevBottomSheet(
                context: context,
                builder: (context) => EasyDevBottomSheet(
                  minHeight: MediaQuery.of(context).size.height * 0.2,
                  child: const SizedBox(),
                ),
              ),
            ),
          ),
          WidgetWrapper(
            label: 'Not draggable bottom sheet',
            child: EasyDevButton.primary(
              text: 'Show bottom sheet',
              onTap: () => showEasyDevBottomSheet(
                context: context,
                builder: (context) => EasyDevBottomSheet(
                  draggable: false,
                  child: Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        EasyDevButton.primary(
                          text: 'Close',
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Bottom sheet page',
      ),
    );
  }
}
