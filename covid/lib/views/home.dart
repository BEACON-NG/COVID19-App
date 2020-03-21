import 'package:covid/models/country.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  List<Country> countries;
  Home({Key key, @required this.countries}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(countries: countries);
}

class _HomeState extends State<Home> {
  List<Country> countries;
  _HomeState({@required this.countries});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,);
  }
}