import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_story_view/easydev_story_view.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example_story/widgets/brightness_notifier.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const EasyDevStoryExample());
}

class EasyDevStoryExample extends StatefulWidget {
  const EasyDevStoryExample({super.key});

  @override
  State<EasyDevStoryExample> createState() => _EasyDevStoryExampleState();
}

class _EasyDevStoryExampleState extends State<EasyDevStoryExample> {
  late ValueNotifier<Brightness> valueNotifier;

  @override
  void initState() {
    valueNotifier = ValueNotifier(Brightness.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BrightnessNotifier(
      valueNotifier: valueNotifier,
      child: Builder(
        builder: (context) {
          return ValueListenableBuilder(
              valueListenable:
                  context.dependOnInheritedWidgetOfExactType<BrightnessNotifier>()!.valueNotifier,
              builder: (context, value, _) {
                return EasyDevApp(
                  title: 'Stories exapmle',
                  lightThemeData: defaultLightTheme,
                  darkThemeData: defaultDarkTheme,
                  brightness: value,
                  home: const StoriesExample(),
                );
              });
        },
      ),
    );
  }
}

class StoriesExample extends StatelessWidget {
  const StoriesExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    const int storyCount = 5;
    List<bool> likeState = List.filled(storyCount, false);
    List<bool> bookmarkState = List.filled(storyCount, false);

    final EasyDevStoryController controller = EasyDevStoryController();
    final brightnessNotifier = context.dependOnInheritedWidgetOfExactType<BrightnessNotifier>();

    return EasyDevScaffold(
      appBar: EasyDevAppBar(
        toolbarHeight: MediaQuery.textScalerOf(context).scale(58),
        title: 'Stories',
        titleAlignment: Alignment.centerLeft,
        actions: [
          if (brightnessNotifier == null)
            const SizedBox()
          else
            ValueListenableBuilder(
              valueListenable: brightnessNotifier.valueNotifier,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      value == Brightness.dark ? 'Dark theme' : 'Light theme',
                      style: context.easyDevTheme.typography?.heading4Style,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    EasyDevSwitch.adaptive(
                      value: value == Brightness.dark,
                      onSelect: (_) {
                        brightnessNotifier.updateBrightness();
                      },
                    ),
                  ],
                );
              },
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: EasyDevStory(
                  storyCount: storyCount,
                  controller: controller,
                  style: const EasyDevStoryStyle(
                    sliderStyle: SliderStyle(
                      spacing: 10,
                      padding: EdgeInsets.zero,
                    ),
                    indicatorStyle: IndicatorStyle(),
                  ),
                  storyBuilder: (storyIndex) => Story(
                    contentCount: 5,
                    contentBuilder: (contentIndex) {
                      EasyDevStoryContent cont;
                      if (contentIndex == 0) {
                        cont = ImageContent(
                          url: 'https://loremflickr.com/600/900',
                          timeout: const Duration(seconds: 10),
                          duration: const Duration(seconds: 15),
                          errorBuilder: () => _getErrorContentScreen(
                            theme.colorPalette.errorSwatch!,
                          ),
                        );
                      } else if (contentIndex == 1) {
                        cont = VideoContent(
                          url:
                              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                          timeout: const Duration(seconds: 10),
                          errorBuilder: () => _getErrorContentScreen(
                            theme.colorPalette.errorSwatch!,
                          ),
                        );
                      } else if (contentIndex == 2) {
                        cont = SimpleCustomContent(
                          duration: const Duration(seconds: 5),
                          builder: (context) {
                            return Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: <Color>[
                                    Color(0xffD76BFE),
                                    Color(0xff1C1CB2),
                                  ],
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  Image.asset('assets/money.png'),
                                  const SizedBox(
                                    height: 64,
                                  ),
                                  Text(
                                    '\$ 8 356',
                                    style: heading1Style.copyWith(color: lightThemeGrey50),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'you spent in supermarkets in April',
                                    style: subheading2Style.copyWith(color: lightThemeGrey50),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'This is less than in March!',
                                    style: body1Style.copyWith(color: lightThemeGrey50),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (contentIndex == 3) {
                        cont = SimpleCustomContent(
                          duration: const Duration(seconds: 5),
                          builder: (context) {
                            return Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: <Color>[
                                    Color(0xffD76BFE),
                                    Color(0xff1C1CB2),
                                  ],
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Text(
                                      'how much you’ve spent in supermarkets before',
                                      style: heading1Style.copyWith(color: lightThemeGrey50),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      '• \$ 7050 in March',
                                      style: subheading2Style.copyWith(color: lightThemeGrey50),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      '• \$ 12 050 in February',
                                      style: subheading2Style.copyWith(color: lightThemeGrey50),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      '• \$ 18 050 in January',
                                      style: subheading2Style.copyWith(color: lightThemeGrey50),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        cont = SimpleCustomContent(
                          duration: const Duration(seconds: 5),
                          builder: (context) {
                            return Container(
                              color: ((contentIndex + 1) % 2 == 0)
                                  ? theme.colorPalette.secondarySwatch![600]
                                  : theme.colorPalette.tertiarySwatch![600],
                              alignment: Alignment.center,
                              child: Text(
                                'StoryIndex: $storyIndex\tContentIndex: $contentIndex',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return cont;
                    },
                    footer: ((storyIndex + 1) % 2 == 0)
                        ? StoryFooter.large(
                            mainButtonLabel: "Learn More",
                            onMainButton: () {},
                            onButtonLikeTap: (bool state) => likeState[storyIndex] = state,
                            onButtonShareTap: () {},
                            onButtonBookmarkTap: (bool state) => bookmarkState[storyIndex] = state,
                            likeInitState: likeState[storyIndex],
                            bookmarkInitState: bookmarkState[storyIndex],
                          )
                        : StoryFooter.small(
                            mainButtonLabel: "Learn More",
                            onMainButton: () {},
                            onButtonLikeTap: (bool state) => likeState[storyIndex] = state,
                            onButtonShareTap: () {},
                            onButtonBookmarkTap: (bool state) => bookmarkState[storyIndex] = state,
                            likeInitState: likeState[storyIndex],
                            bookmarkInitState: bookmarkState[storyIndex],
                          ),
                    bottomPadding: ((storyIndex + 1) % 2 == 0) ? 60 : 80,
                  ),
                  sliderBuilder: (storyIndex) {
                    if (storyIndex == 0) {
                      return SimpleCustomSlideItem(
                        width: 120,
                        height: 120,
                        text: 'Large large text',
                        textStyle: theme.typography?.subheading1Style?.copyWith(
                          color: theme.brightness == Brightness.light
                              ? theme.colorPalette.greySwatch.onPrimary
                              : theme.colorPalette.greySwatch.onBackgroundColor,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorPalette.tertiarySwatch![300]!,
                            theme.colorPalette.tertiarySwatch![500]!,
                            theme.colorPalette.tertiarySwatch![800]!,
                          ],
                          stops: const [0.0, 0.3, 1],
                        ),
                        child: Icon(
                          CommunityMaterialIcons.format_text,
                          color: theme.colorPalette.greySwatch.greyColor,
                          size: 60,
                        ),
                      );
                    } else if (storyIndex == 1) {
                      return const SimpleCustomSlideItem(
                        width: 120,
                        height: 120,
                        text: 'Large large text',
                      );
                    } else {
                      return ImageNetworkSlideItem(
                        url: storyIndex == 2
                            ? 'https://loremflickr.com/160/160'
                            : 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                        width: 120,
                        height: 120,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getErrorContentScreen(Color backgroundColor) {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: const Text('ERROR'),
    );
  }
}
