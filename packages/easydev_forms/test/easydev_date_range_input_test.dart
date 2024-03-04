import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

PageRoute<T> routeBuilder<T>(RouteSettings settings, WidgetBuilder builder) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) =>
          builder(context),
    );

Widget createWidget(Widget widget) {
  return WidgetsApp(
    color: defaultDarkTheme.colorPalette.primarySwatch,
    home: EasyDevTheme(
      darkThemeData: defaultDarkTheme,
      child: widget,
    ),
    pageRouteBuilder: routeBuilder,
  );
}

void main() {
  testWidgets("Labels are showing", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      const EasyDevDateRangeInput(
        endLabel: 'endLabel',
        startLabel: 'startLabel',
      ),
    ));
    expect(find.text('endLabel'), findsOneWidget);
    expect(find.text('startLabel'), findsOneWidget);
  });

  testWidgets("Hints are showing", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      const EasyDevDateRangeInput(
        endHelperText: 'endHint',
        startHelperText: 'startHint',
      ),
    ));
    expect(find.text('endHint'), findsOneWidget);
    expect(find.text('startHint'), findsOneWidget);
  });

  testWidgets("Errors are showing", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      const EasyDevDateRangeInput(
        endHelperText: 'endHint',
        startHelperText: 'startHint',
        endError: 'endError',
        startError: 'startError',
        startInputState: InputState.error,
        endInputState: InputState.error,
      ),
    ));
    expect(find.text('endError'), findsOneWidget);
    expect(find.text('startError'), findsOneWidget);
  });
}
