import 'package:example/pages/buttons_page.dart';
import 'package:example/pages/carousel_page.dart';
import 'package:example/pages/loading_indicators_page.dart';
import 'package:example/pages/modal_widgets_page.dart';
import 'package:example/pages/onboarding_page.dart';
import 'package:example/pages/search_page.dart';
import 'package:example/pages/home_page/home_page.dart';
import 'package:example/pages/input_page/input_page.dart';
import 'package:example/pages/social_media_button_page.dart';
import 'package:example/pages/tabs_page.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  final Map<String, Widget> pages = {
    '/': const HomePage(),
    '/buttons': const ButtonsPage(),
    '/input': const InputPage(),
    '/carousel': const CarouselPage(),
    '/loadingIndicators': const LoadingIndicatorsPage(),
    '/socialMediaButton': const SocialMediaButtonPage(),
    '/tabs': const TabBarPage(),
    '/modalWidgets': const ModalWidgetsPage(),
    '/search': const SearchPage(),
    '/onboarding': const OnboardingPage(),
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
