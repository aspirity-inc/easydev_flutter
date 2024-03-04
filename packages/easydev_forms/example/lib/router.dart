import 'package:example_forms/pages/date_picker_page.dart';
import 'package:example_forms/pages/date_range_picker_page.dart';
import 'package:example_forms/pages/input_code_page.dart';
import 'package:example_forms/pages/input_number_page.dart';
import 'package:example_forms/pages/select_page.dart';
import 'package:example_forms/pages/selectables_page.dart';
import 'package:example_forms/pages/home_page/home_page.dart';
import 'package:example_forms/pages/sliders_page.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  final Map<String, Widget> pages = {
    '/': const HomePage(),
    '/selectables': const SelectablesPage(),
    '/sliders': const SlidersPage(),
    '/datePicker': const DatePickerPage(),
    '/dateRangePicker': const DateRangePickerPage(),
    '/inputCode': const InputCodePage(),
    '/inputNumber': const InputNumberPage(),
    '/select': const SelectPage(),
  };

  Route generate(RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) {
        final page = pages[settings.name];
        if (page == null) throw Exception('No route found');
        return page;
      },
    );
  }

  Route onUnknownRoute(RouteSettings settings) {
    return PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return const HomePage();
    });
  }

  PageRoute<T> routeBuilder<T>(RouteSettings settings, WidgetBuilder builder) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) =>
            builder(context),
      );
}
