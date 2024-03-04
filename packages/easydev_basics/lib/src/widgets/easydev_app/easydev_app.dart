import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// EasyDevApp widget is core widget to creating apps with EasyDev package, provides
/// [EasyDevScaffoldMessenger] and [EasyDevTheme] to widgets below the widget tree.
/// But in general it is just wrapper for [WidgetsApp].
/// This sample shows [EasyDevApp] with [EasyDevScaffold] containing [EasyDevFloatingActionButton]
/// and that triggers counter.
///
/// See code in example/lib/pages/examples/app/app_example.dart
class EasyDevApp extends StatefulWidget {
  const EasyDevApp({
    super.key,
    this.lightThemeData,
    this.darkThemeData,
    this.brightness = Brightness.light,
    this.usePlatformBrightness = false,
    this.navigatorKey,
    this.home,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.onNavigationNotification,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.routerConfig,
    this.builder,
    this.title,
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.pageRouteBuilder,
    this.scrollBehavior,
    this.routes = const <String, WidgetBuilder>{},
    this.navigatorObservers = const <NavigatorObserver>[],
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = false,
  });

  const EasyDevApp.router({
    super.key,
    this.lightThemeData,
    this.darkThemeData,
    this.brightness = Brightness.light,
    this.usePlatformBrightness = false,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.onNavigationNotification,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.pageRouteBuilder,
    this.scrollBehavior,
  })  : assert(routerDelegate != null || routerConfig != null),
        navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null;

  /// {@macro flutter.widgets.widgetsApp.navigatorKey}
  final GlobalKey<NavigatorState>? navigatorKey;

  /// {@macro flutter.widgets.widgetsApp.home}
  final Widget? home;

  /// The application's top-level routing table.
  ///
  /// When a named route is pushed with [Navigator.pushNamed], the route name is
  /// looked up in this map. If the name is present, the associated
  /// [widgets.WidgetBuilder] is used to construct a [MaterialPageRoute] that
  /// performs an appropriate transition, including [Hero] animations, to the
  /// new route.
  ///
  /// {@macro flutter.widgets.widgetsApp.routes}
  final Map<String, WidgetBuilder>? routes;

  /// {@macro flutter.widgets.widgetsApp.initialRoute}
  final String? initialRoute;

  /// {@macro flutter.widgets.widgetsApp.onGenerateRoute}
  final RouteFactory? onGenerateRoute;

  /// {@macro flutter.widgets.widgetsApp.onGenerateInitialRoutes}
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// {@macro flutter.widgets.widgetsApp.onUnknownRoute}
  final RouteFactory? onUnknownRoute;

  /// {@macro flutter.widgets.widgetsApp.onNavigationNotification}
  final NotificationListenerCallback<NavigationNotification>? onNavigationNotification;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver>? navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.routeInformationProvider}
  final RouteInformationProvider? routeInformationProvider;

  /// {@macro flutter.widgets.widgetsApp.routeInformationParser}
  final RouteInformationParser<Object>? routeInformationParser;

  /// {@macro flutter.widgets.widgetsApp.routerDelegate}
  final RouterDelegate<Object>? routerDelegate;

  /// {@macro flutter.widgets.widgetsApp.backButtonDispatcher}
  final BackButtonDispatcher? backButtonDispatcher;

  /// {@macro flutter.widgets.widgetsApp.routerConfig}
  final RouterConfig<Object>? routerConfig;

  /// {@macro flutter.widgets.widgetsApp.builder}
  final TransitionBuilder? builder;

  /// {@macro flutter.widgets.widgetsApp.title}
  ///
  /// This value is passed unmodified to [WidgetsApp.title].
  final String? title;

  /// {@macro flutter.widgets.widgetsApp.onGenerateTitle}
  ///
  /// This value is passed unmodified to [WidgetsApp.onGenerateTitle].
  final GenerateAppTitle? onGenerateTitle;

  /// Light theme that provides colors and styles for EasyDev widgets. For [EasyDevTheme] to
  /// work correctly you need provide at least one [EasyDevThemeData].
  /// If [usePlatformBrightness] is set to true app will use theme corresponding to system platform
  /// brightness.
  /// Current theme of app can also be changed by changing [brightness] property.
  final EasyDevThemeData? lightThemeData;

  /// Light theme that provides colors and styles for EasyDev widgets. For [EasyDevTheme] to
  /// work correctly you need provide at least one [EasyDevThemeData].
  /// If [usePlatformBrightness] is set to true app will use theme corresponding to system platform
  /// brightness.
  /// Current theme of app can also be changed by changing [brightness] property.
  final EasyDevThemeData? darkThemeData;

  /// If [Brightness.light] app will use [EasyDevThemeData] from [lightThemeData] field if it
  /// provided to [EasyDevTheme]. In case of [Brightness.dark] it will try to
  /// return [darkThemeData] from theme.
  final Brightness brightness;

  /// If [usePlatformBrightness] equal to true, it will
  /// use system platform brightness value from [MediaQuery.platformBrightnessOf].
  final bool usePlatformBrightness;

  /// {@macro flutter.widgets.widgetsApp.color}
  final Color? color;

  /// {@macro flutter.widgets.widgetsApp.locale}
  final Locale? locale;

  /// {@macro flutter.widgets.widgetsApp.localizationsDelegates}
  ///
  /// Internationalized apps that require translations for one of the locales
  /// listed in [GlobalWidgetsLocalizations] should specify this parameter
  /// and list the [supportedLocales] that the application can handle.
  ///
  /// GlobalWidgetsLocalizations class require the following import:
  /// import 'package:flutter_localizations/flutter_localizations.dart';
  ///
  ///  * The Flutter Internationalization Tutorial,
  ///    <https://flutter.dev/tutorials/internationalization/>.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// {@macro flutter.widgets.widgetsApp.localeListResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// {@macro flutter.widgets.LocaleResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleResolutionCallback? localeResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.supportedLocales}
  ///
  /// It is passed along unmodified to the [WidgetsApp] built by this widget.
  ///
  /// See also:
  ///
  ///  * [localizationsDelegates], which must be specified for localized
  ///    applications.
  ///  * The Flutter Internationalization Tutorial,
  ///    <https://flutter.dev/tutorials/internationalization/>.
  final Iterable<Locale> supportedLocales;

  /// Turns on a performance overlay.
  ///
  /// See also:
  ///
  ///  * <https://flutter.dev/debugging/#performance-overlay>
  final bool showPerformanceOverlay;

  /// Turns on checkerboarding of raster cache images.
  final bool checkerboardRasterCacheImages;

  /// Turns on checkerboarding of layers rendered to offscreen bitmaps.
  final bool checkerboardOffscreenLayers;

  /// Turns on an overlay that shows the accessibility information
  /// reported by the framework.
  final bool showSemanticsDebugger;

  /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
  final bool debugShowCheckedModeBanner;

  /// {@macro flutter.widgets.widgetsApp.shortcuts}
  /// This example shows how to add a single shortcut for
  /// [LogicalKeyboardKey.select] to the default shortcuts without needing to
  /// add your own [Shortcuts] widget.
  ///
  /// Alternatively, you could insert a [Shortcuts] widget with just the mapping
  /// you want to add between the [WidgetsApp] and its child and get the same
  /// effect.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return WidgetsApp(
  ///     shortcuts: <ShortcutActivator, Intent>{
  ///       ... WidgetsApp.defaultShortcuts,
  ///       const SingleActivator(LogicalKeyboardKey.select): const ActivateIntent(),
  ///     },
  ///     color: const Color(0xFFFF0000),
  ///     builder: (BuildContext context, Widget? child) {
  ///       return const Placeholder();
  ///     },
  ///   );
  /// }
  /// ```
  /// {@macro flutter.widgets.widgetsApp.shortcuts.seeAlso}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// {@macro flutter.widgets.widgetsApp.actions}
  /// This example shows how to add a single action handling an
  /// [ActivateAction] to the default actions without needing to
  /// add your own [Actions] widget.
  ///
  /// Alternatively, you could insert a [Actions] widget with just the mapping
  /// you want to add between the [WidgetsApp] and its child and get the same
  /// effect.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return WidgetsApp(
  ///     actions: <Type, Action<Intent>>{
  ///       ... WidgetsApp.defaultActions,
  ///       ActivateAction: CallbackAction<Intent>(
  ///         onInvoke: (Intent intent) {
  ///           // Do something here...
  ///           return null;
  ///         },
  ///       ),
  ///     },
  ///     color: const Color(0xFFFF0000),
  ///     builder: (BuildContext context, Widget? child) {
  ///       return const Placeholder();
  ///     },
  ///   );
  /// }
  /// ```
  /// {@macro flutter.widgets.widgetsApp.actions.seeAlso}
  final Map<Type, Action<Intent>>? actions;

  /// {@macro flutter.widgets.widgetsApp.restorationScopeId}
  final String? restorationScopeId;

  /// Turns on a [GridPaper] overlay that paints a baseline grid without [division]s,
  /// with [subdivision]s equal to 1 and [interval] equal to 8.
  final bool showGrid;

  /// [ScrollBehavior]s describe how [Scrollable] widgets behave. Providing
  /// a [ScrollBehavior] can set the default [ScrollPhysics] across
  /// an application, and manage [Scrollable] decorations like [Scrollbar]s and
  /// [GlowingOverscrollIndicator]s.
  ///
  /// When null, defaults to [ScrollBehavior].
  final ScrollBehavior? scrollBehavior;

  final PageRoute<T> Function<T>(RouteSettings, Widget Function(BuildContext))? pageRouteBuilder;

  @override
  State<EasyDevApp> createState() => _EasyDevAppState();
}

class _EasyDevAppState extends State<EasyDevApp> {
  late HeroController _controller;

  @override
  void initState() {
    _controller = HeroController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        widget.brightness == Brightness.light ? widget.lightThemeData : widget.darkThemeData;
    final usesRouter = widget.routerDelegate != null || widget.routerConfig != null;

    Widget? app;
    if (usesRouter) {
      app = WidgetsApp.router(
        key: GlobalObjectKey(this),
        routeInformationProvider: widget.routeInformationProvider,
        routeInformationParser: widget.routeInformationParser,
        routerDelegate: widget.routerDelegate,
        routerConfig: widget.routerConfig,
        backButtonDispatcher: widget.backButtonDispatcher,
        builder: _getWidgetsBuilder,
        title: widget.title ?? '',
        onGenerateTitle: widget.onGenerateTitle,
        textStyle: theme?.typography?.body1Style ?? const TextStyle(),
        color: widget.color ?? theme?.colorPalette.primarySwatch ?? const Color(0xFFFFFFFF),
        locale: widget.locale,
        localizationsDelegates: widget.localizationsDelegates,
        localeResolutionCallback: widget.localeResolutionCallback,
        localeListResolutionCallback: widget.localeListResolutionCallback,
        supportedLocales: widget.supportedLocales,
        showPerformanceOverlay: widget.showPerformanceOverlay,
        checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
        showSemanticsDebugger: widget.showSemanticsDebugger,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        shortcuts: widget.shortcuts,
        actions: widget.actions,
        restorationScopeId: widget.restorationScopeId,
      );
    } else {
      app = WidgetsApp(
        key: GlobalObjectKey(this),
        navigatorKey: widget.navigatorKey,
        navigatorObservers: widget.navigatorObservers!,
        home: widget.home,
        routes: widget.routes!,
        initialRoute: widget.initialRoute,
        onGenerateRoute: widget.onGenerateRoute,
        onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
        onUnknownRoute: widget.onUnknownRoute,
        onNavigationNotification: widget.onNavigationNotification,
        builder: _getWidgetsBuilder,
        title: widget.title ?? '',
        onGenerateTitle: widget.onGenerateTitle,
        textStyle: theme?.typography?.body1Style ?? const TextStyle(),
        pageRouteBuilder: widget.pageRouteBuilder ??
            <T>(RouteSettings settings, WidgetBuilder builder) {
              return PageRouteBuilder(
                settings: settings,
                pageBuilder:
                    (BuildContext context, Animation animation, Animation secondaryAnimation) =>
                        builder(context),
              );
            },
        color: widget.color ?? theme?.colorPalette.primarySwatch ?? const Color(0xFFFFFFFF),
        locale: widget.locale,
        localizationsDelegates: widget.localizationsDelegates,
        localeResolutionCallback: widget.localeResolutionCallback,
        localeListResolutionCallback: widget.localeListResolutionCallback,
        supportedLocales: widget.supportedLocales,
        showPerformanceOverlay: widget.showPerformanceOverlay,
        checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
        showSemanticsDebugger: widget.showSemanticsDebugger,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        shortcuts: widget.shortcuts,
        actions: widget.actions,
        restorationScopeId: widget.restorationScopeId,
      );
    }

    if (widget.showGrid) {
      app = GridPaper(
        interval: 8,
        subdivisions: 1,
        child: app,
      );
    }

    return ScrollConfiguration(
      behavior: widget.scrollBehavior ?? const ScrollBehavior(),
      child: HeroControllerScope(
        controller: _controller,
        child: app,
      ),
    );
  }

  Widget _getWidgetsBuilder(BuildContext context, Widget? child) {
    final theme =
        widget.brightness == Brightness.light ? widget.lightThemeData : widget.darkThemeData;
    final Color selectionColor = theme!.colorPalette.primarySwatch.withOpacity(0.40);
    final Color cursorColor = theme.colorPalette.primarySwatch;

    return EasyDevScaffoldMessenger(
      child: DefaultSelectionStyle(
        selectionColor: selectionColor,
        cursorColor: cursorColor,
        child: EasyDevTheme(
          lightThemeData: widget.lightThemeData,
          darkThemeData: widget.darkThemeData,
          usePlatformBrightness: widget.usePlatformBrightness,
          brightness: widget.brightness,
          child: widget.builder != null
              ? Builder(
                  builder: (BuildContext context) {
                    return widget.builder!(context, child);
                  },
                )
              : child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
