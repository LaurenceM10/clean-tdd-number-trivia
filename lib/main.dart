import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_tdd/injection_container.dart' as di;
import 'package:flutter_clean_architecture_tdd/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}
