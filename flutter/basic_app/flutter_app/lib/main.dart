import 'package:flutter/material.dart';
// Material Design 라이브러리
import 'package:english_words/english_words.dart';
// 랜덤 영어 단어 라이브러리
import 'src/random_list.dart';

void main() => runApp(MyApp());

// Flutter 에서 Component 를 Widget 이라고 부름

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final randomWord = WordPair.random();
    return MaterialApp(
      home: RandomList(),
    );
  }
  
}