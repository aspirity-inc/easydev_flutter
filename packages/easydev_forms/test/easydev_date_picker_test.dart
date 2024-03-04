import 'package:easydev_forms/src/widgets/easydev_date_picker/date_picker_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/easydev_date_picker.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/year_picker.dart';
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
  testWidgets("Year is showing", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      EasyDevDatePicker(
        startDate: DateTime(2000),
        endDate: DateTime(2020),
        initialDate: DateTime(2005),
        onOkTap: (value) {},
        onCancelTap: () {},
      ),
    ));
    expect(find.text('2005'), findsOneWidget);
  });

  testWidgets("Month is showing", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      EasyDevDatePicker(
        startDate: DateTime(2000),
        endDate: DateTime(2020),
        initialDate: DateTime(2005),
        onOkTap: (value) {},
        onCancelTap: () {},
      ),
    ));
    expect(find.text('January'), findsOneWidget);
  });

  testWidgets("Days is showing correctly", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      EasyDevDatePicker(
        startDate: DateTime(2000),
        endDate: DateTime(2020),
        initialDate: DateTime(2005),
        onOkTap: (value) {},
        onCancelTap: () {},
      ),
    ));
    expect(find.text('01'), findsWidgets);
  });

  testWidgets("Disabled days is showing", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      EasyDevDatePicker(
        startDate: DateTime(2000),
        endDate: DateTime(2024),
        initialDate: DateTime(2023, 2),
        onOkTap: (value) {},
        onCancelTap: () {},
      ),
    ));
    expect(find.text('31'), findsOneWidget);
  });

  testWidgets("Disabled days not showing", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      EasyDevDatePicker(
        startDate: DateTime(2000),
        endDate: DateTime(2024),
        initialDate: DateTime(2023, 2),
        showDisabledDays: false,
        onOkTap: (value) {},
        onCancelTap: () {},
      ),
    ));
    expect(find.text('31'), findsNothing);
  });

  testWidgets("Day selects correctly", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      EasyDevDatePicker(
        startDate: DateTime(2000),
        endDate: DateTime(2024),
        initialDate: DateTime(2023, 2, 16),
        decoration: const DatePickerDecoration(
          selectedDayColor: Color(0xFFFF9000),
        ),
        onOkTap: (value) {},
        onCancelTap: () {},
      ),
    ));
    expect(
      widgetTester.firstWidget<Text>(find.text('16')).style?.color,
      const Color(0xFFFF9000),
    );
  });

  testWidgets("Year picker shows years correctly", (widgetTester) async {
    await widgetTester.pumpWidget(createWidget(
      YearPicker(
        endYear: 2050,
        startYear: 2000,
        onTap: (_) {},
        selectedYear: 2010,
        decoration: const DatePickerDecoration(),
      ),
    ));

    expect(find.text('2050'), findsOneWidget);
  });
}
