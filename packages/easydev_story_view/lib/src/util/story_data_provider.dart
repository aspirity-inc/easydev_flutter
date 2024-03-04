import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:easydev_story_view/src/controller/easydev_story_controller_impl.dart';
import 'package:easydev_story_view/src/util/position_notifier.dart';
import 'package:easydev_story_view/src/model/story.dart';
import 'package:easydev_story_view/src/model/style/easydev_story_style.dart';

/// Wraps story view and provides required data to the views.
class StoryDataProvider extends InheritedWidget {
  /// Creates story data provider.
  const StoryDataProvider({
    super.key,
    required super.child,
    required this.controller,
    required this.storyBuilder,
    required this.hasSliderView,
    required this.style,
    required this.withCloseButton,
  });

  /// Used to determine if EasyDevStory widget created for only Story player or not.
  final bool hasSliderView;

  /// Provided or default controller.
  final EasyDevStoryControllerImpl controller;

  /// Styles to use when creating views.
  final EasyDevStoryStyle style;

  /// The builder function that will be called to build a [Story].
  /// This function can be async to provide lazy loading.
  ///
  /// Story builder returns a [Story], which is:
  final FutureOr<Story> Function(int storyIndex) storyBuilder;


  /// {@macro easydev_story_view.withCloseButton}
  final bool withCloseButton;

  /// Current position details of the story view. Story contents uses this to
  /// determine if it should start or not.
  ///
  /// When [StoryDataProvider] created, controller always has [PositionNotifier].
  PositionNotifier get positionNotifier => controller.positionNotifier;

  /// Returns the [StoryDataProvider] from the [BuildContext].
  static StoryDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoryDataProvider>();
  }

  @override
  bool updateShouldNotify(StoryDataProvider oldWidget) => false;
}
