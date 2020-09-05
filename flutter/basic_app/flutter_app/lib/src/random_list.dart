import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_app/src/saved.dart';

// Ctrl + Alt + L 누르면 idnet
// 상태가 변하는 Widget
class RandomList extends StatefulWidget {
  @override
  /*
  State<StatefulWidget> createState() {
    return _RandomList();
  }
  =

  State<StatefulWidget> createState() => _RandomList();

  */
  State<StatefulWidget> createState() => _RandomList();
}

class _RandomList extends State<RandomList> {
  final List<WordPair> _suggestion = <WordPair>[];

  // 라이브러리에서 가져온 WordPair Object 사용
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    final randomWord = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text("Naming App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SavedList(saved: _saved))
              );
            },
          )
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      // 0, 2, 4, 6, 8 ... = real items
      // 1, 3, 5, 7, 9 ... = list dividers
      if (index.isOdd) {
        return Divider();
      }
      var realIndex = index ~/ 2;
      // ~/ = 몫

      if (realIndex >= _suggestion.length) {
        _suggestion.addAll(generateWordPairs().take(10));
      }

      return _buildRow(_suggestion[realIndex]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, textScaleFactor: 1.5),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        // State 가 변경되면 다시 Widget Tree 를 재 실행 해줌
        setState(() {
          if (alreadySaved)
            _saved.remove(pair);
          else
            _saved.add(pair);

          print(_saved.toString());
        });
      },
    );
  }
}
