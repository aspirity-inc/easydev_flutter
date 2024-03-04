import 'package:easydev_base_ui/src/widgets/modal_widgets/show_modal_widget/modal_widget_route.dart';
import 'package:flutter/widgets.dart';

/// The [RawModalWidget] facilitates the creation of customizable modal dialogs,
/// triggered by tapping a specified [child] widget. To specify the content of the modal dialog
/// [modalWidget] parameter must be used.
///
/// The [onTap] callback can be used to trigger additional actions upon tapping the [child] widget.
/// The [valueChanged] callback is invoked when the modal dialog is dismissed,
/// providing a mechanism for passing data back to the parent widget. [barrierDismissible] can be used to
/// control whether the modal dialog can be dismissed by clicking outside it.
///
/// Note that this widget must be wrapped in [EasyDevScaffold] or [Scaffold]
/// to function properly.
///
///
/// Example of using [RawModalWidget].
/// ```dart
/// Widget build(BuildContext context) {
///     final theme = context.easyDevTheme;
///     return EasyDevScaffold(
///       body: Center(
///         child: RawModalWidget(
///           modalWidget: Container(
///             constraints: BoxConstraints(
///               maxWidth: MediaQuery.of(context).size.width * 0.5,
///             ),
///             decoration: const BoxDecoration(
///               borderRadius: BorderRadius.all(Radius.circular(16)),
///             ),
///             child: ListView(
///               shrinkWrap: true,
///               physics: const NeverScrollableScrollPhysics(),
///               children: [
///                 GestureDetector(
///                   onTap: Navigator.of(context).pop,
///                   child: Container(
///                     height: 30,
///                     width: 50,
///                     margin: const EdgeInsets.only(bottom: 5),
///                     decoration: BoxDecoration(
///                       borderRadius: const BorderRadius.all(Radius.circular(16)),
///                       color: theme.colorPalette.greySwatch.onSurfaceColor,
///                     ),
///                     child: const Center(
///                       child: Text('Action 1'),
///                     ),
///                   ),
///                 ),
///                 GestureDetector(
///                   onTap: Navigator.of(context).pop,
///                   child: Container(
///                     height: 30,
///                     width: 50,
///                     margin: const EdgeInsets.only(bottom: 5),
///                     decoration: BoxDecoration(
///                       borderRadius: const BorderRadius.all(Radius.circular(16)),
///                       color: theme.colorPalette.greySwatch.onSurfaceColor,
///                     ),
///                     child: const Center(
///                       child: Text('Action 2'),
///                     ),
///                   ),
///                 ),
///                 GestureDetector(
///                   onTap: Navigator.of(context).pop,
///                   child: Container(
///                     height: 30,
///                     width: 50,
///                     decoration: BoxDecoration(
///                       borderRadius: const BorderRadius.all(Radius.circular(16)),
///                      color: theme.colorPalette.greySwatch.onSurfaceColor,
///                     ),
///                     child: const Center(
///                       child: Text('Action 3'),
///                     ),
///                   ),
///                 ),
///               ],
///             ),
///           ),
///           valueChanged: (_) {},
///           correctPosition: true,
///           child: const Icon(
///             CommunityMaterialIcons.dots_vertical,
///           ),
///         ),
///       ),
///     );
/// ```
///
///
/// This sample produces variant of RawModalWidget.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_raw_modal_widget_example.dart
class RawModalWidget<T> extends StatefulWidget {
  const RawModalWidget({
    super.key,
    required this.child,
    required this.modalWidget,
    required this.valueChanged,
    this.modalAlignment = Alignment.bottomCenter,
    this.modalOffset = Offset.zero,
    this.barrierDismissible = true,
    this.centered = false,
    this.barrierColor,
    this.focusNode,
    this.onTap,
    this.correctPosition = false,
    this.blurBackground = false,
  });

  /// Widget that can be clicked to show modal dialog. Wrapped in [IgnorePointer].
  final Widget child;

  /// Widget that shown after tapping on [child].
  final Widget modalWidget;

  /// Call back called after tapping on child.
  final VoidCallback? onTap;

  /// Callback is called on popping route with value.
  final ValueChanged<T> valueChanged;

  /// Offset of [modalWidget].
  final Offset modalOffset;

  /// Whether barrier can be dismissed by clicking outside of modal.
  final bool barrierDismissible;

  /// Whether modal widget is placed on horizontal center of [child].
  final bool centered;

  /// [FocusNode] of widget.
  final FocusNode? focusNode;

  /// [Alignment] of [modalWidget].
  final Alignment modalAlignment;

  /// [Color] outside of [modalWidget].
  final Color? barrierColor;

  /// Whether modal widget will not be placed outside of the screen.
  final bool correctPosition;

  /// If true, space behind the [modalWidget] will be blurred
  final bool blurBackground;

  @override
  State<RawModalWidget<T>> createState() => _RawModalWidgetState<T>();
}

class _RawModalWidgetState<T> extends State<RawModalWidget<T>> {
  late FocusNode focusNode;
  ModalWidgetRoute<T>? _modalRoute;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();

    super.initState();
  }

  void _handleTap() {
    final NavigatorState navigator = Navigator.of(context);
    assert(_modalRoute == null);
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(
          widget.modalOffset,
          ancestor: navigator.context.findRenderObject(),
        ) &
        itemBox.size;

    _modalRoute = ModalWidgetRoute<T>(
      rect: itemRect,
      modalAlignment: widget.modalAlignment,
      modalOffset: widget.modalOffset,
      barrierDismissible: widget.barrierDismissible,
      barrierColor: widget.barrierColor,
      child: widget.modalWidget,
      centered: widget.centered,
      correctPosition: widget.correctPosition,
      blurBackground: widget.blurBackground,
    );

    focusNode.requestFocus();
    navigator.push(_modalRoute!).then<void>((T? newValue) {
      _modalRoute?.dismiss();
      _modalRoute = null;
      if (!mounted || newValue == null) {
        return;
      }
      widget.valueChanged.call(newValue);
    });
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: IgnorePointer(
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _modalRoute?.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
