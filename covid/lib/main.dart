import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:covid/models/country.dart';
import 'package:covid/provider/getCountries.dart';
import 'package:covid/provider/secureStorage.dart';
import 'package:covid/views/home.dart';
import 'package:covid/views/select_country.dart';
import 'package:covid/views/statistics.dart';
import 'package:covid/views/news.dart';
import 'package:flutter/material.dart';
import 'package:covid/views/contact.dart';
import 'package:covid/views/volunteer.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:cron/cron.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//void main() => runApp(MyApp());          fe9d39d1-d20a-4437-b3f5-ac142af0d280    this is onesignal app id
List<Country> countries;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var cron = Cron();
  cron.schedule(Schedule(hours: 20), () async {
    storage.delete(key: "locationdata");
    storage.delete(key: "locationBasedData");
    storage.delete(key: "country");
    storage.delete(key: "worldtotalData");
  });

  runApp(MyApp());
  countries = await getCountries();
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.key,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SwitchScreen(),
    );
  }
}

class SwitchScreen extends StatefulWidget {
  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  String isFirstLaunch;

//  Future<void> _checkState() async {
//    final storage = new FlutterSecureStorage();
//    storage.read(key: "first_launch").then((String v)=>(print(v)));
//    if (isFirstLaunch == null) {
//      setState(() {});
//    }
//  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _checkState();
    initnotify();
    var initialAndroidSettings = new AndroidInitializationSettings('logo');
    var intitialIosSettings = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initialAndroidSettings, intitialIosSettings);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }
  Future onSelectNotification(String payload) async{
    if(payload == "news"){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyHomePage(pageno:1)));

    }else if(payload == "statistics"){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Statistics()));
    }
  }
  Future _showNotificationWithSound({@required String title,@required String message, @required String payload}) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'ng.com.eleos.covid', 'BEACON', 'Live health updates custom to you!',
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      '$title',
      '$message',
      platformChannelSpecifics,
      payload: '$payload',
    );
  }


  String titlw;
  Future<void> initnotify() async {

    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

//    OneSignal.shared.setRequiresUserPrivacyConsent(true);

    OneSignal.shared.init("fe9d39d1-d20a-4437-b3f5-ac142af0d280", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    });

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
        _showNotificationWithSound(title: notification.payload.title, message: notification.payload.body, payload: notification.payload.title);
      // will be called whenever a notification is received
    });

  }
  @override
  Widget build(BuildContext context) {
    return Statistics();
//    return MyHomePage(pageno:0);
//    return isFirstLaunch == null
//        ? SelectCountry()
//        : (isFirstLaunch == 'true' ? SelectCountry() : MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title, this.pageno}) : super(key: key);
  final int pageno;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(pageno:pageno);
}

class _MyHomePageState extends State<MyHomePage> {
  int pageno;
  _MyHomePageState({this.pageno});
  @override
  void initState() {
    super.initState();
  }


  final List<Widget> pages = [
//    Home(key:PageStorageKey("home")),
    Home(key: PageStorageKey("home"), countries: countries),
    News(key: PageStorageKey("news")),
    Contact(key: PageStorageKey("contact")),
    Volunteer(key: PageStorageKey("volunteer")),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

//  int _selectedIndex = pageno;
  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        fixedColor: Color.fromARGB(1, 36, 37, 130).withOpacity(1),
        unselectedItemColor: Color.fromARGB(1, 36, 37, 130).withOpacity(1),
//    iconSize: 25,
        elevation: 0,
        onTap: (int index) => setState(() => pageno = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Feather.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(FontAwesome.newspaper_o), title: Text('News')),
          BottomNavigationBarItem(
              icon: Icon(SimpleLineIcons.phone), title: Text('Hotlines')),
          BottomNavigationBarItem(
              icon: Icon(FontAwesome.handshake_o), title: Text('Volunteer')),
        ],
      );
  @override
  Widget build(BuildContext context) {
//    return Statistics();
    return Scaffold(
      bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(canvasColor: Color.fromRGBO(255, 255, 255, 1)),
          child: _bottomNavigationBar(pageno)),
      body: PageStorage(
        child: pages[pageno],
        bucket: bucket,
      ),
    );
  }
}
