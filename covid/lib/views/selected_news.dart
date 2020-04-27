import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid/main.dart';
import 'package:covid/views/callRefresh.dart';
import 'package:covid/views/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
//void main() => runApp(SelectedNews());
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class SelectedNews extends StatefulWidget {
  final dynamic data;
  final bool local;
  SelectedNews({this.data, this.local});

  @override
  _SelectedNewsState createState() =>
      _SelectedNewsState(data: data, local: local);
}

class _SelectedNewsState extends State<SelectedNews> {
  final dynamic data;
  final bool local;
  _SelectedNewsState({this.data, this.local});
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;
  Color color = Color.fromRGBO(36, 37, 130, 1);

  // Instance of WebView plugin
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  final _history = [];

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.close();
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

//  _generateText(int start, int end) {
//    return Text(
//      data["content"].toString().substring(start, end),
//      textAlign: TextAlign.justify,
//    );
//  }

  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();

  @override
  Widget build(BuildContext context) {
//    List<Text> news = [];
//    int max = 2000;
//    for (var i = 0; i < data["content"].toString().length; i = i + max) {
//      print(data["content"].toString());
//      if (i == 0) {
//        news.add(_generateText(0, i));
//        print("Heydfddd ${news.length}");
//      } else {
//        if (max + i <= data["content"].toString().length) {
//          news.add(_generateText(i + 1, max + i));
//          print("not yet ${news.length}");
//        } else {
//          news.add(_generateText(i + 1, data["content"].toString().length));
//          print("reached");
//        }
//      }
//    }
//    data = widget.data;

    return (local)
        ? MaterialApp(
            title: 'Material App',
            home: Scaffold(
                appBar: PreferredSize(
                  child: Stack(
                    children:<Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                            color: color,
//                            borderRadius: BorderRadius.only(
//                                bottomLeft: Radius.circular(20),
//                                bottomRight: Radius.circular(20))
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: data["img"],
                          placeholder: (context, url) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                          errorWidget: (context, url, error) => Container(child: Image.asset("assets/images/beacon.png"),color: color,padding: EdgeInsets.all(20),),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                      color: Colors.transparent,
//                              image: DecorationImage(
//                                  image: NetworkImage(data["img"]),
//                                  fit: BoxFit.fill),
//                              borderRadius: BorderRadius.only(
//                                  bottomLeft: Radius.circular(20),
//                                  bottomRight: Radius.circular(20)
//                              )
                          ),
                          child: Column(
                            children: <Widget>[
                              AppBar(
                                elevation: 0,
                                backgroundColor: Colors.transparent,

                                leading: Container(
                                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                                  child: IconButton(
                                      icon: Icon(Icons.arrow_back,
                                          size: 20,
                                          color: Color.fromRGBO(36, 37, 130, 1)),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(builder: (context) => MyHomePage(pageno: 1)));
                                      }),
                                  decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                                ),
                              ),
                              SizedBox(
                                height: 182,
                              ),
                              Container(
//                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white70,
//                                    borderRadius: BorderRadius.only(
//                                        bottomLeft: Radius.circular(20),
//                                        bottomRight: Radius.circular(20)
//                                    )
                              ),
                                padding: EdgeInsets.symmetric(horizontal:15),
                                child: Text(data["title"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
//                        color: Color.fromRGBO(36, 37, 130, 1),

                                        fontSize: 15)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]

                  ),
                  preferredSize: Size(MediaQuery.of(context).size.width, 300),
                ),
                body:Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(left: 15, top: 15, right: 15, bottom:15),
                  child: ListView(
                    children: <Widget>[
                          Text(data["content"], textAlign: TextAlign.justify,style: TextStyle( fontSize: 18, ),),
                    ],
                  ),
                ),
//                body: Center(
//                  child: Padding(
//                    padding: EdgeInsets.all(8),
//                    child: Container(
//                      child: ListView.builder(
//                        itemBuilder: (BuildContext context, int i) {
//                          return news[i];
//                        },
//                        itemCount: news.length,
//                      ),
//                    ),
//                  ),
//                )
            ),
          )
        :
    MaterialApp(
            home: WebviewScaffold(
              url: data["url"],
              javascriptChannels: jsChannels,
              mediaPlaybackRequiresUserGesture: false,
            appBar: AppBar(
              actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.autorenew, color: Colors.white,),
                onPressed: () {
                  flutterWebViewPlugin.reload();
                },
              ),

              ],
              centerTitle: true,
              backgroundColor: Color.fromRGBO(36, 37, 130, 1),leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    size: 20,
                    color: Colors.white),
                onPressed: () {
                  setState(() {
                    _history.clear();
                  });
                  flutterWebViewPlugin.close();

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyHomePage(pageno: 1)));
//                                  CallRefresh.of(context).toggleRefresh();
//                                  Navigator.pop(context);
//              Navigator.push(context,MaterialPageRoute(builder:(context) => News()));
                }),
              title: const Text('International News'),
            ),
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                child: CardListSkeleton(
                  style: SkeletonStyle(
                    theme: SkeletonTheme.Light,
                    isShowAvatar: false,
                    isCircleAvatar: false,
                    barCount: 4,
                  ),
                ),
              ),
            ),
          );
  }
}
