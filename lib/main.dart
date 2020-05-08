import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:developer';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random(); // Add this line.
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: RandomWords()
    );
  }
}

class RandomWordState extends State<RandomWords>{
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  final Set<WordPair> _saved = Set<WordPair>();

    void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(   // Add 20 lines from here...
          builder: (BuildContext context) {
            final Iterable<ListTile> tiles = _saved.map(
                  (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
            );
            final List<Widget> divided = ListTile
                .divideTiles(
              context: context,
              tiles: tiles,
            )
                .toList();

            return Scaffold(         // Add 6 lines from here...
              appBar: AppBar(
                title: Text('Saved Suggestions'),
              ),
              body: ListView(children: divided),
            );
          },
        ),                       // ... to here.
      );
  }
  @override

  Widget build(BuildContext context) {
//    final wordPair = WordPair.random();
//    return Text(wordPair.asPascalCase);
    return Scaffold (                   // Add from here...
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestion(),
    );
  }

  Widget _buildSuggestion(){
    return ListView.builder(
        padding: const EdgeInsets.all(16),

        itemBuilder: (BuildContext _context, int i){
          if(i.isOdd){
            return Divider();
          }
          debugPrint('value: $i');

          final int index = i ~/ 2;

          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(
        pair.asPascalCase,
        style: _biggerFont,
    ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),
      onTap: (){
          setState(() {
            if(alreadySaved){
              _saved.remove(pair);
            }else{
              _saved.add(pair);
            }
          });
      },
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
    RandomWordState createState() => RandomWordState();

}


