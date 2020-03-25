import 'package:covid/models/country.dart';
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
  _HomeState({this.countries});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    onPressed: () {}),
              ),
              Positioned(
                top: 70,
                right: 15,
                child: IconButton(
                    icon: Icon(
                      Feather.more_vertical,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Feather.search),
                        Text('Search for Test centre and Doctors'),
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
    );
  }
}
