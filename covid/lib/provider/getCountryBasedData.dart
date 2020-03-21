import 'package:covid/models/CountryBasedData.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<CountryBasedData> getCountryBasedData({@required String countryShortCode}) async{
  final res = await http.get("https://beacon-api.herokuapp.com/v2/locations?country_code=$countryShortCode");
  CountryBasedData ges;
  if(res.statusCode == 200){
    ges = countryBasedDataFromJson(res.body);
  }
  return ges;
}