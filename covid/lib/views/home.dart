import 'package:covid/models/country.dart';
import 'package:covid/views/news.dart';
import 'package:covid/views/statistics.dart';
import 'package:covid/views/volunteer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Home extends StatefulWidget {
  final List<Country> countries;
  Home({Key key, this.countries}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(countries: countries);
}

class _HomeState extends State<Home> {
  List<Country> countries;
  static const Color color = Color(0xff002657);
  static const TextStyle style =
      TextStyle(fontSize: 16.0, color: Color(0xff002657));
  _HomeState({this.countries});
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/beacon.png',
              height: 50.0,
              width: 130,
              alignment: Alignment.center,
            ),
          ),
          Container(
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => News())),
              leading: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/news.png'),
                ),
              ),
              title: Text('News', style: style),
            ),
          ),
          Container(
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: ListTile(
              leading: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/stethoscope.png'),
                ),
              ),
              title: Text('Test Centres', style: style),
            ),
          ),
          Container(
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Statistics())),
              leading: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/graph.png'),
                ),
              ),
              title: Text('Statistics', style: style),
            ),
          ),
          Container(
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Volunteer())),
              leading: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    FontAwesome.handshake_o,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              title: Text('Volunteer', style: style),
            ),
          ),
          Container(
            color: color.withOpacity(0.1),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
            child: ListTile(
              leading: Container(
                height: 35,
                width: 45,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    FontAwesome.info,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              title: Text('About Us', style: style),
            ),
          ),
        ],
      )),
      appBar: PreferredSize(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF242582),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16.0))),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/beacon.png',
                  width: 120,
                  height: 50,
                ),
              ),
              Positioned(
                top: 72,
                left: 15,
                child: IconButton(
                    icon: Icon(
                      Feather.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print('nav button pressed');
                      _scaffoldKey.currentState.openDrawer();
                    }),
              ),
              Positioned(
                top: 120,
                left: 15,
                right: 15,
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 40.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Feather.search,
                            size: 16, color: Colors.black.withOpacity(0.3)),
                        Text(
                          'Search for Test centre and Doctors',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.3)),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            size: 18, color: Colors.black.withOpacity(0.3)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size(double.infinity, 140.0),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    margin: EdgeInsets.only(right: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF002657),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/news.png'),
                        ),
                        Text(
                          'News',
                          style: style,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF2699fb),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/stethoscope.png',
                            height: 50,
                          ),
                        ),
                        Text(
                          'Test Centres',
                          style: style,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFCE13BB),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/graph.png',
                            height: 50,
                          ),
                        ),
                        Text(
                          'Statistics',
                          style: style,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    margin: EdgeInsets.only(left: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 100,
                          margin: EdgeInsets.only(left: 5.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFF0090),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/news.png'),
                        ),
                        Text(
                          'Volunteer',
                          style: style,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Card(
              elevation: 10.0,
              color: Colors.white,
              shadowColor: Colors.grey.withOpacity(0.4),
              borderOnForeground: true,
              child: Container(
                height: 160,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                          height: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Let update you on preventive measures against COVID-19',
                                style: TextStyle(
                                    fontSize: 18.0, color: Color(0xff002657)),
                              ),
                              Container(
                                height: 40.0,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0Xffedd7ea),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text('View here', style: style),
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: double.infinity,
                        child: Image.asset('assets/images/illustrator.png',
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            headingRow(
                leading: "Precautions",
                trailing: "See All",
                onTap: () {
                  print("Hey you!");
                }),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/wash_hand.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/news_virus.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                              image: AssetImage('assets/images/stay_home.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ],
              ),
            ),
            headingRow(
                leading: "Test centres",
                trailing: "View All",
                onTap: () {
                  print("Hey you!");
                }),
            SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    height: 100,
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Lagos State University Teaching Hospital (LUTH)',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '8:30am - 5:30pm',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xFF242582),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/test_centre.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Card(
                  elevation: 5.0,
                  color: Colors.white,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Edo State Teaching Hospital (ETH)',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '8:30am - 6:30pm',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xFF242582),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/test_centre.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Card(
                  elevation: 5.0,
                  color: Colors.white,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Lagos State University Teaching Hospital (LUTH)',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '8:30am - 5:30pm',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xFF242582),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/test_centre.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container headingRow({String leading, String trailing, Function onTap}) {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            leading,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    trailing,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  height: 24.0,
                  width: 24.0,
                  decoration: BoxDecoration(
                    color: Color(0XFF9394C1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
