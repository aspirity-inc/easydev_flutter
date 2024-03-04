import 'dart:math' as math;

import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

import 'package:easydev_base_ui/src/widgets/tabs/animations/easydev_change_animation.dart';
import 'package:easydev_base_ui/src/widgets/tabs/animations/easydev_drag_animation.dart';
import 'package:easydev_base_ui/src/widgets/tabs/easydev_tab_controller.dart';
import 'package:easydev_base_ui/src/widgets/tabs/easydev_tab_label_bar.dart';
import 'package:easydev_base_ui/src/widgets/tabs/easydev_tab_label_style.dart';
import 'package:easydev_base_ui/src/widgets/tabs/enums/tabbar_idicator_type.dart';
import 'package:easydev_base_ui/src/widgets/tabs/indicators/easydev_filled_tab_indicator.dart';
import 'package:easydev_base_ui/src/widgets/tabs/indicators/easydev_underline_tab_indicator.dart';
import 'package:easydev_base_ui/src/widgets/tabs/painters/easydev_filled_border_painter.dart';
import 'package:easydev_base_ui/src/widgets/tabs/painters/easydev_indicator_painter.dart';
import 'package:easydev_base_ui/src/widgets/tabs/easydev_tab.dart';
import 'package:easydev_base_ui/src/widgets/tabs/easydev_tabbar_view.dart';

const double _defaultTabHeight = 46.0;

/// The [EasyDevTabBar] facilitates the creation of tab bars with different indicator styles and customization options.
/// Such indicator types as including underline or filled can be chosen, by using the [indicatorType] parameter.
/// The tabs themselves are defined by providing a list of [tabs], typically instances of [EasyDevTab].
/// [EasyDevTabController] must be passes to [controller], which length is equal to [tabs.length].
/// Note that you must pass [TickerProvider] to [EasyDevTabController]. For this you can mix your stateful widget with [TickerProviderStateMixin].
/// The [onTap] callback allows for additional actions when tabs are tapped.
/// Other fields can be used to change [EasyDevTabBar] appearence.
///
///
/// Example of using [EasyDevTabBar.filled] and [EasyDevTabBar.underline].
/// ```dart
/// class EasyDevTabBarExample extends StatefulWidget {
///   const EasyDevTabBarExample({Key? key}) : super(key: key);
///
///   @override
///   State<EasyDevTabBarExample> createState() => _EasyDevTabBarExampleState();
/// }
///
/// class _EasyDevTabBarExampleState extends State<EasyDevTabBarExample> with TickerProviderStateMixin {
///   late final EasyDevTabController _tabController4;
///   late final List<Widget> _tabs;
///
///   @override
///   void initState() {
///     super.initState();
///     _tabController4 = EasyDevTabController(length: 4, vsync: this);
///     _tabs = [
///       const EasyDevTab(
///         text: "Label",
///       ),
///       const EasyDevTab(
///         text: "Label",
///       ),
///       const EasyDevTab(
///         text: "Label",
///       ),
///       const EasyDevTab(
///         text: "Label",
///       ),
///     ];
///   }
///
///   @override
///   void dispose() {
///     _tabController4.dispose();
///     super.dispose();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return EasyDevScaffold(
///       body: ListView(
///         children: [
///           EasyDevTabBar.underline(
///             controller: _tabController4,
///             tabs: _tabs,
///           ),
///           EasyDevTabBar.filled(
///             controller: _tabController4,
///             tabs: _tabs,
///           ),
///         ],
///       ),
///     );
/// ```
///
///
/// This sample produces variant of RawModalWidget.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_tab_bar_example.dart
class EasyDevTabBar extends StatefulWidget implements PreferredSizeWidget {
  const EasyDevTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.padding,
    this.indicatorType,
    this.selectedIndicator,
    this.selectedIndicatorColor,
    this.unselectedIndicator,
    this.unselectedIndicatorColor,
    this.indicatorWeight = 1.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.selectedLabelColor,
    this.selectedLabelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dividerColor,
    this.onTap,
  }) : assert(selectedIndicator != null || (indicatorWeight > 0.0));

  /// Creates a tab bar with underline tabs indicator.
  const EasyDevTabBar.underline({
    super.key,
    required this.tabs,
    this.controller,
    this.padding,
    this.selectedIndicator,
    this.selectedIndicatorColor,
    this.unselectedIndicator,
    this.unselectedIndicatorColor,
    this.indicatorWeight = 4.0,
    this.indicatorPadding = const EdgeInsets.only(left: 12, right: 12, bottom: 6),
    this.selectedLabelColor,
    this.selectedLabelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dividerColor,
    this.onTap,
  })  : assert(selectedIndicator != null || (indicatorWeight > 0.0)),
        indicatorType = TabsIndicatorType.underline;

  /// Creates a tab bar with filled tabs indicator.
  const EasyDevTabBar.filled({
    super.key,
    required this.tabs,
    this.controller,
    this.padding,
    this.selectedIndicator,
    this.selectedIndicatorColor,
    this.unselectedIndicatorColor,
    this.indicatorWeight = 1.0,
    this.selectedLabelColor,
    this.selectedLabelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dividerColor,
    this.onTap,
  })  : assert(selectedIndicator != null || (indicatorWeight > 0.0)),
        unselectedIndicator = null,
        indicatorPadding = EdgeInsets.zero,
        indicatorType = TabsIndicatorType.filled;

  /// List of two or more [EasyDevTab] widgets
  /// The length of this list must match the [controller]'s [EasyDevTabController.length]
  /// and the length of the [EasyDevTabBarView.children] list.
  final List<Widget> tabs;

  /// This widget's selection and animation state.
  final EasyDevTabController? controller;

  /// Padding of [EasyDevTabBar].
  final EdgeInsetsGeometry? padding;

  /// Indicator color when selected.
  final Color? selectedIndicatorColor;

  /// Indicator color when unselected.
  final Color? unselectedIndicatorColor;

  /// Weight of indicator.
  final double indicatorWeight;

  /// The thickness of the line then indicator is [TabsIndicatorType.underline]
  /// and the thickness of the tab bar border then indicator is [TabsIndicatorType.filled].
  final EdgeInsetsGeometry indicatorPadding;

  /// Defines the appearance of the selected tab indicator.
  final Decoration? selectedIndicator;

  /// Defines the appearance of the unselected tab indicator.
  final Decoration? unselectedIndicator;

  /// Type of indicator.
  final TabsIndicatorType? indicatorType;

  /// An optional callback that's called when the [EasyDevTabBar] is tapped.
  final ValueChanged<int>? onTap;

  /// The color of the divider under the [EasyDevTabBar].
  final Color? dividerColor;

  /// Color of selected tab labels.
  final Color? selectedLabelColor;

  /// Color of unselected tab labels.
  final Color? unselectedLabelColor;

  /// TextStyle of selected tab labels.
  final TextStyle? selectedLabelStyle;

  /// TextStyle of unselected tab labels.
  final TextStyle? unselectedLabelStyle;

  /// The padding added to each of the tab labels.
  final EdgeInsetsGeometry? labelPadding;

  @override
  Size get preferredSize {
    double maxHeight = _defaultTabHeight;
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        final double itemHeight = item.preferredSize.height;
        maxHeight = math.max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(maxHeight + indicatorWeight);
  }

  @override
  State<EasyDevTabBar> createState() => _EasyDevTabBarState();
}

class _EasyDevTabBarState extends State<EasyDevTabBar> {
  EasyDevTabController? _controller;
  EasyDevIndicatorPainter? _indicatorPainter;
  EasyDevFilledBorderPainter? _filledBorderPainter;
  int? _currentIndex;
  late List<GlobalKey> _tabKeys;
  late List<EdgeInsetsGeometry> _labelPaddings;

  @override
  void initState() {
    super.initState();
    _tabKeys = widget.tabs.map((Widget tab) => GlobalKey()).toList();
    _labelPaddings = List<EdgeInsetsGeometry>.filled(
      widget.tabs.length,
      EdgeInsets.zero,
      growable: true,
    );
  }

  EasyDevTabsThemeData get _defaultTabBarTheme {
    final theme = EasyDevTheme.of(context);
    final bool isFilledType = widget.indicatorType == TabsIndicatorType.filled;
    return EasyDevTabsThemeData(
      selectedIndicatorColor: theme.brightness == Brightness.light
          ? (isFilledType
              ? (theme.colorPalette.secondarySwatch?[300]) ?? lightThemeViolet300
              : (theme.colorPalette.secondarySwatch?[500]) ?? lightThemeViolet500)
          : (theme.colorPalette.tertiarySwatch?[400]) ?? darkThemeLilac400,
      unselectedIndicatorColor: isFilledType
          ? (theme.brightness == Brightness.light
              ? (theme.colorPalette.secondarySwatch?[300]) ?? lightThemeViolet300
              : (theme.colorPalette.secondarySwatch?[100]) ?? lightThemeViolet100)
          : theme.colorPalette.greySwatch.unselectedColor ??
              theme.colorPalette.greySwatch.greyColor,
      selectedLabelColor: (theme.brightness == Brightness.light
          ? theme.colorPalette.greySwatch.onSurfaceBright
          : (isFilledType
              ? theme.colorPalette.greySwatch.backgroundColor ??
                  theme.colorPalette.greySwatch.greyColor
              : theme.colorPalette.greySwatch.dividerColor ??
                  theme.colorPalette.greySwatch.greyColor)),
      unselectedLabelColor: (theme.brightness == Brightness.light
          ? (isFilledType
              ? (theme.colorPalette.secondarySwatch?[300]) ?? theme.colorPalette.secondarySwatch
              : theme.colorPalette.greySwatch.disabledColor ??
                  theme.colorPalette.greySwatch.greyColor)
          : (isFilledType
              ? (theme.colorPalette.secondarySwatch?[300])
              : theme.colorPalette.greySwatch.unselectedColor ??
                  theme.colorPalette.greySwatch.greyColor)),
      selectedLabelStyle: theme.typography?.subheading2Style ?? const TextStyle(),
      unselectedLabelStyle: theme.typography?.subheading2Style ?? const TextStyle(),
      indicatorWidth: isFilledType ? 2 : 4,
    );
  }

  Decoration _getSelectedIndicator() {
    final theme = context.easyDevTheme;
    final tabBarTheme = context.easyDevTheme.tabsTheme;

    if (widget.selectedIndicator != null) {
      return widget.selectedIndicator!;
    }
    if (tabBarTheme?.selectedIndicator != null) {
      return tabBarTheme!.selectedIndicator!;
    }

    Color selectedIndicatorColor = widget.selectedIndicatorColor ??
        tabBarTheme?.selectedIndicatorColor ??
        _defaultTabBarTheme.selectedIndicatorColor ??
        (theme.brightness == Brightness.light
            ? (widget.indicatorType == TabsIndicatorType.underline
                ? (theme.colorPalette.secondarySwatch?[500]) ?? lightThemeViolet500
                : theme.colorPalette.secondarySwatch?[300] ?? lightThemeViolet300)
            : theme.colorPalette.tertiarySwatch?[400] ?? darkThemeLilac400);

    if (widget.indicatorType == TabsIndicatorType.filled) {
      return FilledTabIndicator(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: selectedIndicatorColor,
      );
    } else {
      return UnderlineTabIndicator(
        borderRadius: const BorderRadius.all(
          Radius.circular(1),
        ),
        borderSide: BorderSide(
          width: widget.indicatorWeight,
          color: selectedIndicatorColor,
        ),
      );
    }
  }

  Decoration? _getUnselectedIndicator() {
    final theme = context.easyDevTheme;
    final tabBarTheme = context.easyDevTheme.tabsTheme;

    if (widget.unselectedIndicator != null) {
      return widget.unselectedIndicator;
    }
    if (tabBarTheme?.unselectedIndicator != null) {
      return tabBarTheme!.unselectedIndicator;
    }

    if (widget.indicatorType == TabsIndicatorType.underline) {
      Color unSelectedIndicatorColor = widget.unselectedIndicatorColor ??
          tabBarTheme?.unselectedIndicatorColor ??
          _defaultTabBarTheme.unselectedIndicatorColor ??
          theme.colorPalette.greySwatch.greyColor;

      return UnderlineTabIndicator(
        borderRadius: const BorderRadius.all(
          Radius.circular(1),
        ),
        borderSide: BorderSide(
          width: widget.indicatorWeight,
          color: unSelectedIndicatorColor,
        ),
      );
    }
    return null;
  }

  bool get _controllerIsValid => _controller?.animation != null;

  void _updateTabController() {
    final EasyDevTabController? newController =
        widget.controller ?? EasyDevDefaultTabController.maybeOf(context);
    assert(() {
      if (newController == null) {
        throw FlutterError(
            'No EasyDevTabController or EasyDevDefaultTabController for ${widget.runtimeType}.');
      }
      return true;
    }());

    if (newController == _controller) {
      return;
    }
    if (_controllerIsValid) {
      _controller!.removeListener(_handleTabControllerTick);
    }
    _controller = newController;
    if (_controller != null) {
      _currentIndex = _controller!.index;
      _controller!.addListener(_handleTabControllerTick);
    }
  }

  void _initIndicatorPainter() {
    final tabBarTheme = context.easyDevTheme.tabsTheme;
    _indicatorPainter = !_controllerIsValid
        ? null
        : EasyDevIndicatorPainter(
            controller: _controller!,
            selectedIndicator: _getSelectedIndicator(),
            indicatorPadding: widget.indicatorPadding,
            unselectedIndicator: _getUnselectedIndicator(),
            tabKeys: _tabKeys,
            old: _indicatorPainter,
            dividerColor: widget.dividerColor ?? tabBarTheme?.dividerColor,
          );
  }

  void _initFilledBorderPainter() {
    final tabBarTheme = context.easyDevTheme.tabsTheme;
    _filledBorderPainter = !_controllerIsValid
        ? null
        : EasyDevFilledBorderPainter(
            controller: _controller!,
            tabKeys: _tabKeys,
            indicatorRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            selectedIndicator: _getSelectedIndicator(),
            borderSide: BorderSide(
              width: widget.indicatorWeight,
              color: widget.unselectedIndicatorColor ??
                  tabBarTheme?.unselectedIndicatorColor ??
                  _defaultTabBarTheme.unselectedIndicatorColor!,
            ),
            old: _filledBorderPainter,
            indicatorPadding: widget.indicatorPadding,
          );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
    _initIndicatorPainter();
    _initFilledBorderPainter();
  }

  @override
  void didUpdateWidget(EasyDevTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
      _initIndicatorPainter();
      _initFilledBorderPainter();
    } else if (widget.selectedIndicatorColor != oldWidget.selectedIndicatorColor ||
        widget.indicatorWeight != oldWidget.indicatorWeight ||
        widget.indicatorPadding != oldWidget.indicatorPadding ||
        widget.selectedIndicator != oldWidget.selectedIndicator) {
      _initIndicatorPainter();
      _initFilledBorderPainter();
    }

    if (widget.tabs.length > _tabKeys.length) {
      final int delta = widget.tabs.length - _tabKeys.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
      _labelPaddings.addAll(List<EdgeInsetsGeometry>.filled(delta, EdgeInsets.zero));
    } else if (widget.tabs.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.tabs.length, _tabKeys.length);
      _labelPaddings.removeRange(widget.tabs.length, _tabKeys.length);
    }
  }

  @override
  void dispose() {
    _indicatorPainter!.dispose();
    _filledBorderPainter!.dispose();
    if (_controllerIsValid) {
      _controller!.removeListener(_handleTabControllerTick);
    }
    _controller = null;
    super.dispose();
  }

  int get maxTabIndex => _indicatorPainter!.maxTabIndex;

  // Called each time layout completes.
  void _saveTabOffsets(List<double> tabOffsets, TextDirection textDirection, double width) {
    _indicatorPainter?.saveTabOffsets(tabOffsets, textDirection);
    _filledBorderPainter?.saveTabOffsets(tabOffsets, textDirection);
  }

  void _handleTap(int index) {
    _controller!.animateTo(index);
    widget.onTap?.call(index);
  }

  Widget _buildStyledTab(
      Widget child, bool isSelected, Animation<double> animation, EasyDevTabsThemeData defaults) {
    return EasyDevTabLabelStyle(
      animation: animation,
      isSelected: isSelected,
      selectedLabelColor: widget.selectedLabelColor,
      unselectedLabelColor: widget.unselectedLabelColor,
      selectedLabelStyle: widget.selectedLabelStyle,
      unselectedLabelStyle: widget.unselectedLabelStyle,
      defaultTheme: defaults,
      indicatorType: widget.indicatorType ?? TabsIndicatorType.underline,
      child: child,
    );
  }

  void _handleTabControllerTick() {
    if (_controller!.index != _currentIndex) {
      _currentIndex = _controller!.index;
    }
    setState(() {
      // Rebuild the tabs after a index change has completed.
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller!.length == 0) {
      return Container(
        height: _defaultTabHeight + widget.indicatorWeight,
      );
    }

    final tabBarTheme = context.easyDevTheme.tabsTheme;

    final List<Widget> wrappedTabs = List<Widget>.generate(widget.tabs.length, (int index) {
      _labelPaddings[index] = widget.labelPadding ??
          tabBarTheme?.labelPadding ??
          const EdgeInsets.symmetric(horizontal: 16.0);

      return Center(
        heightFactor: 1.0,
        child: Padding(
          padding: _labelPaddings[index],
          child: KeyedSubtree(
            key: _tabKeys[index],
            child: widget.tabs[index],
          ),
        ),
      );
    });

    if (_controller != null) {
      final int previousIndex = _controller!.previousIndex;

      if (_controller!.indexIsChanging) {
        // The user tapped on a tab, the tab controller's animation is running.
        final Animation<double> animation = ChangeAnimation(_controller!);
        wrappedTabs[_currentIndex!] =
            _buildStyledTab(wrappedTabs[_currentIndex!], true, animation, _defaultTabBarTheme);
        wrappedTabs[previousIndex] =
            _buildStyledTab(wrappedTabs[previousIndex], false, animation, _defaultTabBarTheme);
      } else {
        // The user is dragging the EasyDevTabBarView's PageView.
        final int tabIndex = _currentIndex!;
        final Animation<double> centerAnimation = DragAnimation(_controller!, tabIndex);
        wrappedTabs[tabIndex] =
            _buildStyledTab(wrappedTabs[tabIndex], true, centerAnimation, _defaultTabBarTheme);
        if (_currentIndex! > 0) {
          final int tabIndex = _currentIndex! - 1;
          final Animation<double> previousAnimation =
              ReverseAnimation(DragAnimation(_controller!, tabIndex));
          wrappedTabs[tabIndex] =
              _buildStyledTab(wrappedTabs[tabIndex], false, previousAnimation, _defaultTabBarTheme);
        }
        if (_currentIndex! < widget.tabs.length - 1) {
          final int tabIndex = _currentIndex! + 1;
          final Animation<double> nextAnimation =
              ReverseAnimation(DragAnimation(_controller!, tabIndex));
          wrappedTabs[tabIndex] =
              _buildStyledTab(wrappedTabs[tabIndex], false, nextAnimation, _defaultTabBarTheme);
        }
      }
    }

    for (int index = 0; index < widget.tabs.length; index += 1) {
      wrappedTabs[index] = GestureDetector(
        onTap: () {
          _handleTap(index);
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.only(bottom: widget.indicatorWeight),
          child: wrappedTabs[index],
        ),
      );

      wrappedTabs[index] = Expanded(
        child: EasyDevTabLabelStyle(
          animation: kAlwaysDismissedAnimation,
          isSelected: _currentIndex == index,
          selectedLabelColor: widget.selectedLabelColor,
          unselectedLabelColor: widget.unselectedLabelColor,
          selectedLabelStyle: widget.selectedLabelStyle,
          unselectedLabelStyle: widget.unselectedLabelStyle,
          defaultTheme: _defaultTabBarTheme,
          indicatorType: widget.indicatorType ?? TabsIndicatorType.underline,
          child: wrappedTabs[index],
        ),
      );
    }

    Widget tabBar = widget.indicatorType == TabsIndicatorType.filled
        ? CustomPaint(
            painter: _filledBorderPainter,
            child: CustomPaint(
              painter: _indicatorPainter,
              child: TabLabelBar(
                onPerformLayout: _saveTabOffsets,
                children: wrappedTabs,
              ),
            ),
          )
        : CustomPaint(
            painter: _indicatorPainter,
            child: TabLabelBar(
              onPerformLayout: _saveTabOffsets,
              children: wrappedTabs,
            ),
          );

    if (widget.padding != null) {
      tabBar = Padding(
        padding: widget.padding!,
        child: tabBar,
      );
    }

    return tabBar;
  }
}
