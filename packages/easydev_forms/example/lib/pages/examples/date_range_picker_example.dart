import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      lightThemeData: defaultLightTheme,
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: Center(
        child: EasyDevDateRangePicker(
          endDate: DateTime(2024, 12),
          startDate: DateTime(1800),
          onSelectTap: (value) {
            setState(
              () {
                _controller1.value = TextEditingValue(
                  text: DateFormat('dd.MM.yyyy').format(value.start),
                );
                _controller2.value = TextEditingValue(
                  text: DateFormat('dd.MM.yyyy').format(value.end),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
