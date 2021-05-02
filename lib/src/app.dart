import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/presentation/pages/number_trivia_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: NumberTriviaPage(),
    );
  }
}