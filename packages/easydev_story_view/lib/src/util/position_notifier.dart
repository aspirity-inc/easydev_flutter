import 'dart:async';

import 'package:easydev_story_view/easydev_story_view.dart';
import 'package:easydev_story_view/src/model/enum/easydev_story_status.dart';
import 'package:flutter/foundation.dart';

/// This class provides information about story view position and story status.
/// Contents listens this to set their state.
/// [EasyDevStoryController] updates position and status to notify contents.
class PositionNotifier extends ChangeNotifier
    implements StoryPosition, ValueListenable {
  /// Story view opening position.
  StoryPosition initialPosition = StoryPosition(0, 0);

  int _content = 0;
  int _story = 0;

  /// Status of the content in the position.
  StoryStatus status = StoryStatus.stop;

  /// When [EasyDevStory.noSlider] called, [EasyDevStory] widget listens this
  /// variable to show story view.
  final shouldShowView = ValueNotifier(false);

  /// Updates any [PositionNotifier] variable and calls listeners.
  void update({int? content, int? story, StoryStatus? status}) {
    bool isChanged = false;

    if (content != null && content != _content) {
      _content = content;
      status = StoryStatus.play;
      isChanged = true;
    }

    if (story != null && story != _story) {
      _story = story;
      status = StoryStatus.play;
      isChanged = true;
    }

    if (status != null && status != this.status) {
      this.status = status;
      isChanged = true;
    }

    if (isChanged) notifyListeners();
  }

  /// Resets parameters.
  void reset() {
    _story = 0;
    _content = 0;
    status = StoryStatus.stop;
  }

  @override
  void addListener(void Function() listener, {StoryPosition? position}) {
    if (position == this) {
      Timer.run(listener);
    }

    super.addListener(listener);
  }

  @override
  int get content => _content;

  @override
  int get story => _story;

  @override
  bool operator ==(Object other) =>
      other is StoryPosition &&
      content == other.content &&
      story == other.story;

  @override
  int get hashCode => Object.hash(content, story);

  @override
  String toString() => 'StoryPosition(content: $content, story: $story)';

  @override
  int get value => _story;
}
