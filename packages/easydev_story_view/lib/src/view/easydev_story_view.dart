import 'dart:ui';

import 'package:easydev_story_view/src/view/vertical_drag_to_pop.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:easydev_story_view/src/model/enum/easydev_story_events.dart';
import 'package:easydev_story_view/src/util/story_data_provider.dart';
import 'package:easydev_story_view/src/view/easydev_content_view.dart';

class EasyDevStoryView extends StatefulWidget {
  const EasyDevStoryView({super.key});

  @override
  State<EasyDevStoryView> createState() => _EasyDevStoryViewState();
}

class _EasyDevStoryViewState extends State<EasyDevStoryView> {
  StoryDataProvider? _provider;
  double _delta = 0;
  bool _isAnimating = false;

  @override
  void didChangeDependencies() {
    _provider ??= StoryDataProvider.of(context)!;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _provider!.controller.notifyListeners(StoryEvent.close);

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VerticalDragToPop(
        onDragEndCallBack: _provider!.controller.resume,
        child: GestureDetector(
          onHorizontalDragUpdate: _handleDragUpdate,
          onHorizontalDragEnd: _handleDragEnd,
          onHorizontalDragCancel: () => _delta = 0,
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            pageSnapping: false,
            controller: _provider!.controller.storyController!,
            // Added one more page to detect when user swiped past
            // the last page
            itemBuilder: (context, index) {
              // If user swipes past the last page, return an empty view
              // before closing story view.
              if (index >= _provider!.controller.storyCount) {
                return const SizedBox();
              }

              final ValueNotifier<Widget> content = ValueNotifier(const SizedBox.shrink());
              () async {
                final story = await _provider!.storyBuilder(index);

                content.value = EasyDevContentView(
                  storyIndex: index,
                  story: story,
                );
              }();

              return ValueListenableBuilder<Widget>(
                valueListenable: content,
                builder: (context, value, child) => value,
              );
            },
            onPageChanged: _handlePageChange,
          ),
        ),
      ),
    );
  }

  void _handlePageChange(int index) {
    // User reached to the last page, close story view.
    if (index == _provider!.controller.storyCount) {
      _provider!.controller.cleanContentIndexes();
      Navigator.of(context).pop();
    } else {
      _provider!.controller.handleStoryChange(index);
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_isAnimating) return;
    final delta = details.primaryDelta!;
    final storyController = _provider!.controller;
    final storyPageController = storyController.storyController!;

    // Prevent right scroll on first story
    if (storyPageController.page!.round() == 0 && delta > 0) {
      storyController.resume();
      return;
    }

    _delta += delta;
    storyPageController.jumpTo(-delta + storyPageController.position.pixels);

    final physicalSize = PlatformDispatcher.instance.views.first.physicalSize;
    final devicePixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
    final width = (physicalSize / devicePixelRatio).width;

    if (_delta.abs() < width * .2) {
      storyController.resume();
    }
  }

  void _handleDragEnd(_) {
    final storyPageController = _provider!.controller.storyController!;

    final physicalSize = PlatformDispatcher.instance.views.first.physicalSize;
    final devicePixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
    final width = (physicalSize / devicePixelRatio).width;

    final bound = _delta.abs() > width * 0.2;

    final addition = _delta < 0 ? 1 : -1;
    final contPage = storyPageController.page!.round();
    final page = _delta.abs() < width * 0.5 && bound ? contPage + addition : contPage;

    _isAnimating = true;
    const duration = Duration(milliseconds: 300);

    storyPageController.animateToPage(
      page,
      curve: Curves.ease,
      duration: duration,
    );
    Future.delayed(
      duration,
      () {
        _delta = 0;
        _isAnimating = false;
      },
    );
  }
}
