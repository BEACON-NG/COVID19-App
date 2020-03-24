import 'package:covid/models/country.dart';
import 'package:covid/provider/getCountries.dart';
import 'package:covid/views/home.dart';
import 'package:covid/views/statistics.dart';
import 'package:covid/views/news.dart';
import 'package:flutter/material.dart';
import 'package:covid/views/contact.dart';
import 'package:covid/views/volunteer.dart';
import 'package:flutter_icons/flutter_icons.dart';
//void main() => runApp(MyApp());
List<Country> countries;
void main() async{
  countries = await getCountries();
  runApp(MyApp());
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
    return Statistics();
//    return Scaffold(
//      bottomNavigationBar: Theme(
//          data: Theme.of(context).copyWith(
//            canvasColor: Color.fromRGBO(255,255,255, 1)
//          ),
//          child: _bottomNavigationBar(_selectedIndex)),
//      body: PageStorage(
//        child: pages[_selectedIndex],
//        bucket: bucket,
//      ),
//    );
  }
}
