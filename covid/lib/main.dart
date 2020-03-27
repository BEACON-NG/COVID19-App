import 'dart:async';
import 'package:covid/provider/secureStorage.dart';
import 'package:covid/views/home.dart';
import 'package:covid/views/select_country.dart';
import 'package:covid/views/statistics.dart';
import 'package:covid/views/news.dart';
import 'package:flutter/material.dart';
import 'package:covid/views/contact.dart';
import 'package:covid/views/volunteer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:cron/cron.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(MyApp());          fe9d39d1-d20a-4437-b3f5-ac142af0d280    this is onesignal app id

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var cron = Cron();
  cron.schedule(Schedule(hours: 20), () async {
    storage.delete(key: "locationdata");
    storage.delete(key: "locationBasedData");
    storage.delete(key: "country");
    storage.delete(key: "worldtotalData");
  });
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beacon App',
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
  bool isFirstLaunch;

  Future<void> _checkState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstLaunch = prefs.getBool('first_launch') ?? true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkState();
  }

  @override
  Widget build(BuildContext context) {
    _checkState();
    return (isFirstLaunch == null)
        ? IsLoading()
        : (isFirstLaunch ? SelectCountry() : MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initnotify();
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
      setState(() {
        titlw = notification.payload.title;
      });
      // will be called whenever a notification is received
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      if (titlw == "news") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
        setState(() {
          _selectedIndex = 1;
        });
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Statistics(),
            ));
      }
    });
  }

  final List<Widget> pages = [
//    Home(key:PageStorageKey("home")),
    Home(key: PageStorageKey("home")),
    News(key: PageStorageKey("news")),
    Contact(key: PageStorageKey("contact")),
    Volunteer(key: PageStorageKey("volunteer")),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;
  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        fixedColor: Color.fromARGB(1, 36, 37, 130).withOpacity(1),
        unselectedItemColor: Color.fromARGB(1, 36, 37, 130).withOpacity(1),
//    iconSize: 25,
        elevation: 0,
        onTap: (int index) => setState(() => _selectedIndex = index),
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
          child: _bottomNavigationBar(_selectedIndex)),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}

class IsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Color(0xff002657),
          strokeWidth: 1.3,
        ),
      ),
    );
  }
}
