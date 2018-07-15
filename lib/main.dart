// Step 4: Create an infinite scrolling lazily loaded list

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:io';
import 'dart:convert';

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
  var httpClient = new HttpClient();

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
                    _getIPAddress();
                  }else{
                    _saved.add(pair);
                  }
                });
      },
    );
  }
}

_getIPAddress() async {
    var url = 'http://www.mocky.io/v2/5b49e01631000072138bc08a';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      print(response);
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var data = JSON.decode(json);
        result = data['orders'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      print(exception);
      result = 'Failed getting IP address';
    }
    print(result);
    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
  
  }
