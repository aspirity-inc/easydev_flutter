import 'package:easydev_story_view/src/view/components/content/story_content.dart';
import 'package:flutter/widgets.dart';

/// Group of image, video, custom story contents. A story may include one
/// or more contents.
class Story {
  /// Creates a new story.
  Story({
    required this.contentCount,
    required this.contentBuilder,
    this.footer,
    this.bottomPadding,
  }) : assert(
          bottomPadding != null && bottomPadding > 0 || bottomPadding == null,
          'Padding cannot be negative!',
        );

  /// Function that will be called to build a [EasyDevStoryContent].
  ///
  /// May be called multiple times. Do not make heavy calculations in this
  /// method to avoid performance issues.
  final EasyDevStoryContent Function(int contentIndex) contentBuilder;

  /// Number of the content in this story.
  final int contentCount;

  /// Bottom section of story.
  ///
  /// If null, the story's bottom section will be empty.
  final Widget? footer;

  /// Bottom of story content padding. Does not affect footer padding.
  ///
  /// If null without padding.
  final double? bottomPadding;
}
