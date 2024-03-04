import 'dart:async';

import 'package:easydev_story_view/easydev_story_view.dart';
import 'package:flutter/widgets.dart';

/// Manages automatic switching of story content and story indicators
class PlaybackController {
  /// Creates a [PlaybackController] with [callback] that called when the time is up.
  PlaybackController({required this.callback});

  /// This is always [EasyDevStoryControllerImpl]'s _nextStory_ method.
  /// Stories always go through forward automatically.
  final VoidCallback callback;

  /// Last known story position.
  StoryPosition? lastPosition;

  /// Indicator controller which is setting from [EasyDevStoryControllerImpl].
  late AnimationController indicatorController;

  Duration? _duration;
  Timer? _timer;
  final _stopWatch = Stopwatch();

  /// Returns true if a playback is running, and false if it's not.
  bool get isRunning => _stopWatch.isRunning;

  /// Starts story skip playback and sets indicators.
  Future<void> start(StoryPosition position, Duration duration) async {
    if (isRunning) reset();

    lastPosition = position;
    _duration = duration;
    _setIndicator(duration);

    _timer?.cancel();

    _timer = Timer(duration, callback);
    _stopWatch.start();
  }

  /// Pauses timer and active indicator.
  void pause() {
    if (_timer != null && _duration != null) {
      _timer!.cancel();
      _stopWatch.stop();

      _duration = _duration! - _stopWatch.elapsed;
      _stopWatch.reset();
    }

    indicatorController.stop(canceled: false);
  }

  /// Resumes timer and active indicator.
  void resume() {
    if (indicatorController.duration != null) {
      if (_timer != null && _duration != null) {
        _timer = Timer(_duration!, callback);
        _stopWatch.start();
      }

      indicatorController.forward();
    }
  }

  /// Resets indicator animation. Also stops and resets progress of
  /// video player
  void reset() async {
    if (lastPosition == null) return;

    _timer?.cancel();
    _stopWatch.stop();
    _stopWatch.reset();

    _duration = null;

    indicatorController.reset();
    lastPosition = null;
  }

  void _setIndicator(Duration duration) => indicatorController
    ..duration = duration
    ..forward();
}
