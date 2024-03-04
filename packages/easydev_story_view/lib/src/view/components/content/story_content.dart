import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:easydev_story_view/src/model/story_position.dart';
import 'package:easydev_story_view/src/controller/easydev_story_controller.dart';
import 'package:easydev_story_view/src/util/content_position_provider.dart';
import 'package:easydev_story_view/src/util/story_data_provider.dart';
import 'package:easydev_story_view/src/model/enum/easydev_story_status.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';



/// Base class for story contents. Every story content type must be a subtype
/// of this class.
abstract class EasyDevStoryContent extends Widget {
  /// Constructor of [EasyDevStoryContent].
  const EasyDevStoryContent({super.key});
}
/// Base class for story contents. Advanced story types should extend this class
/// to use [EasyDevStory] capability.
abstract class StoryContent extends StatefulWidget
    implements EasyDevStoryContent {
  /// Default constructor of [StoryContent]. [StoryContentState] provides very
  /// useful methods to handle story events and loading, caching media and must
  /// returned from [createState]. [ImageContent] and [VideoContent] types
  /// extends this class.
  const StoryContent({super.key});

  @override
  StoryContentState<StoryContent> createState();
}

/// State class for StoryContent. This class provides EasyDevStory functionality
/// to story contents.
abstract class StoryContentState<T extends StoryContent> extends State<T> {
  final String _excMessage =
      'EasyDevStory fields didn\'t set yet, use any EasyDevStory method after super.didChangeDependencies().';

  Timer? _timer;
  ContentPositionProvider? _positionProvider;
  StoryDataProvider? _dataProvider;
  late final Duration _contentDuration;
  StoryStatus _status = StoryStatus.stop;

  /// Used to wait for the content to be ready. This future is completed when
  /// `markReady` is called.
  final _preparation = Completer<void>();

  /// Returns this contents position.
  StoryPosition get position {
    assert(_positionProvider != null, _excMessage);
    return _positionProvider!.position;
  }

  /// Custom loading screen or EasyDevStory default loading screen.
  Widget get loadingScreen {
    assert(_dataProvider != null, _excMessage);
    return _dataProvider!.style.loadingScreen;
  }

  /// Provided or default EasyDevStoryController.
  ///
  /// There is no need to use addListener method to listening events in the flow.
  /// Override [onStart], [onPause], [onResume] and [onStop] methods to handle
  /// events related to this content instead of use addListener.
  EasyDevStoryController get controller {
    assert(_dataProvider != null, _excMessage);
    return _dataProvider!.controller;
  }

  /// Fetch a file from the given url and cache it to local storage.
  Future<File> loadFile({
    String? cacheKey,
    Map<String, String>? requestHeaders,
    required String url,
  }) async {
    return await DefaultCacheManager().getSingleFile(
      url,
      key: cacheKey ?? url,
      headers: requestHeaders,
    );
  }

  /// Marks the story content as ready to start. Call this method when content
  /// is ready to be display.
  void markReady({required Duration duration}) {
    assert(_positionProvider != null, _excMessage);
    if (_preparation.isCompleted) {
      throw const FormatException( 'Error markReady called more than once!');
    }

    _timer?.cancel();

    _contentDuration = duration;
    _preparation.complete();
  }

  Future<void> _starter() async {
    final pos = _dataProvider!.positionNotifier;

    // This content is on screen but status changed.
    if (pos == position) {
      if (pos.status == StoryStatus.play) {
        await _preparation.future;
        _dataProvider!.controller.playbackController.start(
          position,
          _contentDuration,
        );
        onStart();
      } else if (pos.status == StoryStatus.pause) {
        onPause();
      } else {
        onResume();
      }

      _status = pos.status;
    }
    // Story skipped
    else if (pos != position && _status != StoryStatus.stop) {
      _status = StoryStatus.stop;
      onStop();
    }
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_positionProvider == null) {
      _positionProvider = ContentPositionProvider.of(context)!;
      _dataProvider = StoryDataProvider.of(context)!;

      _dataProvider!.positionNotifier.addListener(
        _starter,
        position: position,
      );

      initContent();
    }
  }

  @override
  @mustCallSuper
  void dispose() {
    _dataProvider!.positionNotifier.removeListener(_starter);
    super.dispose();
  }

  /// Called when [StoryContent] is finished its initialization. You can call
  /// methods provided by [StoryContentState] inside of this method.
  /// 'initContent' method is the first place that you can use provided methods.
  ///
  /// - 'initContent' runs only once immediately after
  /// 'didChangeDependecies.super()' call.
  FutureOr<void> initContent() {}

  /// Sets a timeout to call [markReady]. Use this method to set a time limit to
  /// take action when your content isn't ready at the requested time. Create
  /// your action in the [onTimeout] method.
  ///
  /// [markReady] cancels the timeout when called.
  void setTimeout(Duration timeout) {
    _timer?.cancel();
    _timer = Timer(timeout, onTimeout);
  }

  /// Called when the end of the set timeout is reached.
  void onTimeout() {}

  /// This method is called when content is on screen and should start.
  /// Start your video, audio or any progressing content inside of this method.
  void onStart() {}

  /// This method is called when story is resumed. It is called after the
  /// [onPause] method.
  ///
  /// Every tap pauses story, this method works very often, do not do
  /// expensive operations to avoid performance issues.
  void onResume() {}

  /// Called when the story is paused. In this method, pause video, audio or
  /// any other progressing content but do not reset its progress.
  ///
  /// Every tap pauses story, this method works very often, do not do
  /// expensive operations to avoid performance issues.
  void onPause() {}

  /// Called when story is not visible on screen and should stop. Stop any
  /// progressing content and reset it's progress to prevent from playing while
  /// this content is not visible.
  ///
  /// Don't dispose anything, resources may be used still.
  void onStop() {}
}

/// Base class for [ImageContent] and [VideoContent].
abstract class ManagedContent extends StoryContent {
  /// Creates a story content managed by [EasyDevStory].
  const ManagedContent({
    required this.url,
    this.requestHeaders,
    this.cacheKey,
    this.timeout,
    this.errorBuilder,
    super.key,
  });

  /// Media source url.
  final String url;

  /// Headers to use when getting the media file.
  final Map<String, String>? requestHeaders;

  /// Key to use when caching media file.
  final String? cacheKey;

  /// Time limit to prepare this content.
  final Duration? timeout;

  /// Builder to create error view to show when media couldn't loaded
  /// in [timeout].
  final Widget Function()? errorBuilder;

  @override
  StoryContentState<ManagedContent> createState();
}
