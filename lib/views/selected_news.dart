import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
 
void main() => runApp(SelectedNews());
 
class SelectedNews extends StatefulWidget {
  SelectedNews({Key key}) : super(key: key);
 
  @override
  _SelectedNewsState createState() => _SelectedNewsState();
}

class _SelectedNewsState extends State<SelectedNews> {
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;
  Color color = Color.fromRGBO(36, 37, 130, 1);

  Map<String,String> data = {
        "content":"A teenager aged just 18 has died in the UK one day after testing positive for COVID-19, according to officials. I/flutter (23306): The unidentified teen died in University Hospital in  and is believed to be the youngest of 281 fatalities linked to the pandemic in the U… [+609 chars], description: A teenager aged just 18 has died in the UK — one day after testing positive for COVID-19, according to officials.The unidentified teen died in University",
        "title": "Teen dies one day after testing positive for coronavirus - The Nation Newspaper",
        "urlToImage": "https://thenationonlineng.net/wp-content]/uploads/2020/03/COVID-19-4.jpg"
  };

  Flex social(IconData icon){
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
            Icon(
              icon,
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
            social(FontAwesome5Solid.heart),
            social(Icons.comment),
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
                    data["title"],
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 14
                    )),
                background: Image.network(data["urlToImage"],fit: BoxFit.fill),
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
                          newsText(data["content"]),
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