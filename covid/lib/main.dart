import 'dart:async';

import 'package:covid/models/country.dart';
import 'package:covid/provider/getCountries.dart';
import 'package:covid/views/home.dart';
import 'package:covid/views/statistics.dart';
import 'package:covid/views/news.dart';
import 'package:flutter/material.dart';
import 'package:covid/views/contact.dart';
import 'package:covid/views/volunteer.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:workmanager/workmanager.dart';

//void main() => runApp(MyApp());          fe9d39d1-d20a-4437-b3f5-ac142af0d280    this is onesignal app id
List<Country> countries;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager.initialize(callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  await Workmanager.registerOneOffTask(
    "1",
    simpleTaskKey,
    existingWorkPolicy: ExistingWorkPolicy.replace,
//    initialDelay: Duration(seconds: 5),
  );
  runApp(MyApp());
  countries = await getCountries();
}
void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    Timer.periodic(Duration(days: 1), (Timer t) {
      
    }); //simpleTask will be emitted here.
    return Future.value(true);
  });
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
  Future<void> initnotify() async{
    OneSignal.shared.init("fe9d39d1-d20a-4437-b3f5-ac142af0d280",iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl : true
    });

    OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
      // will be called whenever a notification is received
    });
  }

  final List<Widget> pages = [
//    Home(key:PageStorageKey("home")),
    Home(key:PageStorageKey("home"), countries:countries),
    News(key:PageStorageKey("news")),
    Contact(key:PageStorageKey("contact")),
    Volunteer(key:PageStorageKey("volunteer")),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;
  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
    fixedColor:  Color.fromARGB(1, 36, 37, 130).withOpacity(1),
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
          data: Theme.of(context).copyWith(
            canvasColor: Color.fromRGBO(255,255,255, 1)
          ),
          child: _bottomNavigationBar(_selectedIndex)),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}

