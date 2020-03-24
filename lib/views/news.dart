import 'dart:convert';
import 'package:covid/provider/NewsProvider.dart';
import 'package:covid/views/selected_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    lattestNews();
    super.initState();
  }

    Map<String,bool> region = {
    "local":true,
    "international":false,
	};

  List<dynamic> result;
  void lattestNews ({String country = 'ng'}) async {
    String see = await getNewsModel(country:country); 
    setState((){
      result = json.decode(see)["articles"];
    });
  }
  dynamic headline;
  GestureDetector newsCard(dynamic article) {
    return GestureDetector(
          /**
           * this is GestureDetetor widget is what 
           * will navigate to the news page once 
           * it's seleted and pass the article 
           * to the news
           */
          onTap:()=> Navigator.push(context,MaterialPageRoute(builder:(context) => SelectedNews(data: article))),
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
                        newTitle(article["title"]),
                        SizedBox(height:5),
                        Text(
                          article["publishedAt"],
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
                  child:article["urlToImage"] != null ? Image.network(article["urlToImage"]): SizedBox(width:2)                // decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/coro.png"),fit: BoxFit.cover)),
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
  /**
   * this is the map function that will
   * render the card and it will only 
   * render the card if it contains an 
   * image
   */
  List<Widget> listOfWidget() => result.map((news) => news["urlToImage"] != null ? newsCard(news) : SizedBox(width:1)).toList();
  /**
   * this is the function resposible for creating the 
   * buttons that will switch between loca and international 
   * news and send the request
   */
  GestureDetector button(bool state,String text){
    Color themeColor = Color.fromRGBO(36, 37, 134, 1);
    Color color = state ? themeColor : Colors.white;
    return GestureDetector(
          onTap: (){
            /**
             * here setting the region to the buttons that was clicked
             */
            Map<String,bool> newRegion = region;
            newRegion[text] = true;
            newRegion[ text == "international" ? "local":"international"] = false;
            setState((){
              region = newRegion;
              result = null;
            });
            /**
             * sending request based on the region that was selected
             */
            text == "international" ? lattestNews(country: "us"):lattestNews(country: "ng");
            /**
             * freeing up memory for better performance
             */
            newRegion.clear();
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
  void getHeadlines(){
    dynamic lattestHeadlines;
    for (var i = 0; i < result.length; i++) {
        /*
          
          this if condition is checking if the
          result contains an image, so if it does
          it will add it will make the first match
          the headline

         */
        if(result[i]["urlToImage"] != null){
          lattestHeadlines = result[i];
          result.removeAt(i);
          break;
        }
    }
    /**
     * assigning the matched lattestHeadlines to the 
     * headline so it can be used to renderd the headline 
     */
    headline = lattestHeadlines;
  }
  /*
    this news result methods returns will only be rendered if 
    the result variables recieves news from he server
   */
  GestureDetector newsResult(){
    /*
      
      this get headline methods will select any of the news that
      has an image and assign it to to a headline vairble which the
      headline function will later consumed as it header.

     */

    getHeadlines();

    return GestureDetector(
            child: Container(
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
                      /**
                       * this 2 buttons are responsible for swithing
                       * between local and international news 
                       */
                      for(var item in ["local","international"])button(region[item],item),
                    ]
                  )
                ),
                headLineText("Lattest news"),
                /**
                 * this Container is responsible for rendering the 
                 * headline image and text
                 */
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
                            child:Image.network(headline["urlToImage"])
                        ),
                      ),
                      newTitle(headline["title"])
                    ]
                  )
                ),
                headLineText("Hot news")
                ,
                /**
                 * this container is responsible for 
                 * rendering the list of news card
                 */
                Container(
                  child:Column(
                    children:listOfWidget()
                  )
                )
                  ]
                )
              ]
              )
          ),
    );
  }
  /*
    this function is a loading spinner 
    that would be rendered before the
    new data comes in
  */
  SpinKitFadingCircle loadingSpinner(){
      Color color = Color.fromRGBO(36, 37, 130, 1);
      return SpinKitFadingCircle(
        size: 100.0,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? color : color,
            ),
          );
        },
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
      /*
          conditionally rendering a loading spinner or the page with
          the result

          the function loadingSpinner() this is a spinner that 
          would get loadeded before the response from the server 
          comes

      */
      body:(result == null ?  loadingSpinner() : newsResult()));
  }
}