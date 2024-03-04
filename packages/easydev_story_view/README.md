# easydev_story_view

---

Story view for applications, using easydev ui kit

![Screen 1](https://i.ibb.co/jg8vSL5/Screenshot-1706771071.png)

![Screen 2](https://i.ibb.co/jWjPpF3/Screenshot-1706771177.png)

![Screen 1](https://i.ibb.co/7yP4syJ/Screenshot-1706771200.png)

This a Flutter widget, used to display stories in applications, using easydev ui kit. Comes with gestures to pause, forward and go to previous page and with ability to customize stories.

## Features

---

- Gestures for pause, switching between stories and closing them with drag animation.
- Built-in support for pictures and videos, as well as the ability to create custom stories.
- Animated progress indicator.
- Built-in footers, as well as ability to create custom footers.
- Controller for managing stories.

## Installation

---

To use this package, add easydev_story_view and easydev_theme as a dependency in your pubspec.yaml file.

## Usage

---

Import package into your code:

```
import "package:easydev_story_view/easydev_story_view.dart";
```

`EasyDevStory` must be wrapped in `EasyDevTheme`. You can provide theme manually using `EasyDevTheme` (from easydev_theme package), `Theme` or `CupertinoTheme` or wrap it with widgets that provide theme automatically such as `EasyDevApp`(from easydev_basics package), `MaterialApp` or `CupertinoApp`.

#### Basics

---

##### EasyDevStory

Use `EasyDevStory` to add stories to screen or view heirarchy. `EasyDevStory` requires `storyCount` to determine how many stories will be displayed, `storyBuilder` to build stories and `sliderBuilder` to build widgets, showing in list of all stories for each story. In `storyBuilder` `Story` widgets must be returned.

```
EasyDevStory(
    storyCount: 10,
    storyBuilder: (storyIndex) => Story(...),
    sliderBuilder: (storyIndex) => ...
),
```

##### Story

`Story` requires `contentCount` to determine how many slides will be displayed in story and `contentBuilder` to build story content. In `contentBuilder` `EasyDevStoryContent` widgets must be returned.

```
Story(
   contentCount: 5,
   contentBuilder: (contentIndex) => EasyDevStoryContent(...),
),
```

##### EasyDevStoryContent

There are three built-in widgtes of `EasyDevStoryContent`:

- `ImageContent` for displaying images.
- `VideoContent` for displaying videos.
- `SimpleCustomContent` for displaying synchronous contents.

To create custom content you need to create widget that extends `StoryContent`.

##### Slider items

There are two built-in widgets to use in sliderBuilder:

- `SimpleCustomSlideItem` for displaying synchronous contents.
- `ImageNetworkSlideItem` for displaying network images.

You can create your own custom slider item and pass it to sliderBuilder.

##### Basic example

Below is a basic example of using stories.

```
...
@override
  Widget build(BuildContext context) {
    const firstStoryContent = <EasyDevStoryContent>[
      ImageContent(
        url: 'https://loremflickr.com/600/900',
        timeout: Duration(seconds: 10),
        duration: Duration(seconds: 15),
      ),
      VideoContent(
        url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        timeout: Duration(seconds: 10),
      ),
    ];

    final secondStoryContent = [
      SimpleCustomContent(
        duration: const Duration(seconds: 5),
        builder: (context) {
          return const Text('Simple custom story 1');
        },
      ),
      SimpleCustomContent(
        duration: const Duration(seconds: 5),
        builder: (context) {
          return const Text('Simple custom story 2');
        },
      )
    ];

    final stories = [firstStoryContent, secondStoryContent];
    final storiesSliders = [
      const SimpleCustomSlideItem(
        width: 120,
        height: 120,
        text: 'Large large text',
      ),
      const ImageNetworkSlideItem(
        url: 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
        width: 120,
        height: 120,
      )
    ];

    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: EasyDevStory(
              storyCount: stories.length,
              storyBuilder: (storyIndex) => Story(
                contentCount: stories[storyIndex].length,
                contentBuilder: (contentIndex) => stories[storyIndex][contentIndex],
              ),
              sliderBuilder: (storyIndex) {
                return storiesSliders[storyIndex];
              },
            ),
          ),
        ],
      ),
    );
  }
```

#### Additional customization

---

##### EasyDevStoryStyle

Use `EasyDevStoryStyle` to castomize appearance of story widgets.

```
EasyDevStory(
    ...
    style: const EasyDevStoryStyle(
        sliderStyle: SliderStyle(
        spacing: 10,
        padding: EdgeInsets.zero,
        ),
        indicatorStyle: IndicatorStyle(),
    ),
),
```

##### StoryFooter

You can add a footer to the story content. There are two built-in footers: `StoryFooter.large` and `StoryFooter.small`. You can create your custom widget and pass it to `EasyDevStory`.

```
EasyDevStory(
    ...
    footer: StoryFooter.large(
        mainButtonLabel: "Learn More",
        onMainButton: () => ...,
        onButtonLikeTap: (bool state) => ...,
        onButtonShareTap: () => ...,
        onButtonBookmarkTap: (bool state) => ...,
        likeInitState: ...,
        bookmarkInitState: ...,
    ),
),
```

##### EasyDevStoryController

You can add controller to stories to manage them.

```
...
final EasyDevStoryController controller = EasyDevStoryController();
...
EasyDevStory(
    ...
    controller: controller,
),
```
