import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:example_forms/widgets/page_appbar.dart';
import 'package:example_forms/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class InputCodePage extends StatefulWidget {
  const InputCodePage({super.key});

  @override
  State<InputCodePage> createState() => _InputCodePageState();
}

class _InputCodePageState extends State<InputCodePage> {
  var value = '';
  EnterCodeState? successState;
  var successValue = '';
  EnterCodeState? errorState;
  var errorValue = '';

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Enter code without state change',
            child: EnterCodeWithKeyboard(
              value: value,
              title: 'Enter code from message',
              valueChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
              state: EnterCodeState.enabled,
            ),
          ),
          WidgetWrapper(
            label: 'Enter code that successfully loads',
            child: successState != null
                ? EnterCodeWithKeyboard(
                    value: successValue,
                    title: 'Enter code from message',
                    valueChanged: (newValue) async {
                      if (newValue.length == 4) {
                        setState(() {
                          successState = EnterCodeState.loading;
                          successValue = newValue;
                        });
                        await Future.delayed(
                          const Duration(seconds: 2),
                        );
                        setState(() {
                          successState = EnterCodeState.success;
                        });
                        await Future.delayed(
                          const Duration(seconds: 2),
                        );
                        setState(() {
                          successState = null;
                          successValue = '';
                        });
                      } else {
                        setState(() {
                          successValue = newValue;
                        });
                      }
                    },
                    state: successState!,
                  )
                : CodeInputButton(
                    onTap: () {
                      setState(() {
                        successState = EnterCodeState.enabled;
                      });
                    },
                    text: 'Change PIN code',
                  ),
          ),
          WidgetWrapper(
            label: 'Enter code that loads and fails',
            child: errorState != null
                ? EnterCodeWithKeyboard(
                    value: errorValue,
                    title: 'Enter code from message',
                    valueChanged: (newValue) async {
                      if (newValue.length == 4) {
                        setState(() {
                          errorState = EnterCodeState.loading;
                          errorValue = newValue;
                        });
                        await Future.delayed(
                          const Duration(seconds: 2),
                        );
                        setState(() {
                          errorState = EnterCodeState.failure;
                        });
                        await Future.delayed(
                          const Duration(seconds: 2),
                        );
                        setState(() {
                          errorState = null;
                          errorValue = '';
                        });
                      } else {
                        setState(() {
                          errorValue = newValue;
                        });
                      }
                    },
                    state: errorState!,
                  )
                : CodeInputButton(
                    onTap: () {
                      setState(() {
                        errorState = EnterCodeState.enabled;
                      });
                    },
                    text: 'Change PIN code',
                  ),
          ),
          WidgetWrapper(
            label: 'States',
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CodeInputButton(
                      onTap: () {},
                      text: 'Change PIN code',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CodeInputButton(
                      onTap: () {},
                      text: 'Change PIN code',
                      enabled: false,
                    ),
                  ],
                ),
                EnterCodeWithKeyboard(
                  value: '',
                  valueChanged: (_) {},
                  state: EnterCodeState.loading,
                ),
                EnterCodeWithKeyboard(
                  value: '',
                  valueChanged: (_) {},
                  state: EnterCodeState.success,
                ),
                EnterCodeWithKeyboard(
                  value: '',
                  valueChanged: (_) {},
                  state: EnterCodeState.failure,
                ),
              ],
            ),
          ),
          const WidgetWrapper(
            label: 'Static inputs',
            child: Column(
              children: [
                EnterCodeField(
                  value: '',
                  state: EnterCodeState.enabled,
                ),
                EnterCodeField(
                  value: '00',
                  state: EnterCodeState.enabled,
                ),
                EnterCodeField(
                  value: '0000',
                  state: EnterCodeState.enabled,
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Code inputs page',
      ),
    );
  }
}
