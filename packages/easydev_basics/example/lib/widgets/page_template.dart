import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({
    super.key,
    this.appBar,
    this.title,
    required this.body,
  }) : assert(
          appBar != null || title != null,
          'Either appBar or title should be specified',
        );

  final EasyDevAppBar? appBar;
  final String? title;
  final Widget body;

  EasyDevAppBar _getAppBar() {
    return appBar ??
        EasyDevAppBar(
          title: title,
          titleAlignment: Alignment.centerLeft,
          addBackButton: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(color: context.easyDevTheme.colorPalette.greySwatch.backgroundColor),
          Padding(
            padding: const EdgeInsets.only(top: 64),
            child: body,
          ),
          _getAppBar(),
        ],
      ),
    );
  }
}
