import 'package:flutter/material.dart';
 
void main() => runApp(SelectedNews());
 
class SelectedNews extends StatefulWidget {
  SelectedNews({Key key}) : super(key: key);
 
  @override
  _SelectedNewsState createState() => _SelectedNewsState();
}

class _SelectedNewsState extends State<SelectedNews> {
  bool _pinned = false;
  bool _snap = true;
  bool _floating = false;
  Color color = Color.fromRGBO(36, 37, 130, 1);

  Flex social(){
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Icon(
              Icons.headset,
              size:32,
              color:color
            ),
            SizedBox(width:3),
            Text(
              "20",
              style:TextStyle(
                fontSize: 14,
                fontWeight:FontWeight.w500,
                color:color
              )
            )
      ],
    );
  }

  Expanded left(){
    return Expanded(
      child:Container(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            social(),
            social(),
          ])
          )
    );
  }
  Container rightIcons(){
    return Container(
      child:Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Icon(Icons.share,color:color,size:32),
          SizedBox(width:8),
          Icon(Icons.save,color:color,size:32),
        ],
      )
    );
  }
  Expanded right(){
    return Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                rightIcons()
              ]),
      ),
    );
  }

  Container newsText(String text){
    return Container(
      margin:EdgeInsets.symmetric(vertical:10,horizontal:10),
      child:Text(
          text,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr)
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: CustomScrollView(
          slivers:<Widget>[
              SliverAppBar(
              backgroundColor: Colors.white,
              pinned: this._pinned,
              snap: this._snap,
              floating: this._floating,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title:  Text(
                    "Lattest news corona virus don catch 10 new people o",
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 14
                    )),
                background: Image.asset(
                  'assets/images/coro.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                  [

                    Container(
                      padding:EdgeInsets.all(10),
                      width:MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          left(),
                          right(),
                        ],
                      ),
                    ),
                    Column(
                      children:<Widget>[
                          newsText("so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo"),
                          newsText("so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo"),
                          newsText("so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo"),
                          newsText("so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo"),
                          newsText("so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo"),
                          newsText("so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo"),
                          newsText("so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo"),
                          newsText("so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo"),
                          newsText("so fa this is the lattest news about corna virus ,the virus just they spread every whee oo coroco leave us a lone oo"),
      ]
                    )
                  ]
                )
              )
          ]
        )
      ),
    );
  }
}