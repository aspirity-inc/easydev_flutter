
import 'package:easydev_forms/easydev_forms.dart';

/// State that manipulate view of [EnterCodeField] and [EnterCodeWithKeyboard],
/// they provide a way to specifying common behaviors in code entering, like loading code
/// verification code successfully verified and code verified with error.
enum EnterCodeState {
  enabled,
  loading,
  success,
  failure,
}
