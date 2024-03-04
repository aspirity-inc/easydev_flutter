import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example/pages/input_page/input_page_persistent_header_delegate.dart';
import 'package:example/widgets/page_appbar.dart';
import 'package:example/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int selectedState = 0;
  bool obscurePassword = true;
  final _phoneFocus1 = FocusNode();
  final _phoneFocus2 = FocusNode();

  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController1 = TextEditingController();
  final _phoneController2 = TextEditingController();

  final maskedFormatterRu = DigitMaskedInputFormatter(mask: '(###) ###-##-##');
  final maskedFormatter86 = DigitMaskedInputFormatter(mask: '## ########');
  final states = InputState.values.where((element) => element != InputState.filled).toList();

  @override
  void initState() {
    _phoneFocus1.addListener(() {
      setState(() {});
    });
    _phoneFocus2.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: InputPagePersistentHeaderDelegate(
              context,
              ColoredBox(
                color: theme.colorPalette.greySwatch.backgroundColor ??
                    theme.colorPalette.greySwatch.surfaceColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Change inputs state using this button',
                        style: theme.typography?.heading2Style,
                      ),
                    ),
                    EasyDevButton.primary(
                      text: states[selectedState].name,
                      onTap: () => setState(() {
                        if (selectedState == states.length - 1) {
                          selectedState = 0;
                        } else {
                          selectedState++;
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                WidgetWrapper(
                  label: 'Text field without label',
                  child: EasyDevTextField(
                    hint: 'Input',
                    key: const Key('test_input'),
                    controller: _controller,
                    inputState: states[selectedState],
                    focusedTrailingIcon: EasyDevIconButton(
                      CommunityMaterialIcons.close,
                      size: 28,
                      onTap: () {
                        _controller.text = '';
                      },
                    ),
                    error: 'Error text',
                    helperText: 'Helper text',
                    successText: 'Success',
                    loadingText: 'Loading',
                  ),
                ),
                WidgetWrapper(
                  label: 'Text field with label',
                  child: EasyDevTextField(
                    controller: _controller2,
                    label: 'Input',
                    error: 'Error text',
                    successText: 'Success',
                    helperText: '',
                    loadingText: 'Loading',
                    inputState: states[selectedState],
                    focusedTrailingIcon: EasyDevIconButton(
                      CommunityMaterialIcons.close,
                      size: 28,
                      onTap: () {
                        _controller2.text = '';
                      },
                    ),
                  ),
                ),
                WidgetWrapper(
                  label: 'Password text field',
                  child: EasyDevTextField(
                    label: 'Password',
                    valueChanged: (value) {
                      setState(() {});
                    },
                    trailingIcon: EasyDevIconButton(
                      obscurePassword ? EasyDevIcons.eyeClose : EasyDevIcons.eyeOpen,
                      onTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    linkWidget: _getPasswordLinkWidget,
                    obscureText: obscurePassword,
                    inputState: states[selectedState],
                    helperTrailingIcon: states[selectedState] == InputState.success
                        ? Icon(
                            CommunityMaterialIcons.check_circle_outline,
                            size: 16,
                            color: theme.colorPalette.successSwatch,
                          )
                        : null,
                    error: 'Invalid password',
                    loadingText: 'Wait a minute, please',
                    successText: 'Success',
                    helperText: _getPasswordHelperText,
                    controller: _passwordController,
                  ),
                ),
                WidgetWrapper(
                  label: 'Phone text field',
                  child: EasyDevTextField(
                    focusNode: _phoneFocus1,
                    controller: _phoneController1,
                    label: 'Phone number',
                    trailingIcon: getPhoneNumberIcon(states[selectedState]),
                    focusedTrailingIcon: EasyDevIconButton(
                      CommunityMaterialIcons.close,
                      size: 28,
                      onTap: () {
                        _phoneController1.text = '';
                      },
                    ),
                    prefixText: const Text(
                      '+7 ',
                    ),
                    hint: '(999) 000-00-00',
                    decoration: EasyDevInputDecoration(
                      alwaysShowHint: true,
                      iconColor: _phoneFocus1.hasFocus ? null : _getIconColor(theme),
                    ),
                    inputState: states[selectedState],
                    inputFormatters: [
                      maskedFormatterRu,
                    ],
                    helperText: '',
                    loadingText: 'Loading',
                    error: 'Error',
                    successText: 'Success',
                    textInputType: TextInputType.number,
                  ),
                ),
                WidgetWrapper(
                  label: 'Phone text field with code +86 xx xxxxxxxx',
                  child: EasyDevTextField(
                    focusNode: _phoneFocus2,
                    controller: _phoneController2,
                    label: 'Phone number',
                    trailingIcon: getPhoneNumberIcon(states[selectedState]),
                    focusedTrailingIcon: EasyDevIconButton(
                      CommunityMaterialIcons.close,
                      onTap: () {
                        _phoneController1.text = '';
                      },
                    ),
                    prefixText: const Text(
                      '+86 ',
                    ),
                    hint: '00 00000000',
                    decoration: EasyDevInputDecoration(
                      alwaysShowHint: true,
                      iconColor: _phoneFocus2.hasFocus ? null : _getIconColor(theme),
                    ),
                    inputState: states[selectedState],
                    inputFormatters: [
                      maskedFormatter86,
                    ],
                    helperText: '',
                    loadingText: 'Loading',
                    error: 'Error',
                    successText: 'Success',
                    textInputType: TextInputType.number,
                  ),
                ),
                WidgetWrapper(
                  label: 'Small text field',
                  child: Row(
                    children: [
                      EasyDevTextField(
                        decoration: const EasyDevInputDecoration(
                          minWidth: 200,
                        ),
                        label: 'Input',
                        inputState: _getStateForLastFields,
                      ),
                    ],
                  ),
                ),
                WidgetWrapper(
                  label: 'Multiline text',
                  child: EasyDevTextField(
                    label: 'Input',
                    minLines: 3,
                    maxLines: 3,
                    showTextLength: true,
                    maxLength: 100,
                    alignment: AlignmentDirectional.topStart,
                    inputState: _getStateForLastFields,
                  ),
                ),
                WidgetWrapper(
                  label: 'Expandable text',
                  child: EasyDevTextField(
                    label: 'Input',
                    minLines: 1,
                    expandsWithNewLines: true,
                    alignment: AlignmentDirectional.topStart,
                    inputState: _getStateForLastFields,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Inputs page',
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _controller.dispose();
    _controller2.dispose();
    _phoneController1.dispose();
    _phoneController2.dispose();
    _phoneFocus1.dispose();
    _phoneFocus2.dispose();
    super.dispose();
  }

  Widget? getPhoneNumberIcon(InputState state) {
    switch (state) {
      case InputState.error:
        return const EasyDevIconButton(CommunityMaterialIcons.alert_circle_outline);
      case InputState.success:
        return const EasyDevIconButton(CommunityMaterialIcons.check_circle_outline);
      case InputState.loading:
        return const EasyDevLoadingIndicator();
      default:
        return null;
    }
  }

  Color? _getIconColor(EasyDevThemeData theme) {
    if (states[selectedState] == InputState.error) {
      return theme.colorPalette.errorSwatch;
    } else if (states[selectedState] == InputState.success) {
      return theme.colorPalette.successSwatch;
    }

    return null;
  }

  String? get _getPasswordHelperText {
    if (states[selectedState] == InputState.disabled ||
        (states[selectedState] == InputState.enabled && _passwordController.text.length >= 6)) {
      return null;
    }

    return '6 or more characters';
  }

  Widget? get _getPasswordLinkWidget {
    if (states[selectedState] == InputState.loading ||
        states[selectedState] == InputState.success) {
      return null;
    }

    return const Text('Forgot the password?');
  }

  InputState get _getStateForLastFields {
    if (states[selectedState] == InputState.error ||
        states[selectedState] == InputState.loading ||
        states[selectedState] == InputState.success) {
      return InputState.enabled;
    } else {
      return states[selectedState];
    }
  }
}
