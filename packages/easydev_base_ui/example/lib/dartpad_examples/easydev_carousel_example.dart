import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevCarousel].
void main() => runApp(const EasyDevCarouselExampleApp());

class EasyDevCarouselExampleApp extends StatelessWidget {
  const EasyDevCarouselExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevCarousel Sample'),
        body: EasyDevCarouselExample(),
      ),
    );
  }
}

class EasyDevCarouselExample extends StatelessWidget {
  const EasyDevCarouselExample({super.key});

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
          child: const Center(child: Text('Slide 1')),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorPalette.successSwatch?[500] ?? theme.colorPalette.primarySwatch,
            boxShadow: [shadow],
          ),
          child: const Center(child: Text('Slide 2')),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorPalette.secondarySwatch?[500] ?? theme.colorPalette.primarySwatch,
            boxShadow: [shadow],
          ),
          child: const Center(child: Text('Slide 3')),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorPalette.tertiarySwatch?[500] ?? theme.colorPalette.primarySwatch,
            boxShadow: [shadow],
          ),
          child: const Center(child: Text('Slide 4')),
        ),
      ),
    ];

    return ListView(
      children: [
        SizedBox(
          height: 200,
          child: EasyDevCarousel(
            physics: const BouncingScrollPhysics(),
            children: items,
          ),
        ),
        SizedBox(
          height: 200,
          child: EasyDevCarousel.builder(
            itemBuilder: (context, index) => items[index % 4],
            indicatorCount: 4,
            controller: PageController(initialPage: 100),
          ),
        ),
      ],
    );
  }
}
