import 'package:covid/models/CountryBasedData.dart';
import 'package:covid/provider/checkNetwork.dart';
import 'package:covid/provider/secureStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<CountryBasedData> getCountryBasedData({@required String countryShortCode}) async{
  CountryBasedData ges;
  bool net = await checkNetwork();
  if(net == true){
    final res = await http.get("https://beacon-api.herokuapp.com/v2/locations?country_code=$countryShortCode");
    if(res.statusCode == 200){
      storage.write(key: "locationdata", value: res.body);
      ges = countryBasedDataFromJson(res.body);
    } else{
      String data = await storage.read(key: "locationdata");
      ges = countryBasedDataFromJson(data);
    }
  }

  return ges;
}