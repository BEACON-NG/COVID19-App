import 'package:flutter/material.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
    Map<String,bool> region = {
    "local":true,
    "international":false,
	};

  GestureDetector newsCard() {
    return GestureDetector(
          child: Container(
            width:300,
            decoration:boxDecoration(),
            margin: EdgeInsets.only(bottom: 10),
            padding:EdgeInsets.all(15),
            child: Row(
              children:<Widget>[
                Expanded(
                    flex: 8,
                    child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        newTitle("this is a new lattest story"),
                        SizedBox(height:5),
                        Text(
                          "1hr ago",
                          style:TextStyle(
                            color:Colors.black,
                            fontSize:11
                          )
                        )
                      ]
                    ),
                  ),
              ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  child:Image.asset("assets/images/coro.png")                // decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/coro.png"),fit: BoxFit.cover)),
                  ),
                ),
            )
            ]
          ),
        ),
      );
  }
  Container headLineText(String text){
    return Container(
          padding:EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child:Text(
            text,
            style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            )
          )
        );
  }
  Container newTitle(String title){
        return Container(
              alignment:Alignment.topLeft,
              child:Text(
                  title,
                  style:TextStyle(
                    color:Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  )
                )
            );
  }
  BoxDecoration boxDecoration({Color color = Colors.white}){
    return BoxDecoration(
                color: color,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.1,
                    blurRadius:4,
                    color:Colors.grey,
                    offset:Offset(2,3)
                  )
                ],
                border: Border.all(
                          width:0.2,
                          color: Color.fromRGBO(128, 128, 12, 1)
                        ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
              );
  }
  GestureDetector button(bool state,String text){
    Color themeColor = Color.fromRGBO(36, 37, 134, 1);
    Color color = state ? themeColor : Colors.white;
    return GestureDetector(
          onTap: (){
            Map<String,bool> new_region = region;
            new_region[text] = true;
            new_region[ text == "international" ? "local":"international"] = false;
            setState((){
              region = new_region;
            });
          },
          child: Container(
              decoration:boxDecoration(color:color),
              width: 120,
              height: 30,
              padding:EdgeInsets.fromLTRB(20, 6, 20, 6),
              child:Center(
                child:Text(
                  text,
                  style:TextStyle(
                    color:state ? Colors.white : themeColor 
                    )
                  ),
                )
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
        child:ListView(
          children:<Widget>[
            Column(
              children:<Widget>[
                Container(
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  button(region["local"],"local"),
                  button(region["international"],"international"),
                ]
              )
            ),
            headLineText("Lattest news"),
            Container(
              decoration: boxDecoration(),
              width:MediaQuery.of(context).size.width/10 * 8,
              height:230,
              margin: EdgeInsets.symmetric(vertical: 2),
              padding:EdgeInsets.all(5),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:<Widget>[
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/coro.png"),fit: BoxFit.fill)),
                    ),
                  ),
                  newTitle("crona don full every whee o,corona corona")
                ]
              )
            ),
            headLineText("Hot news")
            ,
            Container(
              child:Column(
                children:<Widget>[
                  newsCard(),
                  newsCard(),
                  newsCard(),
                  newsCard(),
                ]
              )
            )
              ]
            )
          ]
          )
        )  
      );
  }
}