import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
//void main() => runApp(SelectedNews());
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';


class Donation extends StatefulWidget {
  final String donate;
  Donation({Key key, @required this.donate}) : super(key: key);

  @override
  _DonationState createState() => _DonationState(donate: donate);
}

class _DonationState extends State<Donation> {
  final String donate;
  _DonationState({@required this.donate});
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
  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebviewScaffold(
        url: donate,
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
              Navigator.pop(context);
              }),
          title: const Text('Donate'),
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