# easydev_basics

---

This package containts basic widgets for building applications using EasyDev UI Kit.

This package includes app, scaffold, app bar, bottom navigation bar, floating action button, modal dialog, bottom sheet, snack bar and toast.

## Installation

---

To use this package, add easydev_basics as a dependency in your pubspec.yaml file.

## Usage

---

Import package into your code:

```
import "package:easydev_basics/easydev_basics.dart";
```

#### Basics

---

##### EasyDevApp

`EasyDevApp` is core widget to creating apps with EasyDev package, provides `EasyDevScaffoldMessenger` and `EasyDevTheme` to widgets below the widget tree. You can use this widget as any other app, such as `MaterialApp` or `CupertinoApp`.

##### EasyDevScaffold

`EasyDevScaffold` is main layout widget with slots for different widgets, such as `appBar`, `floatingActionButton` and `bottomNavigationBar`. `body` property is a main content of `EasyDevScaffold`. `EasyDevScaffold` must be in widget tree for using `EasyDevScaffoldMessenger` as it manipulates `EasyDevScaffoldState` to show `EasyDevToast` and `EasyDevSnackBar` widgets.

![Screen 1](https://i.ibb.co/d28S4x1/Appbar-bottom-nav-bar-fab.png)

The screenshot above shows the `EasyDevAppBar`, `EasyDevBottomNavigationBar` and `EasyDevFloatingActionButton` built into the `EasyDevScaffold`. Code for this screenshot is shown below.

```
class EasyDevScaffoldExample extends StatefulWidget {
  const EasyDevScaffoldExample({Key? key}) : super(key: key);

  @override
  State<EasyDevScaffoldExample> createState() => _EasyDevScaffoldExampleState();
}

class _EasyDevScaffoldExampleState extends State<EasyDevScaffoldExample> {
  int? _currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'Sample Code',
      ),
      bottomNavigationBar: EasyDevBottomNavigationBar(
        items: [
          EasyDevBottomNavigationBarItem(
            icon: CommunityMaterialIcons.search_web,
            label: 'Search',
            needIndicator: true,
          ),
          EasyDevBottomNavigationBarItem(
            icon: CommunityMaterialIcons.hamburger,
            label: 'Hamburger',
          ),
          EasyDevBottomNavigationBarItem(
            icon: CommunityMaterialIcons.rabbit,
            label: 'Rabbit',
          ),
          EasyDevBottomNavigationBarItem(
            icon: CommunityMaterialIcons.sass,
            label: 'Sass',
            needIndicator: true,
          )
        ],
        currentIndex: _currentIndex,
        onItemTap: (value) => setState(() {
          _currentIndex = value;
        }),
        showLabel: ShowLabel.unselected,
      ),
      floatingActionButton: EasyDevFloatingActionButton(
        onTap: () {},
        child: const Icon(Icons.plus),
      ),
    );
  }
}
```

Note that all of widgets shown below must be wrapped in `EasyDevTheme`. You can provide theme manually using `EasyDevTheme` (from easydev_theme package), `Theme` or `CupertinoTheme` or wrap it with widgets that provide theme automatically such as `EasyDevApp`, `MaterialApp` or `CupertinoApp`.

##### EasyDevAppBar

`EasyDevAppBar` is fixed height widget, that usually placed in top of screen. `EasyDevAppBar` can be used inside `EasyDevScaffold` in `EasyDevScaffold.appbar` field. If you set `addBackButton` to true and not provide `leading` widget, it will add button with function that use `Navigator.of(context).pop()` to navigate back. Example of the `EasyDevAppBar` is shown on screenshot in `EasyDevScaffold` section.

```
const EasyDevScaffold(
  appBar: EasyDevAppBar(
    addBackButton: true,
    actions: [
      Icon(
        Icons.settings,
      ),
      Icon(
        Icons.message,
      ),
    ],
    title: 'EasyDevAppBar',
    titleAlignment: Alignment.centerRight,
    titleStyle: TextStyle(
      fontSize: 24,
    ),
  ),
);
```

##### EasyDevBottomNavigationBar

Bottom navigation bar is a widget that usually placed at bottom of screen. Best way to use it is to pass it to `EasyDevScaffold.bottomNavigationBar` property. Elements of `EasyDevBottomNavigationBar` are passed as simple class `EasyDevBottomNavigationBarItem`, containing only label, icon and boolean field that can show circle indicator on top right corner of icon. It can be used to notify users of something new in that tab. `currentIndex` field is defining what tab is currently selected, and could not be less than zero or larger than `items.length`. Logic of label's appearance can be changed by passing `showLabel` field. Example of the `EasyDevBottomNavigationBar` is shown on screenshot in `EasyDevScaffold` section.

```
EasyDevScaffold(
  bottomNavigationBar: EasyDevBottomNavigationBar(
    items: [
      EasyDevBottomNavigationBarItem(
        icon: CommunityMaterialIcons.search_web,
        label: 'Search',
        needIndicator: true,
      ),
      EasyDevBottomNavigationBarItem(
        icon: CommunityMaterialIcons.hamburger,
        label: 'Hamburger',
      ),
      EasyDevBottomNavigationBarItem(
        icon: CommunityMaterialIcons.rabbit,
        label: 'Rabbit',
      ),
      EasyDevBottomNavigationBarItem(
        icon: CommunityMaterialIcons.sass,
        label: 'Sass',
        needIndicator: true,
      )
    ],
    currentIndex: _currentIndex,
    onItemTap: (value) => setState(() {
      _currentIndex = value;
    }),
    showLabel: ShowLabel.unselected,
  ),
);
```

##### EasyDevFloatingActionButton

Floating action button is a widget that displays elevated button. It should be used for the main action on a screen. It can be passed in `EasyDevScaffold.floatingActionButton` field, and it's offset can be changed with `EasyDevScaffold.fabOffset` field. `EasyDevFloatingActionButton` changes it's color while being pressed unless it is `disabled`. `elevation`, `disabledElevation` and `tapElevation` properties used for changing elevation of the button, depending on button state. Size of button depends on `isLarge` property, it defaults to 40 when `isLarge` is false , and to 56 when `isLarge` is true. Example of the `EasyDevFloatingActionButton` is shown on screenshot in `EasyDevScaffold` section.

```
class FabExample extends StatefulWidget {
  const FabExample({Key? key}) : super(key: key);

  @override
  State<FabExample> createState() => _FabExampleState();
}

class _FabExampleState extends State<FabExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'Sample Code',
      ),
      body: Center(
        child: Text(
          'You have pressed the button $_count times',
          style: context.easyDevTheme.typography?.subheading2Style,
        ),
      ),
      floatingActionButton: EasyDevFloatingActionButton(
        onTap: () => setState(() {
          _count++;
        }),
        child: const Icon(CommunityMaterialIcons.plus),
      ),
    );
  }
}
```

##### EasyDevModalDialog

`EasyDevModalDialog` is a widget that contains base layout for modal dialog. It can be pushed on top of other widgets by using `showEasyDevModalDialog` method by passing it to builder property.

```
Center(
  child: GestureDetector(
    onTap: () {
      showEasyDevModalDialog(
        context: context,
        builder: (context) => const EasyDevModalDialog(
          child: Text('test dialog'),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(24),
      color: theme.colorPalette.primarySwatch,
      child: const Text(
        'Show dialog',
      ),
    ),
  ),
),
```

##### EasyDevBottomSheet

![Screen 2](https://i.ibb.co/WGc1Pp2/bottom-sheet.png)

`EasyDevBottomSheet` is a widget, that can be used as widget on top of the app content, or shown with modal dialog using `showEasyDevBottomSheet` function. If it not used with modal route and `closeByDragging` is true, `onClose` property should be overriden, as it will try to pop current route using `Navigator.of(context).pop()`. Dragging bottom sheet can be disabled using `draggable` property.

```
class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'EasyDevBottomSheet',
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(24),
            color: theme.colorPalette.primarySwatch,
            child: const Text(
              'Show bottom sheet',
            ),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
    final theme = context.easyDevTheme;

    showEasyDevBottomSheet(
      context: context,
      builder: (context) => EasyDevBottomSheet(
        backgroundColor: theme.colorPalette.greySwatch.tappedSurfaceColor?.withOpacity(0.5),
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(24),
                color: theme.colorPalette.primarySwatch,
                child: const Text(
                  'Close bottom sheet',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

##### EasyDevSnackBar

![Screen 3](https://i.ibb.co/kSR2wkc/Snackbar.png)

`EasyDevSnackBar` is used for text notifications. It can have optional action widget such as a button. `EasyDevSnackBar` can be called in `EasyDevApp` or in any other app, if it has `EasyDevScaffoldMessenger` and `EasyDevScaffold` in the widget tree. To call it use `EasyDevScaffoldMessenger.of(context).showSnackbar()` method. `EasyDevSnackBar` can be dismissed by sliding down, if `dismissible` is true.

```
class EasyDevSnackbarExample extends StatelessWidget {
  const EasyDevSnackbarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'EasyDevSnackbar',
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => EasyDevScaffoldMessenger.of(context).showSnackBar(
            const EasyDevSnackBar(title: 'This is snackbar'),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(24),
            color: theme.colorPalette.primarySwatch,
            child: const Text(
              'Show snackbar',
            ),
          ),
        ),
      ),
    );
  }
}
```

##### EasyDevToast

![Screen 4](https://i.ibb.co/LrGdW45/toast-4.png)
![Screen 5](https://i.ibb.co/CPHgDR4/toast-3.png)
![Screen 6](https://i.ibb.co/BfGQw7Q/toast-1.png)
![Screen 7](https://i.ibb.co/Q6Hw8x4/toast-2.png)

`EasyDevToast` is a popup Android style message that shows user some information for certain time period. `EasyDevToast` can be called in `EasyDevApp` or in any other app, if it has `EasyDevScaffoldMessenger` and `EasyDevScaffold` in the widget tree. To call it use `EasyDevScaffoldMessenger.of(context).showToast()` method. Toast requires `title` which contains message. `EasyDevToast.state` provides build-in boilerplates for toast designs for showing in different cases: info toast, warning toast and error toast. Their only difference is color and leading icon. Custom leading icon can be provided with `leadingIcon` property. Also any icons can be removed by passing `removeIcon` property. `EasyDevToast` can have custom content by passing any widget to `content` property.

```
class ToastExample extends StatelessWidget {
  const ToastExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'EasyDevToast',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => EasyDevScaffoldMessenger.of(context).showToast(
              const EasyDevToast(title: 'This is toast'),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              color: theme.colorPalette.primarySwatch,
              child: const Text(
                'Show info toast',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => EasyDevScaffoldMessenger.of(context).showToast(
              const EasyDevToast(
                title: 'This is error toast',
                state: ToastState.error,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              color: theme.colorPalette.primarySwatch,
              child: const Text(
                'Show error toast',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => EasyDevScaffoldMessenger.of(context).showToast(
              const EasyDevToast(
                title: 'This is warning toast',
                state: ToastState.warning,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              color: theme.colorPalette.primarySwatch,
              child: const Text(
                'Show warning toast',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => EasyDevScaffoldMessenger.of(context).showToast(
              const EasyDevToast(
                title: 'This is success toast',
                state: ToastState.success,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              color: theme.colorPalette.primarySwatch,
              child: const Text(
                'Show success toast',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```
