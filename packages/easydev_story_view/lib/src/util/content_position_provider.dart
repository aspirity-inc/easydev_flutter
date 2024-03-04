import 'package:easydev_story_view/src/model/story_position.dart';

import 'package:flutter/widgets.dart';

/// Provides it's position to a story contents.
class ContentPositionProvider extends InheritedWidget {
  /// Creates position provider instance. Story contents can know it's position
  /// in list of story content using this widget.
  const ContentPositionProvider({
    required super.child,
    required this.position,
    super.key,
  });

  /// The position of the story.
  final StoryPosition position;

  /// Returns the [ContentPositionProvider] from the [BuildContext].
  static ContentPositionProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ContentPositionProvider>();
  }

  @override
  bool updateShouldNotify(ContentPositionProvider oldWidget) => false;
}
