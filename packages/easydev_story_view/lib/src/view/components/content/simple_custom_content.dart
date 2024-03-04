import 'package:easydev_story_view/src/util/content_position_provider.dart';
import 'package:flutter/widgets.dart';

import 'package:easydev_story_view/src/util/story_data_provider.dart';
import 'package:easydev_story_view/src/model/enum/easydev_story_status.dart';
import 'package:easydev_story_view/src/view/components/content/story_content.dart';

/// Type for contents using sources that can be loaded synchronously.
/// For example [Text], [AssetImage] etc.
class SimpleCustomContent extends StatefulWidget implements EasyDevStoryContent {
  /// Creates view for synchronous contents. If you are using network images,
  /// videos etc. inside your content, you shouldn't use [SimpleCustomContent].
  const SimpleCustomContent({
    required this.builder,
    this.duration = const Duration(seconds: 10),
    super.key,
  });

  /// Content builder function.
  final Widget Function(BuildContext) builder;

  /// Skip duration of the content.
  final Duration duration;

  @override
  State<SimpleCustomContent> createState() => _SimpleCustomContentState();
}

/// State class for [SimpleCustomContent].
class _SimpleCustomContentState extends State<SimpleCustomContent> {
  StoryDataProvider? _dataProvider;
  StoryStatus _status = StoryStatus.stop;
  ContentPositionProvider? _contentPositionProvider;

  Future<void> _starter() async {
    final currentPosition = _dataProvider!.positionNotifier;
    final contentPosition = _contentPositionProvider!.position;

    if (currentPosition == contentPosition && _status != StoryStatus.play) {
      _dataProvider!.controller.playbackController.start(contentPosition, widget.duration);
      _status = currentPosition.status;
    } else if (currentPosition != contentPosition  && _status != StoryStatus.stop) {
      _status = StoryStatus.stop;
    }
  }

  @override
  void didChangeDependencies() {
    if (_dataProvider == null) {
      _dataProvider = StoryDataProvider.of(context)!;
      _contentPositionProvider = ContentPositionProvider.of(context)!;
      _dataProvider!.positionNotifier
          .addListener(_starter, position: _contentPositionProvider!.position);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dataProvider!.positionNotifier.removeListener(_starter);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
