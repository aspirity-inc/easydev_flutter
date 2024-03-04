/// Class that contains input formats for dates.
class DateInputFormat {
  DateInputFormat(this.format)
      : assert(
          format.length == 8 &&
              format.contains('dd') &&
              format.contains('MM') &&
              format.contains('yyyy') &&
              RegExp(r'^(dd|MM|yyyy)(dd|MM)(dd|MM|yyyy)$').matchAsPrefix(format) != null,
        );

  final String format;

  // ignore: non_constant_identifier_names
  DateInputFormat.MMddyyyy() : this('MMddyyyy');
  DateInputFormat.ddMMyyyy() : this('ddMMyyyy');
  DateInputFormat.yyyyddMM() : this('yyyyddMM');
  DateInputFormat.yyyyMMdd() : this('yyyyMMdd');
}
