import 'package:flutter/material.dart';
 
void main() => runApp(SelectedNews());
 
class SelectedNews extends StatefulWidget {
  @override
  _SelectedNewsState createState() => _SelectedNewsState();
}

class _SelectedNewsState extends State<SelectedNews> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}