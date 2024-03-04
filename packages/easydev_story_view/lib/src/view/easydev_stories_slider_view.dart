import 'dart:async';

import 'package:easydev_story_view/src/model/style/easydev_story_style.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';

import 'package:easydev_story_view/src/controller/easydev_story_controller_impl.dart';
import 'package:easydev_story_view/src/model/enum/easydev_story_events.dart';
import 'package:easydev_story_view/src/model/enum/easydev_story_status.dart';
import 'package:easydev_story_view/src/model/story.dart';
import 'package:easydev_story_view/src/model/story_position.dart';
import 'package:easydev_story_view/src/util/story_data_provider.dart';
import 'package:easydev_story_view/src/view/easydev_story_view.dart';

/// Builds a story slider view.
class SliderView extends StatefulWidget {
  const SliderView({
    required this.controller,
    required this.storyBuilder,
    required this.style,
    required this.sliderBuilder,
    required this.withCloseButton,
    this.isViewedCheckList,
    super.key,
  });

  /// The builder function that will be called to build a [Story].
  /// This function can be async to provide lazy loading.
  ///
  /// Story builder returns a [Story], which is:
  final FutureOr<Story> Function(int storyIndex) storyBuilder;

  /// {@macro src/easydev_story.storyController}
  final EasyDevStoryControllerImpl controller;

  /// {@macro src/easydev_story.style}
  final EasyDevStoryStyle style;

  /// {@macro src/easydev_story.sliderBuilder}
  final Widget Function(int storyIndex) sliderBuilder;

  /// {@macro src/easydev_story.isViewedCheckList}
  final List<bool>? isViewedCheckList;

  /// {@macro src/easydev_story.withCloseButton}
  final bool withCloseButton;

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> with TickerProviderStateMixin {
  /// Controls story view position.
  late final AnimationController _posController;

  /// Used to determine whether a story can be shown or not.
  bool _canShowStory = true;

  /// {@macro src/easydev_story.isViewedCheckList}
  late List<bool> _isViewedCheckList;

  /// Opens story view and notifies listeners
  void _show(Widget view, BuildContext context, int index) async {
    _canShowStory = true;

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) => view,
    );

    widget.controller.notifyListeners(
      StoryEvent.sliderTap,
      storyIndex: index,
      contentIndex: 0,
    );
  }

  Future<void> _handleSliderTap({
    required BuildContext context,
    required Widget slider,
    required int index,
  }) async {
    if (!_canShowStory) return;
    final storyPosition = StoryPosition(0, index);

    _posController.reset();
    _canShowStory = false;
    widget.controller.positionNotifier
      ..initialPosition = storyPosition
      ..update(story: storyPosition.story, content: storyPosition.content);

    // Set story PageController to start from the given index.
    widget.controller.storyController = PageController(initialPage: storyPosition.story);

    _show(
      StoryDataProvider(
        hasSliderView: true,
        controller: widget.controller,
        storyBuilder: widget.storyBuilder,
        style: widget.style,
        withCloseButton: widget.withCloseButton,
        child: const EasyDevStoryView(),
      ),
      context,
      storyPosition.story,
    );

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _posController.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        widget.controller.positionNotifier.update(status: StoryStatus.play);
      });
    });
  }

  @override
  void initState() {
    _posController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _isViewedCheckList = widget.isViewedCheckList != null
        ? List.from(widget.isViewedCheckList!)
        : List.filled(widget.controller.storyCount, false);

    widget.controller.positionNotifier.addListener(_viewedCheck);
    super.initState();
  }

  @override
  void dispose() {
    _posController.dispose();
    widget.controller.positionNotifier.removeListener(_viewedCheck);
    super.dispose();
  }

  void _viewedCheck() {
    int storyIndex = widget.controller.positionNotifier.story;
    if (_isViewedCheckList[storyIndex]) return;

    StoryStatus status = widget.controller.positionNotifier.status;

    if (status == StoryStatus.play &&
        widget.controller.positionNotifier.content == widget.controller.contentCount - 1) {
      setState(() {
        _isViewedCheckList[storyIndex] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);
    final unwatchedIndicatorColor = widget.style.sliderStyle.unwatchedIndicatorColor ??
        (theme.brightness == Brightness.light
            ? (theme.colorPalette.secondarySwatch?[400]) ??
                theme.colorPalette.secondarySwatch ??
                lightThemeViolet400
            : (theme.colorPalette.secondarySwatch?[300]) ??
                theme.colorPalette.secondarySwatch ??
                darkThemeViolet300);
    final viewedIndicatorColor =
        widget.style.sliderStyle.viewedIndicatorColor ?? const Color(0x00000000);

    return ListView.separated(
      padding: widget.style.sliderStyle.padding,
      scrollDirection: Axis.horizontal,
      itemCount: widget.controller.storyCount,
      itemBuilder: (context, index) {
        Widget slider = widget.sliderBuilder(index);

        slider = Container(
          decoration: BoxDecoration(
            borderRadius: widget.style.sliderStyle.borderRadius,
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: widget.style.sliderStyle.borderRadius,
            border: Border.all(
              width: widget.style.sliderStyle.indicatorWidth,
              color: _isViewedCheckList[index] ? viewedIndicatorColor : unwatchedIndicatorColor,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: slider,
        );

        return GestureDetector(
          onTap: () => _handleSliderTap(
            context: context,
            slider: slider,
            index: index,
          ),
          child: slider,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        width: widget.style.sliderStyle.spacing,
        height: 0,
      ),
    );
  }
}
