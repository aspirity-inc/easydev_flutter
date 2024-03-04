import 'package:easydev_basics/src/widgets/easydev_snackbar/easydev_snackbar.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

PageRoute<T> routeBuilder<T>(RouteSettings settings, WidgetBuilder builder) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) =>
          builder(context),
    );

Widget createWidget(EasyDevSnackBar snackbar) {
  return WidgetsApp(
    color: defaultDarkTheme.colorPalette.primarySwatch,
    home: EasyDevTheme(
      darkThemeData: defaultDarkTheme,
      child: snackbar,
    ),
    pageRouteBuilder: routeBuilder,
  );
}

void main() {
  const title = "Snackbar title";

  group("snackbar title", () {
    testWidgets("title is showing", (widgetTester) async {
      await widgetTester.pumpWidget(createWidget(
        const EasyDevSnackBar(title: title),
      ));
      expect(find.text(title), findsOneWidget);
    });

    testWidgets("title color is correct", (widgetTester) async {
      const titleColor = Color(0xFFAABBCC);

      await widgetTester.pumpWidget(createWidget(
        const EasyDevSnackBar(
          title: title,
          titleColor: titleColor,
        ),
      ));
      expect(widgetTester.firstWidget<Text>(find.text(title)).style?.color, titleColor);
    });
  });

  group("snackbar subtitle", () {
    const subtitle = "Snackbar subtitle";

    testWidgets("subtitle is showing", (widgetTester) async {
      await widgetTester.pumpWidget(createWidget(
        const EasyDevSnackBar(
          title: title,
          subtitle: subtitle,
        ),
      ));
      expect(find.text(subtitle), findsOneWidget);
    });

    testWidgets("subtitle color is correct", (widgetTester) async {
      const subtitleColor = Color(0xFFCCBBAA);

      await widgetTester.pumpWidget(createWidget(
        const EasyDevSnackBar(
          title: title,
          subtitle: subtitle,
          subtitleColor: subtitleColor,
        ),
      ));
      expect(widgetTester.firstWidget<Text>(find.text(subtitle)).style?.color, subtitleColor);
    });
  });

  testWidgets("action is added correctly", (widgetTester) async {
    final action = Container(color: const Color(0xFFDDEEFF));

    await widgetTester.pumpWidget(createWidget(
      EasyDevSnackBar(
        title: title,
        action: action,
      ),
    ));
    expect(widgetTester.firstWidget(find.byWidget(action)), action);
  });
}
