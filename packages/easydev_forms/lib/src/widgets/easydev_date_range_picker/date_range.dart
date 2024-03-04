/// Class for storing two [DateTime] field.
class DateRange {
  DateRange({
    required this.start,
    required this.end,
  }) : assert(!start.isAfter(end));

  final DateTime start;

  final DateTime end;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DateRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => Object.hash(start, end);

  @override
  String toString() => '$start - $end';
}
