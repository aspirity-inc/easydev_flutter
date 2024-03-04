import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example/widgets/page_appbar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _title1 = 'Title1';
const _title2 = 'Title2';
const _title3 = 'Title3';

const _body1 =
    'R2-D2 or Artoo-Detoo is a fictional robot character in the Star Wars franchise created by George Lucas.';
const _body2 =
    'R2-D2 was designed in artwork by Ralph McQuarrie, co-developed by John Stears and built by Peteric Engineering.';
const _body3 = 'He has appeared in ten of the eleven theatrical Star Wars films to date.';

const _pageTransitionDuration = Duration(milliseconds: 500);
const _pageTransitionCurve = Curves.easeIn;

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller1 = PageController();
  final PageController controller2 = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    return EasyDevScaffold(
      body: ListView(
        children: [
          EasyDevButton(
            text: 'Default',
            onTap: () => Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => EasyDevOnboarding(
                  toolbar: EasyDevOnboardingToolbar(
                    trailing: EasyDevIconButton(
                      CommunityMaterialIcons.close,
                      color: context.easyDevTheme.colorPalette.secondarySwatch?[300],
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  pageController: controller1,
                  backgroundColor: context.easyDevTheme.colorPalette.greySwatch.backgroundColor,
                  pages: [
                    EasyDevOnboardingPageData(
                      title: _title1,
                      body: _body1,
                      picture: SvgPicture.asset('assets/onboarding/picture_1.svg'),
                    ),
                    EasyDevOnboardingPageData(
                      title: _title2,
                      body: _body2,
                      picture: SvgPicture.asset('assets/onboarding/picture_2.svg'),
                    ),
                    EasyDevOnboardingPageData(
                      title: _title3,
                      body: _body3,
                      picture: SvgPicture.asset('assets/onboarding/picture_3.svg'),
                      primaryButton: EasyDevButton(
                        text: 'Enable notifications',
                        onTap: () {},
                      ),
                      secondaryButton: EasyDevButton.outlined(
                        text: 'Maybe later',
                        onTap: () {},
                      ),
                    ),
                  ],
                  cardMargin: const EdgeInsets.all(8),
                  cardBorderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
          EasyDevButton(
            text: 'Cards',
            onTap: () => Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => EasyDevOnboarding(
                  titleStyle: theme.brightness == Brightness.light
                      ? theme.typography?.heading2Style
                          ?.copyWith(color: theme.colorPalette.greySwatch.surfaceColor)
                      : null,
                  bodyStyle: theme.brightness == Brightness.light
                      ? theme.typography?.body1Style
                          ?.copyWith(color: theme.colorPalette.greySwatch.surfaceColor)
                      : null,
                  indicatorType: PageIndicatorType.expanded,
                  pageIndicatorColor: theme.brightness == Brightness.light
                      ? theme.colorPalette.greySwatch.onPrimary
                      : theme.colorPalette.greySwatch.onBackgroundColor,
                  isPagePictureOnTop: false,
                  cardBackgroundColor: context.easyDevTheme.colorPalette.secondarySwatch?[500],
                  toolbar: EasyDevOnboardingToolbar(
                    trailing: EasyDevIconButton(
                      CommunityMaterialIcons.close,
                      color: theme.brightness == Brightness.light
                          ? theme.colorPalette.greySwatch.surfaceColor
                          : theme.colorPalette.greySwatch.onBackgroundColor,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  pageController: controller2,
                  pages: [
                    EasyDevOnboardingPageData(
                      picture: SvgPicture.asset('assets/onboarding/picture_1.svg'),
                      title: _title1,
                      body: _body1,
                      primaryButton: EasyDevButton(
                        text: 'Next',
                        onTap: () => controller2.nextPage(
                          duration: _pageTransitionDuration,
                          curve: _pageTransitionCurve,
                        ),
                      ),
                    ),
                    EasyDevOnboardingPageData(
                      title: _title2,
                      body: _body2,
                      picture: SvgPicture.asset('assets/onboarding/picture_2.svg'),
                      primaryButton: EasyDevButton(
                        text: 'Next',
                        onTap: () => controller2.nextPage(
                          duration: _pageTransitionDuration,
                          curve: _pageTransitionCurve,
                        ),
                      ),
                    ),
                    EasyDevOnboardingPageData(
                      title: _title3,
                      body: _body3,
                      picture: SvgPicture.asset('assets/onboarding/picture_3.svg'),
                      primaryButton: EasyDevButton(
                        text: 'Get started',
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          EasyDevButton(
            text: 'Image background',
            onTap: () => Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const _Onboarding3(),
              ),
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Onboarding page',
      ),
    );
  }
}

class _Onboarding3 extends StatefulWidget {
  const _Onboarding3();

  @override
  State<_Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends State<_Onboarding3> {
  final PageController controller3 = PageController();

  final title1 = 'Title1';
  final title2 = 'Title2';
  final title3 = 'Title3';

  final body1 =
      'R2-D2 or Artoo-Detoo is a fictional robot character in the Star Wars franchise created by George Lucas.';
  final body2 =
      'R2-D2 was designed in artwork by Ralph McQuarrie, co-developed by John Stears and built by Peteric Engineering.';
  final body3 = 'He has appeared in ten of the eleven theatrical Star Wars films to date.';

  int controller3CurrentPage = 0;

  @override
  void initState() {
    super.initState();

    controller3.addListener(() {
      final page = (controller3.page ?? 0).toInt();
      if (page != controller3CurrentPage) {
        setState(() => controller3CurrentPage = page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    return EasyDevOnboarding(
      indicatorType: PageIndicatorType.expanded,
      pageIndicatorColor: theme.brightness == Brightness.light
          ? theme.colorPalette.greySwatch.surfaceColor
          : theme.colorPalette.greySwatch.onBackgroundColor,
      pageController: controller3,
      titleStyle: theme.brightness == Brightness.light
          ? theme.typography?.heading2Style
              ?.copyWith(color: theme.colorPalette.greySwatch.surfaceColor)
          : null,
      bodyStyle: theme.brightness == Brightness.light
          ? theme.typography?.body1Style
              ?.copyWith(color: theme.colorPalette.greySwatch.surfaceColor)
          : null,
      toolbar: EasyDevOnboardingToolbar(
        leading: controller3CurrentPage == 0
            ? null
            : EasyDevIconButton(
                CommunityMaterialIcons.arrow_left,
                color: theme.brightness == Brightness.light
                    ? theme.colorPalette.greySwatch.surfaceColor
                    : theme.colorPalette.greySwatch.onBackgroundColor,
                onTap: () => controller3.previousPage(
                  duration: _pageTransitionDuration,
                  curve: _pageTransitionCurve,
                ),
              ),
        trailing: controller3CurrentPage == 2
            ? null
            : EasyDevButton.text(
                text: 'Skip',
                textColor: theme.brightness == Brightness.light
                    ? theme.colorPalette.greySwatch.surfaceColor
                    : theme.colorPalette.greySwatch.onBackgroundColor,
                onTap: () => Navigator.of(context).pop(),
              ),
      ),
      pages: [
        EasyDevOnboardingPageData(
          backgroundImage: const AssetImage('assets/onboarding/bg_1.png'),
          title: title1,
          body: body1,
          primaryButton: EasyDevButton(
            text: 'Next',
            onTap: () => controller3.nextPage(
              duration: _pageTransitionDuration,
              curve: _pageTransitionCurve,
            ),
          ),
        ),
        EasyDevOnboardingPageData(
          backgroundImage: const AssetImage('assets/onboarding/bg_2.png'),
          title: title2,
          body: body2,
          primaryButton: EasyDevButton(
            text: 'Next',
            onTap: () => controller3.nextPage(
              duration: _pageTransitionDuration,
              curve: _pageTransitionCurve,
            ),
          ),
        ),
        EasyDevOnboardingPageData(
          backgroundImage: const AssetImage('assets/onboarding/bg_3.png'),
          title: title3,
          body: body3,
          primaryButton: EasyDevButton(
            text: 'Get started',
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}
