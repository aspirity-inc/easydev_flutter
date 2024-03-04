import 'dart:ui';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/widgets.dart';

import 'package:easydev_story_view/src/controller/easydev_content_controller.dart';
import 'package:easydev_story_view/src/model/story.dart';
import 'package:easydev_story_view/src/model/story_position.dart';
import 'package:easydev_story_view/src/util/story_data_provider.dart';
import 'package:easydev_story_view/src/util/content_position_provider.dart';
import 'package:easydev_story_view/src/view/components/story_indicator.dart';

// Widget for displaying content of the story
class EasyDevContentView extends StatefulWidget {
  // Creates story content
  const EasyDevContentView({
    required this.storyIndex,
    required this.story,
    super.key,
  });

  // Index of the story that currently displayed
  final int storyIndex;

  // Currently displayed story
  final Story story;

  @override
  State<EasyDevContentView> createState() => _EasyDevContentViewState();
}

class _EasyDevContentViewState extends State<EasyDevContentView> {
  EasyDevContentPageController? _pageController;
  StoryDataProvider? _provider;

  @override
  void didChangeDependencies() {
    _provider ??= StoryDataProvider.of(context)!;
    final initialPage = _provider?.controller.contentIndexes[widget.storyIndex] ?? 0;
    _pageController ??= EasyDevContentPageController(
      itemCount: widget.story.contentCount,
      initialPage: initialPage,
    );
    _provider!.controller.setContentController(_pageController!, widget.storyIndex);

    super.didChangeDependencies();
  }

  void _handleTapUp(TapUpDetails event) {
    final x = event.localPosition.dx;
    final physicalSize = PlatformDispatcher.instance.views.first.physicalSize;
    final devicePixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
    final viewWidth = (physicalSize / devicePixelRatio).width;

    if (x > viewWidth * .5) {
      _provider!.controller.toNextContent();
    } else if (x < viewWidth * .5) {
      _provider!.controller.toPreviousContent();
    } else {
      _provider!.controller.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onLongPressDown: (_) => _provider!.controller.pause,
          onLongPressCancel: _provider!.controller.resume,
          onLongPressUp: _provider!.controller.resume,
          onLongPress: _provider!.controller.pause,
          onTapUp: _handleTapUp,
          child: Padding(
            padding: _provider!.style.margin,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.story.contentCount,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Widget content = ClipRRect(
                  borderRadius: _provider!.style.borderRadius,
                  child: widget.story.contentBuilder(index),
                );

                if (widget.story.bottomPadding != null) {
                  content = Padding(
                    padding: EdgeInsets.only(
                      bottom: widget.story.bottomPadding!,
                    ),
                    child: content,
                  );
                }

                return ContentPositionProvider(
                  position: StoryPosition(index, widget.storyIndex),
                  child: content,
                );
              },
            ),
          ),
        ),
        Padding(
          padding: _provider!.style.margin,
          child: ValueListenableBuilder(
            valueListenable: _provider!.positionNotifier,
            builder: (context, value, child) {
              return value == widget.storyIndex
                  ? StoryIndicator(
                      activeIndicatorIndex:
                          _pageController!.page?.toInt() ?? _pageController!.initialPage.toInt(),
                      count: widget.story.contentCount,
                      controller: _provider!.controller.playbackController.indicatorController,
                      style: _provider!.style.indicatorStyle,
                    )
                  : StoryIndicator.placeholder(
                      count: widget.story.contentCount,
                      style: _provider!.style.indicatorStyle,
                    );
            },
          ),
        ),
        _provider!.withCloseButton
            ? Positioned(
                top: size.height * .09,
                right: size.width * .05 + _provider!.style.margin.horizontal / 2,
                child: GestureDetector(
                  onTap: () {
                    _provider!.controller.resume;
                    _provider!.controller.cleanContentIndexes();
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      CommunityMaterialIcons.close,
                      color: _provider!.style.closeButtonColor,
                      size: 32,
                      shadows: const [
                        BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 5,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Padding(
          padding: _provider!.style.margin,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: widget.story.footer != null ? widget.story.footer! : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
