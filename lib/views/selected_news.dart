import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
 
void main() => runApp(SelectedNews());
 
class SelectedNews extends StatefulWidget {
  final dynamic data;
  SelectedNews({this.data});
 
  @override
  _SelectedNewsState createState() => _SelectedNewsState();
}

class _SelectedNewsState extends State<SelectedNews> {
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;
  Color color = Color.fromRGBO(36, 37, 130, 1);
  dynamic data;
  // Flex social(IconData icon){
  //   return Flex(
  //     direction: Axis.horizontal,
  //     children: <Widget>[
  //           Icon(
  //             icon,
  //             size:32,
  //             color:color
  //           ),
  //           SizedBox(width:3),
  //           Text(
  //             "20",
  //             style:TextStyle(
  //               fontSize: 14,
  //               fontWeight:FontWeight.w500,
  //               color:color
  //             )
  //           )
  //     ],
  //   );
  // }

  // Expanded left(){
  //   return Expanded(
  //     child:Container(
  //       child:Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[
  //           social(FontAwesome5Solid.heart),
  //           social(Icons.comment),
  //         ])
  //         )
  //   );
  // }
  // Container rightIcons(){
  //   return Container(
  //     child:Flex(
  //       direction: Axis.horizontal,
  //       children: <Widget>[
  //         Icon(Icons.share,color:color,size:32),
  //         SizedBox(width:8),
  //         Icon(Icons.save,color:color,size:32),
  //       ],
  //     )
  //   );
  // }

  // Expanded right(){
  //   return Expanded(
  //         child: Container(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: <Widget>[
  //               rightIcons()
  //             ]),
  //     ),
  //   );
  // }

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
    data = widget.data; 
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
                      color: Colors.white,
                      fontSize: 14
                    )),
                background: Image.network(data["urlToImage"],fit: BoxFit.fill),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    // Container(
                    //   padding:EdgeInsets.all(10),
                    //   width:MediaQuery.of(context).size.width,
                    //   child: Row(
                    //     children: <Widget>[
                    //       left(),
                    //       right(),
                    //     ],
                    //   ),
                    // ),

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