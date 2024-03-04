import 'package:easydev_basics/src/widgets/easydev_appbar/easydev_appbar.dart';
import 'package:easydev_basics/src/widgets/easydev_floating_action_button/easydev_floating_action_button.dart';
import 'package:easydev_basics/src/widgets/easydev_scaffold/easydev_scaffold_messenger.dart';
import 'package:easydev_basics/src/widgets/easydev_scaffold/easydev_scaffold_feature_controller.dart';
import 'package:easydev_basics/src/widgets/easydev_scaffold/scaffold_body_builder.dart';
import 'package:easydev_basics/src/widgets/easydev_scaffold/scaffold_children.dart';
import 'package:easydev_basics/src/widgets/easydev_snackbar/easydev_snackbar.dart';
import 'package:easydev_basics/src/widgets/easydev_toast/easy_dev_toast.dart';

import 'easydev_scaffold_layout.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Close reason for [EasyDevSnackBar] and [EasyDevToast], can be closed by [timeout] if
/// duration of widget is passed, if it closed by used interaction close reason will be [action],
/// is it dismissed by user close reason will be [dismiss], if widget will be called with
/// [EasyDevScaffoldMessenger] hideCurrentSnackBar/Toast functions, close
/// reason will be [hide]. [remove] close reason is called if [EasyDevScaffoldMessenger]
/// removes current widget.
enum CloseReason {
  timeout,
  action,
  dismiss,
  hide,
  remove,
}

/// [EasyDevScaffold] is main layout widget, which slots for different widgets, such as
/// [appBar], [floatingActionButton] and [bottomNavigationBar]. [body] is main content of scaffold.
/// [EasyDevScaffold] needs to be in widget tree to use [EasyDevScaffoldMessenger] as it manipulates
/// [EasyDevScaffoldState] to show [EasyDevToast] and [EasyDevSnackBar] widgets.
///
/// This sample shows an [EasyDevScaffold] with button, that shows [EasyDevSnackBar] on
/// pressed.
///
/// See code in example/lib/pages/examples/scaffold/scaffold_example.dart
///
/// See also:
///
///  * [EasyDevScaffoldMessenger], that have methods
///  for calling [EasyDevToast] and [EasyDevSnackBar]
class EasyDevScaffold extends StatefulWidget {
  const EasyDevScaffold({
    super.key,
    this.body,
    this.backgroundColor,
    this.appBar,
    this.floatingActionButton,
    this.fabOffset,
    this.bottomNavigationBar,
    this.addAppbarColorToTop = true,
    this.resizeToAvoidBottomInset = true,
    this.addBottomNavigationBarSafeArea = true,
    this.addAppbarSafeArea = true,
    this.extendBody = false,
    this.textDirection = TextDirection.ltr,
    this.addBodySafeArea = true,
  });

  /// Main content in center of [EasyDevScaffold].
  /// Displayed below [appBar], and if [extendBody] is false below [bottomNavigationBar].
  /// if [extendBody] is true, it displayed behind [bottomNavigationBar].
  final Widget? body;

  /// Color of scaffold background
  final Color? backgroundColor;

  /// AppBar widget that placed on top of scaffold. When [addAppbarColorToTop] is true
  /// and [appBar] is [EasyDevAppBar] scaffold above appbar is colored in [EasyDevAppBar] color
  /// property.
  final PreferredSizeWidget? appBar;

  /// Floating action button widget, that placed in bottom end of screen.
  final Widget? floatingActionButton;

  /// Offset of [floatingActionButton].
  final Offset? fabOffset;

  /// Bottom navigation bar widget that positioned in bottom of screen.
  final Widget? bottomNavigationBar;

  /// Only works when child is [EasyDevAppBar]. If true color of safe area above [appBar] will
  /// be colored in [appBar] color property.
  final bool addAppbarColorToTop;

  /// If true the [body] and the scaffold's floating widgets should size
  /// themselves to avoid the onscreen keyboard whose height is defined by the
  /// ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
  final bool resizeToAvoidBottomInset;

  /// Add safe area below [bottomNavigationBar]. Defaults to true.
  final bool addBottomNavigationBarSafeArea;

  /// Add safe area above [appBar]. Defaults to true
  final bool addAppbarSafeArea;

  /// if true [body] is placed behind [bottomNavigationBar] all the way up to the bottom of screen.
  /// if false, [body] is size is limited to the top of [bottomNavigationBar].
  final bool extendBody;

  /// [TextDirection] of widget.
  final TextDirection textDirection;

  /// Adds safe area to body.
  final bool addBodySafeArea;

  @override
  State<EasyDevScaffold> createState() => EasyDevScaffoldState();
}

/// [EasyDevScaffoldState] is used by [EasyDevScaffoldMessenger] to provide current
/// [EasyDevToast] and [EasyDevSnackBar] to [EasyDevScaffold].
class EasyDevScaffoldState extends State<EasyDevScaffold> {
  final GlobalKey _bodyKey = GlobalKey();

  // Used for both the snackbar and toast APIs
  EasyDevScaffoldMessengerState? _scaffoldMessenger;

  // SNACKBAR API
  EasyDevScaffoldFeatureController<EasyDevSnackBar>? _messengerSnackBar;

  /// Do not use outside this library. It's internal scaffold method.
  void updateSnackBar() {
    final EasyDevScaffoldFeatureController<EasyDevSnackBar>? messengerSnackBar =
        _scaffoldMessenger!.snackBars.isNotEmpty ? _scaffoldMessenger!.snackBars.first : null;

    if (_messengerSnackBar != messengerSnackBar) {
      setState(() {
        _messengerSnackBar = messengerSnackBar;
      });
    }
  }

  // TOAST API
  EasyDevScaffoldFeatureController<EasyDevToast>? _messengerToast;

  /// Do not use outside this library. It's internal scaffold method.
  void updateToast() {
    final EasyDevScaffoldFeatureController<EasyDevToast>? messengerToast =
        _scaffoldMessenger!.toasts.isNotEmpty ? _scaffoldMessenger!.toasts.first : null;

    if (_messengerToast != messengerToast) {
      setState(() {
        _messengerToast = messengerToast;
      });
    }
  }

  @override
  void didChangeDependencies() {
    final EasyDevScaffoldMessengerState? currentScaffoldMessenger =
        EasyDevScaffoldMessenger.maybeOf(context);

    if (_scaffoldMessenger != null &&
        (currentScaffoldMessenger == null || _scaffoldMessenger != currentScaffoldMessenger)) {
      _scaffoldMessenger?.unregister(this);
    }
    _scaffoldMessenger = currentScaffoldMessenger;
    _scaffoldMessenger?.register(this);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    final mediaQueryData =
        MediaQuery.of(context).removeViewInsets(removeBottom: widget.resizeToAvoidBottomInset);

    final EdgeInsets minInsets = MediaQuery.paddingOf(context).copyWith(
      bottom: widget.resizeToAvoidBottomInset ? MediaQuery.viewInsetsOf(context).bottom : 0.0,
    );
    final bool extendBody = minInsets.bottom <= 0 && widget.extendBody;
    final EdgeInsets minViewPadding = MediaQuery.viewPaddingOf(context).copyWith(
      bottom: widget.resizeToAvoidBottomInset && MediaQuery.viewInsetsOf(context).bottom != 0.0
          ? 0
          : null,
    );
    final bottomPadding = mediaQueryData.viewPadding.bottom + mediaQueryData.viewInsets.bottom;
    final topPadding =
        (widget.appBar == null && widget.addBodySafeArea) ? minViewPadding.top : null;

    List<LayoutId> children = [];
    if (widget.body != null) {
      _addLayoutIds(
        children,
        ScaffoldBodyBuilder(
          extendBody: widget.extendBody,
          body: KeyedSubtree(key: _bodyKey, child: widget.body!),
          bottomInset: minInsets.bottom,
          topPadding: topPadding,
        ),
        ScaffoldChildren.body,
        removeTopPadding: widget.appBar != null,
        removeBottomPadding: widget.bottomNavigationBar == null,
        removeBottomInset: widget.resizeToAvoidBottomInset,
      );
    }
    if (widget.appBar != null) {
      _addLayoutIds(
        children,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.addAppbarSafeArea)
              Container(
                height: mediaQueryData.viewPadding.top,
                color: widget.addAppbarColorToTop
                    ? _getAppBarColor(
                        widget.appBar,
                        theme,
                      )
                    : null,
              ),
            widget.appBar!,
          ],
        ),
        ScaffoldChildren.appbar,
        removeBottomPadding: true,
      );
    }
    if (widget.bottomNavigationBar != null) {
      _addLayoutIds(
        children,
        Padding(
          padding: EdgeInsets.only(
            bottom: widget.addBottomNavigationBarSafeArea ? bottomPadding : 0,
          ),
          child: widget.bottomNavigationBar!,
        ),
        ScaffoldChildren.bottomNavigationBar,
        removeTopPadding: true,
        maintainBottomViewPadding: !widget.resizeToAvoidBottomInset,
      );
    }
    if (widget.floatingActionButton != null) {
      _addLayoutIds(
        children,
        Align(
          alignment: widget.textDirection == TextDirection.ltr
              ? Alignment.bottomRight
              : Alignment.bottomLeft,
          child: widget.floatingActionButton,
        ),
        ScaffoldChildren.fab,
        removeLeftPadding: true,
        removeTopPadding: true,
        removeRightPadding: true,
        removeBottomPadding: true,
      );
    }
    if (_messengerSnackBar != null) {
      _addLayoutIds(
        children,
        _messengerSnackBar!.widget,
        ScaffoldChildren.snackBar,
        removeLeftPadding: true,
        removeTopPadding: true,
        removeRightPadding: true,
        removeBottomPadding: true,
      );
    }
    if (_messengerToast != null) {
      _addLayoutIds(
        children,
        _messengerToast!.widget,
        ScaffoldChildren.toast,
        removeLeftPadding: true,
        removeTopPadding: true,
        removeRightPadding: true,
        removeBottomPadding: true,
      );
    }

    return Container(
      color: widget.backgroundColor ?? theme.colorPalette.greySwatch.backgroundColor,
      child: CustomMultiChildLayout(
        delegate: EasyDevScaffoldLayout(
          minInsets: minInsets,
          textDirection: widget.textDirection,
          extendBody: extendBody,
          minViewPadding: minViewPadding,
          fabOffset: widget.fabOffset ??
              Offset(
                -(_getFabSize(widget.floatingActionButton) / 2),
                -bottomPadding - 16,
              ),
          addBodySafeArea: widget.addBodySafeArea,
        ),
        children: children,
      ),
    );
  }

  Color _getAppBarColor(
    Widget? appbar,
    EasyDevThemeData theme,
  ) {
    if (appbar is EasyDevAppBar) {
      return appbar.backgroundColor ?? widget.backgroundColor ?? theme.brightness.surfaceColor;
    }

    return widget.backgroundColor ?? theme.brightness.surfaceColor;
  }

  double _getFabSize(Widget? floatingActionButton) {
    if (floatingActionButton is EasyDevFloatingActionButton) {
      final theme = context.easyDevTheme;
      if (floatingActionButton.isLarge) {
        return theme.floatingActionButtonTheme?.largeButtonSize ?? 56;
      } else {
        return theme.floatingActionButtonTheme?.smallButtonSize ?? 40;
      }
    }
    return 24;
  }

  void _addLayoutIds(
    List<LayoutId> children,
    Widget? child,
    ScaffoldChildren childId, {
    bool removeLeftPadding = false,
    bool removeTopPadding = false,
    bool removeRightPadding = false,
    bool removeBottomPadding = false,
    bool removeBottomInset = false,
    bool maintainBottomViewPadding = false,
  }) {
    MediaQueryData data = MediaQuery.of(context).removePadding(
      removeLeft: removeLeftPadding,
      removeTop: removeTopPadding,
      removeRight: removeRightPadding,
      removeBottom: removeBottomPadding,
    );
    if (removeBottomInset) {
      data = data.removeViewInsets(removeBottom: true);
    }

    if (maintainBottomViewPadding && data.viewInsets.bottom != 0.0) {
      data = data.copyWith(
        padding: data.padding.copyWith(bottom: data.viewPadding.bottom),
      );
    }

    if (child != null) {
      children.add(
        LayoutId(
          id: childId,
          child: MediaQuery(data: data, child: child),
        ),
      );
    }
  }

  @override
  void dispose() {
    _scaffoldMessenger?.unregister(this);
    super.dispose();
  }
}
