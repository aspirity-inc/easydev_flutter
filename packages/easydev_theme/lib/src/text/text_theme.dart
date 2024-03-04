import 'package:flutter/widgets.dart';

import 'package:easydev_theme/src/text/text_styles.dart';

class TextTheme {
  const TextTheme({
    this.heading1Style,
    this.heading2Style,
    this.heading3Style,
    this.heading4Style,
    this.subheading1Style,
    this.subheading2Style,
    this.body1Style,
    this.body2Style,
    this.body3Style,
    this.captionStyle,
    this.tooltipStyle,
    this.buttonStyle,
  });

  final TextStyle? heading1Style;
  final TextStyle? heading2Style;
  final TextStyle? heading3Style;
  final TextStyle? heading4Style;

  final TextStyle? subheading1Style;
  final TextStyle? subheading2Style;

  final TextStyle? body1Style;
  final TextStyle? body2Style;
  final TextStyle? body3Style;

  final TextStyle? captionStyle;
  final TextStyle? tooltipStyle;
  final TextStyle? buttonStyle;

  @override
  bool operator ==(Object other) =>
      other is TextTheme &&
      heading1Style == other.heading1Style &&
      heading2Style == other.heading2Style &&
      heading3Style == other.heading3Style &&
      heading4Style == other.heading4Style &&
      subheading1Style == other.subheading1Style &&
      subheading2Style == other.subheading2Style &&
      body1Style == other.body1Style &&
      body2Style == other.body2Style &&
      body3Style == other.body3Style &&
      captionStyle == other.captionStyle &&
      tooltipStyle == other.tooltipStyle &&
      buttonStyle == other.buttonStyle;

  @override
  int get hashCode => Object.hash(
        heading1Style,
        heading2Style,
        heading3Style,
        heading4Style,
        subheading1Style,
        subheading2Style,
        body1Style,
        body2Style,
        body3Style,
        captionStyle,
        tooltipStyle,
        buttonStyle,
      );

  TextTheme copyWith({
    TextStyle? heading1Style,
    TextStyle? heading2Style,
    TextStyle? heading3Style,
    TextStyle? heading4Style,
    TextStyle? subheading1Style,
    TextStyle? subheading2Style,
    TextStyle? body1Style,
    TextStyle? body2Style,
    TextStyle? body3Style,
    TextStyle? captionStyle,
    TextStyle? tooltipStyle,
    TextStyle? buttonStyle,
  }) =>
      TextTheme(
        heading1Style: heading1Style ?? this.heading1Style,
        heading2Style: heading2Style ?? this.heading2Style,
        heading3Style: heading3Style ?? this.heading3Style,
        heading4Style: heading4Style ?? this.heading4Style,
        subheading1Style: subheading1Style ?? this.subheading1Style,
        subheading2Style: subheading2Style ?? this.subheading2Style,
        body1Style: body1Style ?? this.body1Style,
        body2Style: body2Style ?? this.body2Style,
        body3Style: body3Style ?? this.body3Style,
        captionStyle: captionStyle ?? this.captionStyle,
        tooltipStyle: tooltipStyle ?? this.tooltipStyle,
        buttonStyle: buttonStyle ?? this.buttonStyle,
      );

  factory TextTheme.copyWithColor(TextTheme theme, Color color) => TextTheme(
        heading1Style: theme.heading1Style?.copyWith(
          color: color,
        ),
        heading2Style: theme.heading2Style?.copyWith(
          color: color,
        ),
        heading3Style: theme.heading3Style?.copyWith(
          color: color,
        ),
        heading4Style: theme.heading4Style?.copyWith(
          color: color,
        ),
        subheading1Style: theme.subheading1Style?.copyWith(
          color: color,
        ),
        subheading2Style: theme.subheading2Style?.copyWith(
          color: color,
        ),
        body1Style: theme.body1Style?.copyWith(
          color: color,
        ),
        body2Style: theme.body2Style?.copyWith(
          color: color,
        ),
        body3Style: theme.body3Style?.copyWith(
          color: color,
        ),
        captionStyle: theme.captionStyle?.copyWith(
          color: color,
        ),
        tooltipStyle: theme.tooltipStyle?.copyWith(
          color: color,
        ),
        buttonStyle: theme.buttonStyle?.copyWith(
          color: color,
        ),
      );
}

const defaultTextTheme = TextTheme(
  heading1Style: heading1Style,
  heading2Style: heading2Style,
  heading3Style: heading3Style,
  heading4Style: heading4Style,
  subheading1Style: subheading1Style,
  subheading2Style: subheading2Style,
  body1Style: body1Style,
  body2Style: body2Style,
  body3Style: body3Style,
  captionStyle: captionStyle,
  tooltipStyle: tooltipStyle,
  buttonStyle: buttonStyle,
);
