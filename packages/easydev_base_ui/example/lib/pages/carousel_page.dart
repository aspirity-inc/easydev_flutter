import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:example/widgets/page_appbar.dart';
import 'package:example/widgets/widget_wrapper.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    final shadow = BoxShadow(
      color: theme.brightness == Brightness.light ? lightThemeGrey200 : darkThemeGrey900,
      spreadRadius: 2,
      blurRadius: 3,
      offset: const Offset(0, 1.5),
    );

    final items = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorPalette.primarySwatch,
            boxShadow: [shadow],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorPalette.successSwatch?[500] ?? theme.colorPalette.primarySwatch,
            boxShadow: [shadow],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorPalette.secondarySwatch?[500] ?? theme.colorPalette.primarySwatch,
            boxShadow: [shadow],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorPalette.tertiarySwatch?[500] ?? theme.colorPalette.primarySwatch,
            boxShadow: [shadow],
          ),
        ),
      ),
    ];

    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Default carousel',
            child: SizedBox(
              height: 200,
              child: EasyDevCarousel(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.colorPalette.greySwatch.backgroundColor,
                        boxShadow: [shadow],
                      ),
                      child: Text(
                        'Description 1',
                        style: theme.typography?.subheading1Style ?? const TextStyle(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.colorPalette.successSwatch,
                        boxShadow: [shadow],
                      ),
                      child: Text(
                        'Description 2',
                        style: theme.typography?.subheading1Style ?? const TextStyle(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.colorPalette.tertiarySwatch,
                        boxShadow: [shadow],
                      ),
                      child: Text(
                        'Description 3',
                        style: theme.typography?.subheading1Style ?? const TextStyle(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.colorPalette.errorSwatch,
                        boxShadow: [shadow],
                      ),
                      child: Text(
                        'Description 4',
                        style: theme.typography?.subheading1Style ?? const TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          WidgetWrapper(
            label: 'Infinite carousel with loop indicator',
            child: SizedBox(
              height: 200,
              child: EasyDevCarousel.builder(
                itemBuilder: (context, index) => items[index % 4],
                indicatorCount: 4,
                controller: PageController(initialPage: 100),
              ),
            ),
          ),
          WidgetWrapper(
            label: 'Infinite carousel',
            child: SizedBox(
              height: 200,
              child: EasyDevCarousel.builder(
                itemBuilder: (context, index) => Center(
                  child: Text(
                    index.toString(),
                    style: theme.typography?.subheading1Style ?? const TextStyle(),
                  ),
                ),
              ),
            ),
          ),
          WidgetWrapper(
            label: 'Carousel with different viewport',
            child: SizedBox(
              height: 200,
              child: EasyDevCarousel(
                controller: PageController(viewportFraction: 0.8),
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.colorPalette.warningSwatch,
                        boxShadow: [shadow],
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Description 1',
                          style: theme.typography?.subheading1Style ?? const TextStyle(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        bottom: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.colorPalette.successSwatch,
                        boxShadow: [shadow],
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Description 2',
                          style: theme.typography?.subheading1Style ?? const TextStyle(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.colorPalette.tertiarySwatch,
                        boxShadow: [shadow],
                      ),
                      child: Text(
                        'Description 3',
                        style: theme.typography?.subheading1Style ?? const TextStyle(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.colorPalette.errorSwatch,
                        boxShadow: [shadow],
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Description 4',
                          style: theme.typography?.subheading1Style ?? const TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Carousel page',
      ),
    );
  }
}
