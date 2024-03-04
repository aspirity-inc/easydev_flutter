/// [InputState] enum provides you room for customization, when you need
/// to implement different text field use cases. They have different
/// customisation.
/// [InputState.enabled] is focusable text field.
/// [InputState.disabled] disables text field.
/// [InputState.error] show [error] instead of [helperText] when [error] is provided.
/// [InputState.success] show [successText] instead of [helperText] when [successText] is provided.
/// Other [InputState] value just change decoration of text field.
enum InputState {
  /// Focusable text input, reacts on [FocusNode] focus change.
  enabled,

  /// Filled text field, provides different color to text field.
  filled,

  /// Filled state, provides different color to text field, also shows
  /// error widget, instead of hint.
  error,

  /// Loading state, provider different color to text field.
  loading,

  /// Disabled state, disables text field input,
  /// provider different color to text field.
  disabled,

  /// Success state, provides different color to text field.
  success,
}
