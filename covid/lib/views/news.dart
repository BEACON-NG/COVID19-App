import 'dart:convert';
import 'package:covid/main.dart';
import 'package:covid/provider/NewsProvider.dart';
import 'package:covid/views/callRefresh.dart';
import 'package:covid/views/selected_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';
class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {


//  bool _isnew;
  @override
  void initState() {
//   if (_isnew == false){
    lattestNews();
//   }
    super.initState();
  }
    bool islocal = true;
    Map<String,bool> region = {
    "Local":true,
    "International":false,
	};

  static const Color color = Color(0xff002657);
  List<dynamic> result;
  bool local = true;
  bool gotdata = true;
  void lattestNews ({String country = 'ng'}) async {
    String see = await getNewsModel(country:country);
    print("we wan see am");
    print(see);
    (country == "ng")?
    (json.decode(see)["data"]!= null)?
    setState((){
      result = json.decode(see)["data"];
      local = true;
    }):setState((){
      gotdata = false;
      local = true;
    })
        :
    (json.decode(see)["articles"]!= null)?
    setState((){
      result = json.decode(see)["articles"];
      local = false;
    }):setState((){
      gotdata = false;
      local = false;
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
          onTap:()=> Navigator.push(context,MaterialPageRoute(builder:(context) => SelectedNews(data: article, local:local))),
          child: Container(
            width:300,
            decoration:boxDecoration(),
            margin: EdgeInsets.only(bottom: 20),
            padding:EdgeInsets.all(15),
            child: Row(
              children:<Widget>[
                Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        newTitle(article["title"]),
                        SizedBox(height:5),
                        Text(
//                            (local)?"${new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(article["posted_at"]).toString()}":
//                            "${new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(article["publishedAt"]).toString()}",
                            (local)?
                            "${DateFormat.yMMMMEEEEd().format(DateTime.parse(article["posted_at"]))}":
                            "${DateFormat.yMMMMEEEEd().format(DateTime.parse(article["publishedAt"]))}",
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
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child:(local)?
                    article["img"] != null ?
                    CachedNetworkImage(
                      imageUrl: article["img"],
                      placeholder: (context, url) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                      errorWidget: (context, url, error) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                    ):Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),)
                        :article["urlToImage"] != null ? CachedNetworkImage(
                      imageUrl: article["urlToImage"],
                      placeholder: (context, url) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                      errorWidget: (context, url, error) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                    ):Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
//                    article["urlToImage"] != null ? Image.network(article["urlToImage"], fit: BoxFit.fitWidth): SizedBox(width:2)                // decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/coro.png"),fit: BoxFit.cover)),
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
                    fontSize: 13,
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
  List<Widget> listOfWidget() => (local)?
  result.map((news) => news["img"] != null ? newsCard(news) : SizedBox(width:1)).toList()
      :result.map((news) => news["urlToImage"] != null ? newsCard(news) : SizedBox(width:1)).toList();
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
//            Map<String,bool> newRegion = region;

            Map<String,bool> newRegion;
            if(text=="Local"){
              newRegion = {
                "Local":true,
                "International":false,
              };
              setState(() {
                region = newRegion;
                result = null;
              });
            }else{
              newRegion = {
                "Local": false,
                "International":true,
              };
              setState(() {
                region = newRegion;
                result = null;
              });
            }
//            newRegion[text] = true;
//            newRegion[ text == "International" ? "Local":"International"] = false;
//            setState((){
//              region = newRegion;
//              result = null;
//            });
            /**
             * sending request based on the region that was selected
             */
            text == "International" ? lattestNews(country: "us"):lattestNews(country: "ng");
            /**
             * freeing up memory for better performance
             */
//            newRegion.clear();
          },
          child: Container(
              decoration:boxDecoration(color:color),
              width: 150,
              height: 30,
              padding:EdgeInsets.fromLTRB(20, 6, 20, 6),
              child:Center(
                child:Text(
                  text,

                  style:TextStyle(
                    color:state ? Colors.white : themeColor,
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
        if(local){
          if(result[i]["img"] != null){
            lattestHeadlines = result[i];
            result.removeAt(i);
            break;
          }
        }else{
          if(result[i]["urlToImage"] != null){
            lattestHeadlines = result[i];
            result.removeAt(i);
            break;
          }
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
                      for(var item in ["Local","International"])button(region[item],item),
                    ]
                  )
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: headLineText("Latest news")),
                /**
                 * this Container is responsible for rendering the 
                 * headline image and text
                 */
                GestureDetector(
                  onTap:()=> Navigator.push(context,MaterialPageRoute(builder:(context) => SelectedNews(data: headline, local:local))),
                  child: Container(
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
                            decoration:BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                              child:(local)?
                              headline["img"] != null ?
                              CachedNetworkImage(
                                imageUrl: headline["img"],
                                placeholder: (context, url) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                                errorWidget: (context, url, error) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                              ):
                              Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),)
//                            Image.network(headline["img"],
//                            fit: BoxFit.fill)
                                  :
                              headline["urlToImage"] != null ?
                              CachedNetworkImage(
                                imageUrl: headline["urlToImage"],
                                placeholder: (context, url) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                                errorWidget: (context, url, error) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                              ):
                              Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),)
//                            Image.network(headline["urlToImage"], fit: BoxFit.fill)
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 5, bottom: 10, top: 10, right: 5),
                            child: newTitle(headline["title"]))
                      ]
                    )
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: headLineText("Hot news"))
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
//    var doRefresh = CallRefresh.of(context).shouldRefresh;
//    if(doRefresh==true){
//      setState(() {result= null;});
//      lattestNews();
//    }
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
      body:(result == null) ?
//      loadingSpinner()
      (gotdata)?
      Container(
        child: CardListSkeleton(
          style: SkeletonStyle(
            theme: SkeletonTheme.Light,
            isShowAvatar: false,
            isCircleAvatar: false,
            barCount: 4,
          ),
        ),
      ):Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.3,),
            Text("Error while Fetching News",style: TextStyle(color:Color.fromRGBO(36, 37, 130, 1), fontSize:20)),
            Container(
              margin: EdgeInsets.only(top:20),
              width: MediaQuery.of(context).size.width*0.4,
              child: RaisedButton(
                onPressed: (){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyHomePage(pageno: 1)));
//                  newRegion = {
//                    "Local": false,
//                    "International":true,
//                  };
//                  setState(() {
//                    region = newRegion;
//                    result = null;
//                  });
                },
                color: Color.fromRGBO(36, 37, 130, 1),child: Text("Retry",style: TextStyle(color: Colors.white,)),),
            ),
            Container(
              margin: EdgeInsets.only(top:5),
              width: MediaQuery.of(context).size.width*0.4,
              child: RaisedButton(
                onPressed: (){
//                  Navigator.of(context)
//                      .push(MaterialPageRoute(builder: (context) => MyHomePage(pageno: 1)));
                  setState(() {
                    region = {
                      "Local": false,
                      "International":true,
                    };
                    gotdata = true;
                    result = null;
                    lattestNews(country: "us");
                  });
                },
                color: Color.fromRGBO(36, 37, 130, 1),child: Text("International News",style: TextStyle(color: Colors.white,)),),
            )
          ],
        ),
      )
          : newsResult());
  }
}