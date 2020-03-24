import 'package:covid/models/LocationBasedData.dart';
import 'package:covid/models/country.dart';
import 'package:covid/provider/getLocationBasedData.dart';
import 'package:covid/provider/getWorldData.dart';
import 'package:flutter/cupertino.dart';

Future<List<Country>> getCountries() async{
  LocationBasedData lbd = await getLocationBasedData();
  List<Country> countries = List();

  List<Country> checkCountries = List();
  lbd.locations.forEach((Location local)=> countries.add(Country(name: local.country, code: local.countryCode)));
  checkCountries.addAll(countries.where((a)=>checkCountries.every((b)=>a.name!=b.name)));
  return checkCountries;
}