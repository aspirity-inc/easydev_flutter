import 'package:easydev_base_ui/src/widgets/easydev_social_media_button/easydev_social_media_button_size.dart';
import 'package:easydev_base_ui/src/widgets/easydev_social_media_button/easydev_social_media_button_type.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Social media button. Should be used on "sign-in" pages to give
/// user option for signing in with social media.
/// Constructors are provided for creating buttons for different social media
/// platforms such as Google, Facebook, Apple, Vkontakte, and Twitter.
/// Each constructor requires a [onTap] callback for handling button taps
/// and allows customization of [type] for visual appearance and [size] for button size.
/// The default [type] is set to [EasyDevSocialMediaButtonType.noBackground],
/// while the default [size] is [EasyDevSocialMediaButtonSize.large].
///
///
/// Example of using [EasyDevSocialMediaButton.apple].
/// ```dart
/// EasyDevSocialMediaButton.apple(
///   onTap: () {
///     // Add your onTap code here!
///   }
///   type: EasyDevSocialMediaButtonType.noBackground,
/// ),
/// ```
///
/// Example of using [EasyDevSocialMediaButton.google].
/// ```dart
/// EasyDevSocialMediaButton.google(
///   onTap: () {
///     // Add your onTap code here!
///   }
///   type: EasyDevSocialMediaButtonType.noBackground,
/// ),
/// ```
///
/// Example of using [EasyDevSocialMediaButton.x].
/// ```dart
/// EasyDevSocialMediaButton.twitter(
///   onTap: () {
///     // Add your onTap code here!
///   }
///   type: EasyDevSocialMediaButtonType.noBackground,
/// ),
/// ```
///
/// /// Example of using [EasyDevSocialMediaButton.vk].
/// ```dart
/// EasyDevSocialMediaButton.vk(
///   onTap: () {
///     // Add your onTap code here!
///   }
///   type: EasyDevSocialMediaButtonType.noBackground,
/// ),
/// ```
///
/// /// Example of using [EasyDevSocialMediaButton.facebook].
/// ```dart
/// EasyDevSocialMediaButton.facebook(
///   onTap: () {
///     // Add your onTap code here!
///   }
///   type: EasyDevSocialMediaButtonType.noBackground,
/// ),
/// ```
///
///
/// This sample produces variants of EasyDevOnboarding.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_social_media_button_example.dart
sealed class EasyDevSocialMediaButton extends StatelessWidget {
  const EasyDevSocialMediaButton._({
    super.key,
    required this.onTap,
    this.type = EasyDevSocialMediaButtonType.noBackground,
    this.size = EasyDevSocialMediaButtonSize.large,
  });

  /// Constructor for creating Google button.
  const factory EasyDevSocialMediaButton.google({
    required VoidCallback onTap,
    EasyDevSocialMediaButtonType type,
    EasyDevSocialMediaButtonSize size,
  }) = _EasyDevSocialMediaButtonGoogle;

  /// Constructor for creating Facebook button.
  const factory EasyDevSocialMediaButton.facebook({
    required VoidCallback onTap,
    EasyDevSocialMediaButtonType type,
    EasyDevSocialMediaButtonSize size,
  }) = _EasyDevSocialMediaButtonFacebook;

  /// Constructor for creating Apple button.
  const factory EasyDevSocialMediaButton.apple({
    required VoidCallback onTap,
    EasyDevSocialMediaButtonType type,
    EasyDevSocialMediaButtonSize size,
  }) = _EasyDevSocialMediaButtonApple;

  /// Constructor for creating Vkontakte button.
  const factory EasyDevSocialMediaButton.vk({
    required VoidCallback onTap,
    EasyDevSocialMediaButtonType type,
    EasyDevSocialMediaButtonSize size,
  }) = _EasyDevSocialMediaButtonVk;

  /// Constructor for creating X (Twitter) button.
  const factory EasyDevSocialMediaButton.x({
    required VoidCallback onTap,
    EasyDevSocialMediaButtonType type,
    EasyDevSocialMediaButtonSize size,
  }) = _EasyDevSocialMediaButtonX;

  /// Callback for tapping.
  final VoidCallback onTap;

  /// Type of visual appearance of the button.
  ///
  /// Default is [EasyDevSocialMediaButtonType.noBackground].
  final EasyDevSocialMediaButtonType type;

  /// Size of the button.
  ///
  /// Default is [EasyDevSocialMediaButtonSize.large].
  final EasyDevSocialMediaButtonSize size;

  Color _getBackgroundColor(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;

    return switch (type) {
      EasyDevSocialMediaButtonType.noBackground => size == EasyDevSocialMediaButtonSize.iconOnly
          ? const Color(0x00000000)
          : const Color(0xFFFFFFFF),
      EasyDevSocialMediaButtonType.withBackground => switch (size) {
          EasyDevSocialMediaButtonSize.iconOnly => const Color(0xFFFFFFFF),
          _ => switch (this) {
              _EasyDevSocialMediaButtonX() => const Color(0xFF000000),
              _EasyDevSocialMediaButtonApple() => const Color(0xFF000000),
              _EasyDevSocialMediaButtonFacebook() => const Color(0xFF1877F2),
              _ => const Color(0xFFFFFFFF),
            },
        },
      EasyDevSocialMediaButtonType.colorful => light
          ? (theme.colorPalette.secondarySwatch?[600] ?? theme.brightness.surfaceColor)
          : theme.colorPalette.secondarySwatch?[500] ?? theme.brightness.surfaceColor,
      EasyDevSocialMediaButtonType.monochrome => theme.colorPalette.greySwatch.surfaceColor,
    };
  }

  List<BoxShadow>? _getShadow(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    if (type == EasyDevSocialMediaButtonType.withBackground ||
        (light && type == EasyDevSocialMediaButtonType.monochrome)) {
      return [
        BoxShadow(
          color: theme.brightness == Brightness.light
              ? (theme.colorPalette.greySwatch.tappedSurfaceColor ??
                  theme.colorPalette.greySwatch.surfaceColor)
              : theme.colorPalette.greySwatch.surfaceColor,
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 1.5),
        )
      ];
    }
    return null;
  }

  ColorFilter? _getIconColorFilter(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    const colorfulFilter = ColorFilter.mode(
      Color(0xFFFFFFFF),
      BlendMode.srcIn,
    );
    final monochromeFilter = ColorFilter.mode(
      light
          ? (theme.colorPalette.secondarySwatch?[700] ?? theme.colorPalette.primarySwatch)
          : theme.colorPalette.primarySwatch[400] ?? theme.brightness.onSurfaceColor,
      BlendMode.srcIn,
    );

    return switch (type) {
      EasyDevSocialMediaButtonType.withBackground => switch (size) {
          EasyDevSocialMediaButtonSize.iconOnly => null,
          _ => switch (this) {
              _EasyDevSocialMediaButtonFacebook() => const ColorFilter.mode(
                  Color(0xFFFFFFFF),
                  BlendMode.srcIn,
                ),
              _EasyDevSocialMediaButtonApple() => const ColorFilter.mode(
                  Color(0xFFFFFFFF),
                  BlendMode.srcIn,
                ),
              _ => null,
            },
        },
      EasyDevSocialMediaButtonType.colorful => switch (this) {
          _EasyDevSocialMediaButtonFacebook() => colorfulFilter,
          _EasyDevSocialMediaButtonApple() => colorfulFilter,
          _EasyDevSocialMediaButtonGoogle() => colorfulFilter,
          _ => null,
        },
      EasyDevSocialMediaButtonType.monochrome => switch (this) {
          _EasyDevSocialMediaButtonFacebook() => monochromeFilter,
          _EasyDevSocialMediaButtonApple() => monochromeFilter,
          _EasyDevSocialMediaButtonGoogle() => monochromeFilter,
          _ => null,
        },
      _ => null,
    };
  }

  Widget _getIcon(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    final assetName = switch (this) {
      _EasyDevSocialMediaButtonGoogle() => 'assets/google.svg',
      _EasyDevSocialMediaButtonFacebook() => 'assets/facebook.svg',
      _EasyDevSocialMediaButtonApple() => 'assets/apple.svg',
      _EasyDevSocialMediaButtonVk() => switch (type) {
          EasyDevSocialMediaButtonType.colorful =>
            light ? 'assets/vk_colorful_light.svg' : 'assets/vk_colorful_dark.svg',
          EasyDevSocialMediaButtonType.monochrome =>
            light ? 'assets/vk_light_monochrome.svg' : 'assets/vk_dark_monochrome.svg',
          _ => 'assets/vk.svg',
        },
      _EasyDevSocialMediaButtonX() => switch (type) {
          EasyDevSocialMediaButtonType.colorful => 'assets/twitter_colorful_light.svg',
          EasyDevSocialMediaButtonType.monochrome =>
            light ? 'assets/twitter_light_monochrome.svg' : 'assets/twitter_dark_monochrome.svg',
          _ => 'assets/twitter.svg',
        }
    };

    return SvgPicture.asset(
      assetName,
      width: 24,
      height: 24,
      package: 'easydev_base_ui',
      colorFilter: _getIconColorFilter(theme),
    );
  }

  BoxBorder? _getBorder(EasyDevThemeData theme) {
    if (type == EasyDevSocialMediaButtonType.noBackground &&
        size != EasyDevSocialMediaButtonSize.iconOnly &&
        theme.brightness == Brightness.light) {
      return Border.all(
          color: theme.colorPalette.secondarySwatch?[700] ?? theme.colorPalette.primarySwatch);
    }
    return null;
  }

  String _getText(EasyDevThemeData theme) {
    return switch (this) {
      _EasyDevSocialMediaButtonGoogle() => 'Sign In with Google',
      _EasyDevSocialMediaButtonFacebook() => 'Sign In with Facebook',
      _EasyDevSocialMediaButtonApple() => 'Sign In with Apple',
      _EasyDevSocialMediaButtonVk() => 'Sign In with Vkontakte',
      _EasyDevSocialMediaButtonX() => 'Sign In with X',
    };
  }

  Color _getTextColor(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    return switch (type) {
      EasyDevSocialMediaButtonType.withBackground => switch (this) {
          _EasyDevSocialMediaButtonFacebook() => const Color(0xFFFFFFFF),
          _EasyDevSocialMediaButtonApple() => const Color(0xFFFFFFFF),
          _EasyDevSocialMediaButtonX() => const Color(0xFFFFFFFF),
          _ => light
              ? theme.colorPalette.greySwatch.onBackgroundColor ??
                  theme.colorPalette.greySwatch.onSurfaceColor
              : theme.colorPalette.greySwatch.surfaceColor,
        },
      EasyDevSocialMediaButtonType.colorful => const Color(0xFFFFFFFF),
      EasyDevSocialMediaButtonType.monochrome => light
          ? (theme.colorPalette.secondarySwatch?[700] ?? theme.colorPalette.primarySwatch)
          : theme.colorPalette.primarySwatch[400] ?? theme.brightness.onSurfaceColor,
      _ => light
          ? theme.colorPalette.greySwatch.onBackgroundColor ??
              theme.colorPalette.greySwatch.onSurfaceColor
          : theme.colorPalette.greySwatch.surfaceColor,
    };
  }

  TextStyle _getTextStyle(EasyDevThemeData theme) {
    return TextStyle(
      fontFamily: "RobotoFlex",
      fontSize: 16,
      fontVariations: const [
        FontVariation("wdth", 100),
        FontVariation("GRAD", 25),
        FontVariation("slnt", 0),
        FontVariation("XTRA", 468),
        FontVariation("YOPQ", 79),
        FontVariation("YTLC", 514),
        FontVariation("YTUC", 712),
        FontVariation("YTAS", 750),
        FontVariation("YTDE", -203),
        FontVariation("YTFI", 738),
        FontVariation("wght", 568),
      ],
      color: _getTextColor(theme),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: size == EasyDevSocialMediaButtonSize.iconOnly
            ? const EdgeInsets.all(4)
            : const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        width: size == EasyDevSocialMediaButtonSize.small ? 224 : null,
        decoration: BoxDecoration(
          boxShadow: _getShadow(theme),
          color: _getBackgroundColor(theme),
          border: _getBorder(theme),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: size == EasyDevSocialMediaButtonSize.iconOnly
            ? _getIcon(theme)
            : Row(
                mainAxisSize: size == EasyDevSocialMediaButtonSize.large
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getIcon(theme),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getText(theme),
                      style: _getTextStyle(theme),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _EasyDevSocialMediaButtonGoogle extends EasyDevSocialMediaButton {
  const _EasyDevSocialMediaButtonGoogle({
    required super.onTap,
    super.type,
    super.size,
  }) : super._();
}

class _EasyDevSocialMediaButtonFacebook extends EasyDevSocialMediaButton {
  const _EasyDevSocialMediaButtonFacebook({
    required super.onTap,
    super.type,
    super.size,
  }) : super._();
}

class _EasyDevSocialMediaButtonApple extends EasyDevSocialMediaButton {
  const _EasyDevSocialMediaButtonApple({
    required super.onTap,
    super.type,
    super.size,
  }) : super._();
}

class _EasyDevSocialMediaButtonVk extends EasyDevSocialMediaButton {
  const _EasyDevSocialMediaButtonVk({
    required super.onTap,
    super.type,
    super.size,
  }) : super._();
}

class _EasyDevSocialMediaButtonX extends EasyDevSocialMediaButton {
  const _EasyDevSocialMediaButtonX({
    required super.onTap,
    super.type,
    super.size,
  }) : super._();
}
