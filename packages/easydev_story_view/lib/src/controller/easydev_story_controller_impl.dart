import 'dart:async';

import 'package:easydev_story_view/src/controller/playback_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:easydev_story_view/src/model/enum/easydev_story_status.dart';
import 'package:easydev_story_view/src/util/position_notifier.dart';
import 'package:easydev_story_view/src/model/enum/easydev_story_events.dart';
import 'package:easydev_story_view/src/model/story_position.dart';
import 'package:easydev_story_view/src/controller/easydev_content_controller.dart';
import 'package:easydev_story_view/src/controller/easydev_story_controller.dart';

const int _durationMs = 300;

/// A controller for manipulating flow and listening user interactions.
class EasyDevStoryControllerImpl implements EasyDevStoryController {
  /// Creates an instance of [EasyDevStoryControllerImpl].
  EasyDevStoryControllerImpl() {
    playbackController = PlaybackController(callback: toNextContent);
  }

  /// Manages playback of content and indicators of story.
  late final PlaybackController playbackController;

  /// Position of the current story. [PositionNotifier] also contains a
  /// variable to keep story state, this variable is used to pause/resume story.
  final positionNotifier = PositionNotifier();

  /// Count of the stories.
  int? _storyCount;

  /// Sets story count, used to determine bounds.
  set storyCount(int count) => _storyCount = count;

  /// Event listeners for [EasyDevStoryControllerImpl]
  final _listeners = ObserverList<void Function(StoryEvent event, StoryPosition position)>();

  /// Story PageView controller. This controller lets controller to skip next
  /// and previous story.
  PageController? storyController;

  /// Keeps controllers until related content is removed from widget tree.
  final _contentControllers = <int, EasyDevContentPageController>{};

  /// Map<storyIndex, contentIndex> used for saving index of current content
  /// in each story and displaying it when user goes to previous stories.
  final _contentIndexes = <int, int>{};

  @override
  EasyDevContentPageController? get contentController => _contentControllers[storyIndex];

  @override
  Map<int, int> get contentIndexes => _contentIndexes;

  @override
  int get storyIndex => storyController?.page?.round() ?? 0;

  @override
  int get contentIndex => contentController?.page?.round() ?? 0;

  @override
  bool get hasClient => storyController?.hasClients ?? false;

  @override
  int get storyCount => _storyCount ?? 0;

  @override
  int get contentCount => contentController?.itemCount ?? 0;

  @override
  bool get isPaused => !playbackController.isRunning;

  @override
  Future<void> jumpTo({required int story, required int content}) async {
    assert(hasClient);
    assert(
      story >= 0 && story < storyCount,
      "Story index out of range.",
    );
    assert(content >= 0, "Content index out of range.");

    void listener() {
      if (storyController!.page!.floor() == story) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
          await _waitContentController(story);

          assert(
            contentController!.itemCount > content,
            "Content index out of range.",
          );

          contentController!.jumpToPage(content);
          positionNotifier.update(content: content, story: story);
        });

        storyController!.removeListener(listener);
      }
    }

    if (storyIndex == story) {
      await _waitContentController(story);
      contentController!.jumpToPage(content);
      positionNotifier.update(content: content);
    } else {
      storyController!.addListener(listener);
      storyController!.jumpToPage(story);
    }
  }

  Future<void> _waitContentController(index) async {
    if (_contentControllers[index] != null) return;

    final completer = Completer<void>();

    Timer.periodic(
      const Duration(milliseconds: 25),
      (timer) {
        if (_contentControllers[index] != null) {
          completer.complete();
          timer.cancel();
        }
      },
    );

    return completer.future;
  }

  @override
  void toNextStory() {
    assert(hasClient);
    Duration duration = const Duration(milliseconds: _durationMs * 2);

    if (storyIndex < storyCount - 1) {
      duration = const Duration(milliseconds: _durationMs);
    }

    playbackController.reset();

    storyController!.nextPage(
      duration: duration,
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  void toPreviousStory() {
    assert(hasClient);
    if (storyIndex > 0) {
      playbackController.reset();

      storyController!.previousPage(
        duration: const Duration(milliseconds: _durationMs),
        curve: Curves.linearToEaseOut,
      );
    }
  }

  @override
  void toNextContent() {
    assert(hasClient);
    // Reached to the last content, skip to next story.
    if (contentIndex == contentCount - 1) {
      toNextStory();
    } else {
      final nextIndex = contentIndex + 1;

      playbackController.reset();

      contentController!.jumpToPage(nextIndex);
      positionNotifier.update(content: nextIndex);
      notifyListeners(StoryEvent.nextContent);
    }
  }

  @override
  void toPreviousContent() {
    assert(hasClient);
    // Displaying first content, skip to previous story.
    if (contentIndex == 0) {
      toPreviousStory();
    } else {
      final previousIndex = contentIndex - 1;

      playbackController.reset();

      contentController!.jumpToPage(previousIndex);
      positionNotifier.update(content: previousIndex);
      notifyListeners(StoryEvent.previousContent);
    }
  }

  @override
  void pause() {
    assert(hasClient);
    if (!playbackController.isRunning) return;

    playbackController.pause();
    positionNotifier.update(status: StoryStatus.pause);
    notifyListeners(StoryEvent.pause);
  }

  @override
  void resume() {
    assert(hasClient);
    if (playbackController.isRunning) return;

    positionNotifier.update(status: StoryStatus.resume);
    notifyListeners(StoryEvent.resume);

    playbackController.resume();
  }

  @override
  void addListener(void Function(StoryEvent event, StoryPosition position) listener) =>
      _listeners.add(listener);

  @override
  void removeListener(void Function(StoryEvent event, StoryPosition position) listener) {
    if (_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }

  /// Sets indicator controller for controlling active indicator progress.
  void setIndicatorController({
    required AnimationController indicatorController,
  }) {
    playbackController.indicatorController = indicatorController;
  }

  /// Adds content EasyDevContentPageController to controllers.
  void setContentController(EasyDevContentPageController controller, int index) {
    _contentControllers[index] = controller;
  }

  /// Returns content page view controller EasyDevContentPageController by index.
  EasyDevContentPageController? getContentController(int index) {
    return _contentControllers[index];
  }

  /// Removes content EasyDevContentPageController to controllers.
  void cleanContentController(int index) {
    _contentControllers.remove(index)?.dispose();
  }

  /// Update position of story
  void handleStoryChange(int index) {
    playbackController.reset();
    // If current page is last page, do nothing.

    if (index > storyCount - 1) return;

    final event =
        positionNotifier.story < storyIndex ? StoryEvent.nextStory : StoryEvent.previousStory;

    _saveContentIndex(
        positionNotifier.story, event == StoryEvent.nextStory ? positionNotifier.content : 0);
    positionNotifier.update(content: contentIndex, story: storyIndex);
    notifyListeners(event);
  }

  void _saveContentIndex(int storyIndex, int contentIndex) {
    _contentIndexes[storyIndex] = contentIndex;
  }

  void cleanContentIndexes() {
    _contentIndexes.clear();
  }

  /// Resets values of controller, values are only available to current view.
  void _reset() {
    playbackController.reset();
    positionNotifier.reset();
    storyController?.dispose();
    storyController = null;
  }

  /// Calls registered listeners
  void notifyListeners(
    StoryEvent event, {
    int? storyIndex,
    int? contentIndex,
  }) {
    if (event == StoryEvent.close) {
      _reset();
    }

    for (final listener in _listeners) {
      listener.call(
        event,
        StoryPosition(
          contentIndex ?? this.contentIndex,
          storyIndex ?? this.storyIndex,
        ),
      );
    }
  }
}
