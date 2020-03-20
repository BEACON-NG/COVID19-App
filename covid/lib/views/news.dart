import 'package:flutter/material.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  
  Container newsItem(String title,String time,String img){
    return Container(
      child:Text("what popaing")
    );
  }

  Container button(String text){
    return Container(
            width: 120,
            height: 30,
            padding:EdgeInsets.fromLTRB(20, 6, 20, 6),
            color:Colors.red,
            child:Center(
              child:Text(
                text,
                style:TextStyle(
                  color:Colors.black
                )),
              )
            );
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text("News", style: TextStyle(
          color: Color.fromRGBO(36, 37, 130, 1),fontSize: 30,
        ),),
      ),
      backgroundColor: Colors.white,
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:Column(
          children:<Widget>[
            Container(
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  button("local"),
                  button("interational"),
                ]
              )
            ),
            Container(
              child:Text("Lattest news")
            ),
            Container(
              color:Color.fromRGBO(36, 37, 134, 1),
              width:MediaQuery.of(context).size.width/10 * 8,
              height:230,
              margin: EdgeInsets.symmetric(vertical: 10),
              child:Column(
                children:<Widget>[
                  Container(
                    child:Text("headline image")
                  ),Container(
                    child:Text("headline title")
                  )
                ]
              )
            ),
            Container(
              child:Text("Hot news")
            ),
            Container(
              child:Column(
                children:<Widget>[
                  newsItem("title","time","img"),
                  newsItem("title","time","img"),
                ]
              )
            )
          ]
          )
        )  
      );
  }
}