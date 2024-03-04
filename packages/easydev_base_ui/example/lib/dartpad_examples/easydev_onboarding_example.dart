import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevOnboarding].
void main() => runApp(const EasyDevOnboardingExampleApp());

class EasyDevOnboardingExampleApp extends StatelessWidget {
  const EasyDevOnboardingExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: EasyDevScaffold(
        appBar: const EasyDevAppBar(title: 'EasyDevOnboarding Sample'),
        body: EasyDevOnboardingExample(),
      ),
    );
  }
}

class EasyDevOnboardingExample extends StatelessWidget {
  EasyDevOnboardingExample({super.key});

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return EasyDevOnboarding(
      toolbar: EasyDevOnboardingToolbar(
        trailing: EasyDevIconButton(
          CommunityMaterialIcons.close,
          onTap: () {},
        ),
      ),
      pageController: controller,
      pages: [
        EasyDevOnboardingPageData(
          title: 'Title 1',
          body: 'Body 1',
          // Typically a picture from assets or network
          picture: Container(
            color: const Color(0xFF42A5F5),
            height: 200,
            width: 200,
          ),
        ),
        EasyDevOnboardingPageData(
          title: 'Title 2',
          body: 'Body 2',
          // Typically a picture from assets or network
          picture: Container(
            color: const Color(0xFF42A5F5),
            height: 200,
            width: 200,
          ),
        ),
        EasyDevOnboardingPageData(
          title: 'Title 2',
          body: 'Body 2',
          // Typically a picture from assets or network
          picture: Container(
            color: const Color(0xFF42A5F5),
            height: 200,
            width: 200,
          ),
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
    );
  }
}
