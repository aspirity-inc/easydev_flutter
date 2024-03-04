/// Event types.
enum StoryEvent {
  /// Tapped on a story slider.
  sliderTap,

  /// Skipped to the next content by the user or automatically.
  nextContent,

  /// Skipped to the previous content by the user or automatically.
  previousContent,

  /// Skipped to the next story by the user or automatically.
  nextStory,

  /// Skipped to the previous story by the user or automatically.
  previousStory,

  /// Long pressed to pause the story or called `pause()`.
  pause,

  /// Released long press to resume the story or called `resume()`.
  resume,

  /// Swiped down to close the story view or has reached to the end of the
  /// stories.
  close,
}