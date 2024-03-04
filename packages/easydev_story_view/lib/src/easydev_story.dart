import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:easydev_story_view/src/view/easydev_stories_slider_view.dart';
import 'package:easydev_story_view/src/controller/easydev_story_controller.dart';
import 'package:easydev_story_view/src/controller/easydev_story_controller_impl.dart';
import 'package:easydev_story_view/src/model/story.dart';
import 'package:easydev_story_view/src/model/style/easydev_story_style.dart';

/// Stories viewer. Has support for images, videos, and simple content.
///
/// This sample produces variant of EasyDevStory.
///
/// See code in easydev_story_view/example/lib/main.dart
class EasyDevStory extends StatefulWidget {
  const EasyDevStory({
    required this.storyCount,
    required this.storyBuilder,
    required this.sliderBuilder,
    EasyDevStoryController? controller,
    this.style = const EasyDevStoryStyle(),
    this.isViewedCheckList,
    this.withCloseButton = true,
    super.key,
  }) : storyController = controller;

  /// Styles for the `EasyDevStory`. Provides customization options
  /// for [StoryIndicator], [SliderStyle].
  final EasyDevStoryStyle style;

  /// A controller for manipulating flow and listening user interactions.
  ///
  /// Provides methods to skip, pause, resume contents and
  /// stories, show and hide widgets on story contents, enable or disable
  /// gestures, capture and block events before they happen and more.
  final EasyDevStoryController? storyController;

  /// The number of [Story]s to build and display.
  final int storyCount;

  /// The builder function that will be called to build a [Story].
  /// This function can be async to provide lazy loading.
  ///
  /// Story builder returns a [Story].
  final FutureOr<Story> Function(int storyIndex) storyBuilder;

  /// Builds a widget that shown in list for every story.
  /// Most probably story owner's profile picture.
  ///
  /// Each story must have a slider.
  final Widget Function(int storyIndex) sliderBuilder;

  /// A list that determines whether the story has already been viewed
  /// by default or not.
  ///
  /// Default value is 'false' for all elements.
  final List<bool>? isViewedCheckList;

  /// Should close button be displayed or not.
  ///
  /// Default value is true.
  final bool withCloseButton;

  @override
  State<EasyDevStory> createState() => _EasyDevStoryState();
}

class _EasyDevStoryState extends State<EasyDevStory> with TickerProviderStateMixin {
  late final EasyDevStoryControllerImpl _controller;

  /// Active progress indicator value controller.
  late final AnimationController _indicatorController;

  @override
  void initState() {
    _indicatorController = AnimationController(vsync: this);

    _controller =
        (widget.storyController ?? EasyDevStoryController()) as EasyDevStoryControllerImpl;
    _controller
      ..storyCount = widget.storyCount
      ..setIndicatorController(
        indicatorController: _indicatorController,
      );

    super.initState();
  }

  @override
  void didUpdateWidget(EasyDevStory oldWidget) {
    if (oldWidget.storyCount != widget.storyCount) {
      _controller.storyCount = widget.storyCount;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliderView(
      controller: _controller,
      style: widget.style,
      sliderBuilder: widget.sliderBuilder,
      storyBuilder: widget.storyBuilder,
      isViewedCheckList: widget.isViewedCheckList,
      withCloseButton: widget.withCloseButton,
    );
  }
}
