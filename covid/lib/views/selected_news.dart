import 'package:flutter/material.dart';
 
void main() => runApp(SelectedNews());
 
class SelectedNews extends StatefulWidget {
  SelectedNews({Key key}) : super(key: key);
 
  @override
  _SelectedNewsState createState() => _SelectedNewsState();
}

class _SelectedNewsState extends State<SelectedNews> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: CustomScrollView(
          slivers:<Widget>[
              SliverAppBar(
              pinned: this._pinned,
              snap: this._snap,
              floating: this._floating,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("news title"),
                background: Image.asset(
                  'assets/images/coro.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Center(child: Text("Hello")),
            )
          ]
        )
      ),
    );
  }
}