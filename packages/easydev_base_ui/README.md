# easydev_base_ui

---

Base widgets for applications using EasyDev UI kit.

This package includes buttons, text fields, modal widgets, tab bars, widget for searching with options list, carousel widget, loading indicators and widget for onboarding slides.

## Installation

---

To use this package, add easydev_base_ui as a dependency in your pubspec.yaml file.

## Usage

---

Import package into your code:

```
import "package:easydev_base_ui/easydev_base_ui.dart";
```

Most of these widgets must be wrapped in `EasyDevTheme`. You can provide theme manually using `EasyDevTheme` (from easydev_theme package), `Theme` or `CupertinoTheme` or wrap it with widgets that provide theme automatically such as `EasyDevApp`(from easydev_basics package), `MaterialApp` or `CupertinoApp`.

#### Basics

---

##### EasyDevButton

![Screen 1](https://i.ibb.co/kx2FCk1/Screenshot-1707469176.png)

There are five built-in constructors, where default values are used:

- `EasyDevButton.primary` for displaying primary button.
- `EasyDevButton.primarySmall` for displaying primary button that is not width expanded.
- `EasyDevButton.outlined` for displaying button with outlined borders.
- `EasyDevButton.outlinedSmall` for displaying outlined button that is not width expanded.
- `EasyDevButton.text` for displaying text button.

You can use `EasyDevButton` directly to castomize it.

```
EasyDevButton(
    text: 'Button',
    onTap: () {},
    softButton: true,
    borderRadius: ...,
    tapColor: ...,
    ...
),
```

##### EasyDevSocialMediaButton

EasyDev includes pre-build buttons for authorization via social networks.

![Screen 2](https://i.ibb.co/bvKkfmm/Screenshot-1707708634.png)

There are five built-in constructors for different social networks:

- `EasyDevSocialMediaButton.google`.
- `EasyDevSocialMediaButton.facebook`.
- `EasyDevSocialMediaButton.apple`.
- `EasyDevSocialMediaButton.vk`.
- `EasyDevSocialMediaButton.twitter`.

You can customize social media buttons using type and size fields.

```
EasyDevSocialMediaButton(
    onTap: () {},
    type: EasyDevSocialMediaButtonType.noBackground,
    size: EasyDevSocialMediaButtonSize.small,
),
```

##### EasyDevTextField and EasyDevTextFormField

![Screen 3](https://i.ibb.co/BVW1xCj/Screenshot-1707709232.png)

Depending on the `InputState` passed, the text field changes its appearance. There are six states:

- `InputState.enabled` - default state when text field is focused.
- `InputState.filled` - default state when text field is not focused and there is nothing in it.
- `InputState.error` - state for displaying errors. It changes text under the field and field's colors.
- `InputState.loading` - state for displaying loading. It changes text under the field and field's colors.
- `InputState.success` - state for displaying success. It changes text under the field and field's colors.

You can use `EasyDevInputDecoration` for customizing text field.

```
EasyDevTextField(
    decoration: const EasyDevInputDecoration(
        minWidth: 200,
        errorColor: ...,
        helperStyle: ...,
        ...
    ),
    label: 'Input',
    valueChanged: (value) {},
    helperText: 'Helper text',
    errorText: 'Error text',
    inputState: InputState.error,
),
```

In `EasyDevTextField` its value can only be accessed through `valueChange` callback. If you need to pass the value to text field, use `EasyDevTextFormField`.

##### EasyDevActionMenu

This is a menu widget, which shows a set of options when tapped. To function properly it must be wrapped with scaffold, for example, `EasyDevScaffold` from easydev_basics package.

![Screen 4](https://i.ibb.co/Wtmjdp1/Screenshot-1707711195.png)

It has two required fields - `onSelected` callback and `actions`, list of `EasyDevActionMenuItem`.

```
...
int selectedAction = 0;
...
EasyDevActionMenu<int>(
    icon: ...,
    actions: [
        EasyDevActionMenuItem<int>(
            actionName: 'Action 1',
            value: 1,
            selected: selectedAction == 1,
        ),
        EasyDevActionMenuItem<int>(
            actionName: 'Action 2',
            value: 2,
            selected: selectedAction == 2,
        ),
    ],
    onSelected: (int value) {
        setState(() {
            selectedAction = value;
        });
    },
),
```

##### RawModalWidget

This widget is used for creating custom modal widgets that shows on tap. To function properly it must be wrapped with scaffold, for example, `EasyDevScaffold` from easydev_basics package.

It has three required fields: `child`, widget that can be clicked to show modal dialog, `modalWidget`, widget that shown after tapping on `child` and `valueChanged`, that called on popping route with value.

There is an example of using this widget below:

```
...
@override
Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
        body: Center(
            child: RawModalWidget(
                modalWidget: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                            GestureDetector(
                                onTap: Navigator.of(context).pop,
                                child: Container(
                                    height: 30,
                                    width: 50,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                                        color: theme.colorPalette.greySwatch.onSurfaceColor,
                                    ),
                                    child: const Center(
                                        child: Text('Action 1'),
                                    ),
                                ),
                            ),
                            GestureDetector(
                                onTap: Navigator.of(context).pop,
                                child: Container(
                                    height: 30,
                                    width: 50,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                                        color: theme.colorPalette.greySwatch.onSurfaceColor,
                                    ),
                                    child: const Center(
                                        child: Text('Action 2'),
                                    ),
                                ),
                            ),
                            GestureDetector(
                                onTap: Navigator.of(context).pop,
                                child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                                        color: theme.colorPalette.greySwatch.onSurfaceColor,
                                    ),
                                    child: const Center(
                                        child: Text('Action 3'),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
                valueChanged: (_) {},
                correctPosition: true,
                child: const Icon(
                    CommunityMaterialIcons.dots_vertical,
                ),
            ),
        ),
    );
}
```

![Screen 5](https://i.ibb.co/BGkfqGZ/Screenshot-1707712934.png)

##### EasyDevActionSheet

This is a widget that displays a title with a set of clickable actions, as well as a cancel button. This widget can be used in modal widgets to allow user to select an option.

![Screen 6](https://i.ibb.co/D49kzJ9/Screenshot-1707710688.png)

You need to pass `title` and `actions` of `EasyDevActionSheetItem` type to `EasyDevActionSheet`.

```
EasyDevActionSheet(
    actions: [
        EasyDevActionSheetItem(
            onTap: () {},
            text: 'Action',
        ),
        EasyDevActionSheetItem(
            onTap: () {},
            text: 'Action',
        ),
        EasyDevActionSheetItem(
            onTap: () {},
            text: 'Action',
        )
    ],
    title: 'Title',
),
```

##### EasyDevTabBar

![Screen 7](https://i.ibb.co/LpKxW2S/Screenshot-1707713100.png)

To use `EasyDevTabBar` you need to pass list of widgets to `tabs` (typically `EasyDevTab`) and pass `EasyDevTabController` to `controller`, which length is equal to `tabs.length`. Note that you must pass `TickerProvider` to controller. For this you can mix your stateful widget with `TickerProviderStateMixin`.

```
class EasyDevTabBarExample extends StatefulWidget {
  const EasyDevTabBarExample({Key? key}) : super(key: key);

  @override
  State<EasyDevTabBarExample> createState() => _EasyDevTabBarExampleState();
}

class _EasyDevTabBarExampleState extends State<EasyDevTabBarExample> with TickerProviderStateMixin {
  late final EasyDevTabController _tabController;
  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabController = EasyDevTabController(length: 4, vsync: this);
    _tabs = [
      const EasyDevTab(
        text: "Label",
      ),
      const EasyDevTab(
        text: "Label",
      ),
      const EasyDevTab(
        text: "Label",
      ),
      const EasyDevTab(
        text: "Label",
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            EasyDevTabBar.underline(
              controller: _tabController,
              tabs: _tabs,
            ),
            const SizedBox(
              height: 32,
            ),
            EasyDevTabBar.filled(
              controller: _tabController,
              tabs: _tabs,
            ),
          ],
        ),
      ),
    );
  }
}
```

##### EasyDevSearch

Search input with suggestions dropdown. Note that `EasyDevSearch` must be placed to a widget that provides constraints, because `EasyDevSearch` need to correctly position list of `EasyDevSearchOption`.

![Screen 8](https://i.ibb.co/pz8Y2Kt/Screenshot-1707716104.png)

To use `EasyDevSearch` you need to pass list of `EasyDevSearchOption` to `options`.

```
Column(
  children: [
    EasyDevSearch(
      options: [
        EasyDevSearchOption(value: 'First', onTap: (value) {}),
        EasyDevSearchOption(value: 'Second', onTap: (value) {}),
        EasyDevSearchOption(value: 'Third', onTap: (value) {}),
        EasyDevSearchOption(value: 'Fourth', onTap: (value) {}),
      ],
    ),
  ],
),
```

##### EasyDevCarousel

![Screen 9](https://i.ibb.co/Hq20t9Z/Screenshot-1707716865.png)

You can use `EasyDevCarousel` with `children` or with `builder`.

```
final items = [Text('1'), Text('2'), Text('3'), Text('4')];

Column(
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
),
```

##### Loading indicators

EasyDev provides different loading indicators.

![Screen 10](https://i.ibb.co/0cRrLCr/Screenshot-1707717481.png)

Code for the screenshot is shown below.

```
const Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    EasyDevProgressBar(
      percentage: 0.5,
    ),
    SizedBox(
      height: 16,
    ),
    EasyDevInfiniteProgressBar(
      width: 202,
    ),
    SizedBox(
      height: 16,
    ),
    CircularLoadingIndicator.small(),
    SizedBox(
      height: 16,
    ),
    CircularLoadingIndicator.medium(),
    SizedBox(
      height: 16,
    ),
    CircularLoadingIndicator.large(),
    SizedBox(
      height: 16,
    ),
    EasyDevLoadingIndicator(),
    SizedBox(
      height: 16,
    ),
    SpinningLoadingIndicator(),
  ],
);
```

##### EasyDevOnboarding

It simplifies creation of any kind of multi-paged introductions or instructions with optional actions. Each page's content (title, body and picture) can be wrapped in a card. To customize page's card appearance, use `cardMargin`, `cardBorderRadius`, and `cardBackgroundColor` fields.

![Screen 11](https://i.ibb.co/QHKz7Qd/Screenshot-1707717922.png)
![Screen 11](https://i.ibb.co/5sCjcj3/Screenshot-1707717930.png)
![Screen 13](https://i.ibb.co/bBMpfX9/Screenshot-1707717935.png)

See code for screenshots above at `easydev_base_ui/example/lib/pages/onboarding_page.dart`.

To use `EasyDevOnboarding` you need to pass `PageController` to `controller` and list of `EasyDevOnboardingPageData` to `pages`. In `EasyDevOnboardingPageData` you can provide `picture` that will be shown above indicators or `backgroundImage` that will expand on the entire screen.

```
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
    return EasyDevOnboarding(
      pageController: controller3,
      toolbar: EasyDevOnboardingToolbar(
        leading: controller3CurrentPage == 0
            ? null
            : EasyDevIconButton(
                CommunityMaterialIcons.arrow_left,
                color: context.easyDevTheme.colorPalette.greySwatch.onSurfaceBright,
                onTap: () => controller3.previousPage(
                  duration: _pageTransitionDuration,
                  curve: _pageTransitionCurve,
                ),
              ),
        trailing: controller3CurrentPage == 2
            ? null
            : EasyDevButton.text(
                text: 'Skip',
                textColor: context.easyDevTheme.colorPalette.greySwatch.onSurfaceBright,
                onTap: () => Navigator.of(context).pop(),
              ),
      ),
      pages: [
        EasyDevOnboardingPageData(
          backgroundImage: const AssetImage('...'),
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
          title: _title2,
          body: _body2,
          picture: SvgPicture.asset('...'),
        ),
        EasyDevOnboardingPageData(
          title: _title3,
          body: _body3,
          picture: SvgPicture.asset('...'),
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
    );
  }
}
```
