import 'package:example_basics/pages/appbar_page.dart';
import 'package:example_basics/pages/bottom_navigation_bar_page.dart';
import 'package:example_basics/pages/bottom_sheet_page.dart';
import 'package:example_basics/pages/fab_page.dart';
import 'package:example_basics/pages/home_page/home_page.dart';
import 'package:example_basics/pages/modal_dialog_pages/modal_dialogs_page.dart';
import 'package:example_basics/pages/scaffold_page.dart';
import 'package:example_basics/pages/snackbar_page.dart';
import 'package:example_basics/pages/toast_page.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  final Map<String, Widget> pages = {
    '/': const HomePage(),
    '/snackbar': const SnackBarPage(),
    '/appbar': const AppBarPage(),
    '/scaffold': const ScaffoldPage(),
    '/fab': const FabPage(),
    '/modalDialog': const ModalDialogsPage(),
    '/bottomNavigationBar': const BottomNavigationBarPage(),
    '/bottomSheet': const BottomSheetPage(),
    '/toast': const ToastPage(),
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
