/// Data class for EasyDevSearch widget.
class EasyDevSearchOption<T> {
  /// Create EasyDevSearchOption.
  EasyDevSearchOption({
    String? title,
    required this.value,
    required this.onTap,
  }) : title = title ?? value.toString();

  /// Title of the option.
  ///
  /// If this is null then string representation of [value] is used.
  final String title;

  /// Value this option represents.
  final T value;

  /// Callback to be called when the option is tapped.
  final void Function(T value) onTap;
}
