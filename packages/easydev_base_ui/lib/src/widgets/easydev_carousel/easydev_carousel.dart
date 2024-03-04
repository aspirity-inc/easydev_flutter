import 'package:easydev_base_ui/src/widgets/easydev_carousel/carousel_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

/// The [EasyDevCarousel] facilitates the display of a carousel of items,
/// offering flexibility and customization. List of [children] can be provided directly
/// or [EasyDevCarousel.builder] can be used for dynamic content generation.
/// [EasyDevCarousel] is a wrapper over [PageView], so most of its fields are available through [EasyDevCarousel].
///
/// [CarouselIndicator] can be hid or shown with [showIndicator].
/// [indicatorAnimationDuration], [selectedIndicatorColor] and [unselectedIndicatorColor]
/// can be used to change [EasyDevCarousel] appearence.
///
///
///
/// Example of using [EasyDevCarousel] with children.
/// ```dart
/// EasyDevCarousel(
///   physics: const BouncingScrollPhysics(),
///   children: [
///     Text(
///       'Slide 1',
///     ),
///     Text(
///       'Slide 2',
///     ),
///     Text(
///       'Slide 3',
///     ),
///     Text(
///       'Slide 4',
///     ),
///   ],
/// ),
/// ```
///
/// Example of using [EasyDevCarousel] with builder.
/// ```dart
/// EasyDevCarousel.builder(
///   itemBuilder: (context, index) => items[index % 4],
///   indicatorCount: 4,
/// ),
/// ```
///
///
/// This sample produces variants of EasyDevCarousel.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_carousel_example.dart
class EasyDevCarousel extends StatefulWidget {
  /// Create a carousel.
  const EasyDevCarousel({
    super.key,
    required this.children,
    this.showIndicator = true,
    this.reverse = false,
    this.controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.scrollBehavior,
    this.padEnds = true,
    this.indicatorAnimationDuration,
    this.selectedIndicatorColor,
    this.unselectedIndicatorColor,
  })  : assert(children != null),
        itemBuilder = null,
        findChildIndexCallback = null,
        itemCount = null,
        indicatorCount = children?.length;

  /// Create a carousel with builder for items.
  const EasyDevCarousel.builder({
    super.key,
    required this.itemBuilder,
    this.findChildIndexCallback,
    this.itemCount,
    this.indicatorCount,
    this.showIndicator = true,
    this.reverse = false,
    this.controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.scrollBehavior,
    this.padEnds = true,
    this.indicatorAnimationDuration,
    this.selectedIndicatorColor,
    this.unselectedIndicatorColor,
  })  : assert(itemBuilder != null),
        children = null;

  /// Children of carousel without builder.
  final List<Widget>? children;

  /// Item builder when carousel is using builder constructor.
  final NullableIndexedWidgetBuilder? itemBuilder;

  /// Called to find the new index of a child based on its key in case of reordering.
  final ChildIndexGetter? findChildIndexCallback;

  /// Item count of carousel when builder is used.
  final int? itemCount;

  /// Indicator count when itemCount is not used.
  final int? indicatorCount;

  /// Whether indicator is shown.
  final bool showIndicator;

  /// {@macro flutter.widgets.PageView.allowImplicitScrolling}
  final bool allowImplicitScrolling;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// Whether the page view scrolls in the reading direction.
  final bool reverse;

  /// An object that can be used to control the position to which this page
  /// view is scrolled.
  final PageController? controller;

  /// How the page view should respond to user input.
  final ScrollPhysics? physics;

  /// Shows whether page will snap to center.
  final bool pageSnapping;

  /// Called whenever the page in the center of the viewport changes.
  final ValueChanged<int>? onPageChanged;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.widgets.shadow.scrollBehavior}
  final ScrollBehavior? scrollBehavior;

  /// Whether to add padding to both ends of the list.
  final bool padEnds;

  /// Duration for changing colors for indicator.
  final Duration? indicatorAnimationDuration;

  /// Color of selected indicator.
  final Color? selectedIndicatorColor;

  /// Color of unselected indicators.
  final Color? unselectedIndicatorColor;

  @override
  State<EasyDevCarousel> createState() => _EasyDevCarouselState();
}

class _EasyDevCarouselState extends State<EasyDevCarousel> {
  late Color? _selectedIndicatorColor;
  late Color? _unselectedIndicatorColor;
  late Duration _indicatorAnimationDuration;
  late int selectedIndicator;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setAndUpdateFields();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    setAndUpdateFields();
  }

  void setAndUpdateFields() {
    final theme = EasyDevTheme.of(context);
    final colorPalette = theme.colorPalette;
    final carouselTheme = theme.carouselTheme;

    _selectedIndicatorColor = widget.selectedIndicatorColor ??
        carouselTheme?.selectedIndicatorColor ??
        (theme.brightness == Brightness.light
            ? (colorPalette.tertiarySwatch?[500])
            : colorPalette.secondarySwatch?[500]);

    _unselectedIndicatorColor = widget.unselectedIndicatorColor ??
        carouselTheme?.selectedIndicatorColor ??
        (theme.brightness == Brightness.light
            ? colorPalette.greySwatch.disabledColor
            : colorPalette.greySwatch.greyColor);

    _indicatorAnimationDuration = widget.indicatorAnimationDuration ??
        carouselTheme?.indicatorAnimationDuration ??
        const Duration(milliseconds: 300);
  }

  @override
  void initState() {
    selectedIndicator = widget.controller?.initialPage ?? 0;
    final indicatorCount = widget.indicatorCount ?? widget.itemCount;

    selectedIndicator = selectedIndicator > (indicatorCount ?? 0)
        ? selectedIndicator % (indicatorCount ?? 1)
        : selectedIndicator;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.children != null
            ? Expanded(
                child: PageView(
                  allowImplicitScrolling: widget.allowImplicitScrolling,
                  restorationId: widget.restorationId,
                  reverse: widget.reverse,
                  controller: widget.controller,
                  physics: widget.physics,
                  pageSnapping: widget.pageSnapping,
                  onPageChanged: (value) {
                    widget.onPageChanged?.call(value);
                    setState(() {
                      selectedIndicator = value;
                    });
                  },
                  dragStartBehavior: widget.dragStartBehavior,
                  clipBehavior: widget.clipBehavior,
                  scrollBehavior: widget.scrollBehavior,
                  padEnds: widget.padEnds,
                  children: widget.children!,
                ),
              )
            : Expanded(
                child: PageView.builder(
                  itemBuilder: widget.itemBuilder!,
                  itemCount: widget.itemCount,
                  findChildIndexCallback: widget.findChildIndexCallback,
                  allowImplicitScrolling: widget.allowImplicitScrolling,
                  restorationId: widget.restorationId,
                  reverse: widget.reverse,
                  controller: widget.controller,
                  physics: widget.physics,
                  pageSnapping: widget.pageSnapping,
                  onPageChanged: (value) {
                    widget.onPageChanged?.call(value);
                    setState(() {
                      selectedIndicator = value % (widget.indicatorCount ?? widget.itemCount ?? 1);
                    });
                  },
                  dragStartBehavior: widget.dragStartBehavior,
                  clipBehavior: widget.clipBehavior,
                  scrollBehavior: widget.scrollBehavior,
                  padEnds: widget.padEnds,
                ),
              ),
        if ((widget.indicatorCount ?? widget.itemCount) != null && widget.showIndicator) ...[
          const SizedBox(
            height: 16,
          ),
          CarouselIndicator(
            pageCount: widget.indicatorCount ?? widget.itemCount ?? 0,
            selectedIndicatorColor: _selectedIndicatorColor,
            unselectedIndicatorColor: _unselectedIndicatorColor,
            selectedPage: selectedIndicator,
            indicatorAnimationDuration: _indicatorAnimationDuration,
          ),
        ]
      ],
    );
  }
}
