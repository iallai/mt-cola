// Step 4: Create an infinite scrolling lazily loaded list

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '猫图可乐',
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('猫图可乐 - 智慧工单系统'),
      ),
      body: _buildSuggestions(),
      floatingActionButton: new FloatingActionButton(
        tooltip: '添加',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();
     
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index],index);
      },
    );
  }

  Widget _buildRow(WordPair pair,int index) {
    final beSaved = _saved.contains(pair);
    final _index =index.toString();
    // final index =index;
    return new ListTile(
      title: new Text(
        "工单"+_index,
        style: _biggerFont,
      ),
      subtitle: new Text("描述"+pair.asPascalCase),
      // c: new Text("1"),
      trailing:new Icon(
        beSaved?Icons.alarm_on:Icons.alarm,
        color: beSaved?Colors.red:null
      ),
      onTap: (){
        setState(() {
                  if(beSaved){
                    _saved.remove(pair);
                  }else{
                    _saved.add(pair);
                  }
                });
      },
    );
  }
}