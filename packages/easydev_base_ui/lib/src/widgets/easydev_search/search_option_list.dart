import 'package:easydev_base_ui/src/widgets/easydev_search/easydev_search_option.dart';
import 'package:easydev_base_ui/src/widgets/easydev_search/easydev_search_option_list_item.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Internal widget for displaying [SearchOptionsList] with list of [EasyDevSearchOptionListItem].
class SearchOptionsList<T> extends StatelessWidget {
  const SearchOptionsList({
    super.key,
    required this.options,
    required this.inputController,
    required this.focusNode,
    required this.optionsColor,
    required this.optionsTapColor,
    required this.optionsTextStyle,
    required this.optionsTapTextStyle,
    required this.optionsHighlightTextStyle,
    required this.dividerColor,
    required this.separatedElements,
    required this.optionsHeight,
    required this.margin,
    required this.width,
    required this.optionsBuilder,
  });

  final Iterable<EasyDevSearchOption<T>> options;
  final TextEditingController inputController;
  final FocusNode focusNode;
  final Color? optionsColor;
  final Color? optionsTapColor;
  final TextStyle? optionsTextStyle;
  final TextStyle? optionsTapTextStyle;
  final TextStyle? optionsHighlightTextStyle;
  final Color? dividerColor;
  final bool separatedElements;
  final double optionsHeight;
  final EdgeInsets? margin;
  final double width;
  final Widget Function(EasyDevSearchOption option)? optionsBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: optionsHeight,
          maxWidth: width - (margin?.left ?? 16),
        ),
        padding: EdgeInsets.only(left: margin?.left ?? 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.light ? lightThemeGrey200 : darkThemeGrey900,
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(10, 13),
            )
          ],
        ),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: options.length,
          separatorBuilder: (context, index) => separatedElements
              ? const SizedBox(height: 8)
              : Container(
                  height: 1,
                  color: dividerColor ?? theme.colorPalette.greySwatch.greyColor,
                ),
          itemBuilder: (context, index) {
            final option = options.toList()[index];

            if (optionsBuilder != null) {
              return optionsBuilder!(option);
            }

            return EasyDevSearchOptionListItem(
              text: option.title,
              value: option.value,
              highlight: inputController.text,
              onTap: (value) {
                focusNode.unfocus();
                inputController.text = value;
                option.onTap(option.value);
              },
              color: optionsColor,
              tapColor: optionsTapColor,
              textStyle: optionsTextStyle,
              tapTextStyle: optionsTapTextStyle,
              separatedElements: separatedElements,
              highlightTextStyle: optionsHighlightTextStyle,
            );
          },
        ),
      ),
    );
  }
}
