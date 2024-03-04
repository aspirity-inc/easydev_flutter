import 'package:easydev_story_view/src/controller/easydev_content_controller.dart';
import 'package:easydev_story_view/src/controller/easydev_story_controller_impl.dart';
import 'package:easydev_story_view/src/model/enum/easydev_story_events.dart';
import 'package:easydev_story_view/src/model/story_position.dart';

/// A controller for manipulating flow and listening user interactions.
abstract class EasyDevStoryController {
  /// Creates an EasyDevStoryController.
  ///
  /// Check [hasClient] before calling methods.
  factory EasyDevStoryController() = EasyDevStoryControllerImpl;

  /// Active content PageView controller. This controller lets to skip next and
  /// previous content.
  EasyDevContentPageController? get contentController;

  /// Map<storyIndex, contentIndex> used for saving index of current content
  /// in each story and displaying it when user goes to previous stories.
  Map<int, int> get contentIndexes;

  /// Currently displaying story index.
  int get storyIndex;

  /// Currently displaying content index in the current story.
  int get contentIndex;

  /// Returns true if a story view is currently visible. Most methods like
  /// [toNextContent], [toPreviousStory] can't be used and throws an exception
  /// if the story view is not visible.
  bool get hasClient;

  /// Total count of stories.
  int get storyCount;

  /// Total content count in currently displaying story.
  int get contentCount;

  /// Returns true if the story is paused, false otherwise.
  bool get isPaused;

  /// Jumps to the [content] in story [story].
  void jumpTo({required int story, required int content});

  /// Skips to the next story if available. Otherwise closes the story view.
  void toNextStory();

  /// Skips to the previous story if available. Otherwise does nothing.
  void toPreviousStory();

  /// Skips to the next content if available. Otherwise skips to the next story
  /// or closes the story view.
  void toNextContent();

  /// Skips to previous content if available. Otherwise skips to the previous
  /// story or does nothing.
  void toPreviousContent();

  /// Pauses the current story, this stops the timer and the story will not
  /// skip to the next item.
  void pause();

  /// Resumes the current story, starts the timer and indicator from last
  /// position and story skips as usual.
  void resume();

  /// Register a callback to be called when any story event happens.
  ///
  /// Called when:
  /// - content is skipped,
  /// - content is paused.
  /// - slider item is tapped.
  /// - story is skipped.
  /// - story view closed.
  ///
  /// Listener parameters:
  /// 1. Type of the event.
  /// 2. Position of the currently displaying story and content.
  void addListener(void Function(StoryEvent event, StoryPosition position) listener);

  /// Remove a previously registered closure from the list of callback that are
  /// notified when the events changes.
  ///
  /// If the given listener is not registered, the call is ignored.
  ///
  /// Listener parameters:
  /// 1. Type of the event.
  /// 2. Position of the currently displaying story and content.
  void removeListener(void Function(StoryEvent event, StoryPosition position) listener);
}
