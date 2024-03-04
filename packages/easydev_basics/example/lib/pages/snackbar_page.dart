import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example_basics/widgets/page_appbar.dart';
import 'package:example_basics/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Snackbar',
            child: EasyDevSnackBar(
              title: "This is snackbar",
              action: EasyDevButton.text(
                text: "Action",
                textColor: theme.brightness == Brightness.light
                    ? (theme.colorPalette.secondarySwatch?[800])
                    : (theme.colorPalette.tertiarySwatch?[500]),
                onTap: () {},
              ),
            ),
          ),
          const WidgetWrapper(
            label: 'Snackbar without action',
            child: EasyDevSnackBar(
              title: "This is snackbar",
            ),
          ),
          WidgetWrapper(
            label: 'Multiline snackbar',
            child: EasyDevSnackBar(
              title: "This is snackbar This is snackbar This is snackbar This is snackbar ",
              action: EasyDevButton.text(
                text: "Action",
                textColor: theme.brightness == Brightness.light
                    ? (theme.colorPalette.secondarySwatch?[800])
                    : (theme.colorPalette.tertiarySwatch?[500]),
                onTap: () {},
              ),
            ),
          ),
          const WidgetWrapper(
            label: 'Multiline snackbar without action',
            child: EasyDevSnackBar(
              title: "This is snackbar This is snackbar  ",
            ),
          ),
          WidgetWrapper(
            label: 'Show snackbar',
            child: EasyDevButton(
              text: 'Show snackbar',
              onTap: () {
                EasyDevScaffoldMessenger.of(context).showSnackBar(
                  const EasyDevSnackBar(
                    title: "This is snackbar",
                  ),
                );
              },
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Snackbars page',
      ),
    );
  }
}
