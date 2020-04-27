import 'package:covid/models/LocationBasedData.dart';
import 'package:covid/provider/checkNetwork.dart';
import 'package:covid/provider/secureStorage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<LocationBasedData> getLocationBasedData() async{
  LocationBasedData ges;
  bool net = await checkNetwork();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(net == true){
    final res = await http.get("https://beacon-api.herokuapp.com/v2/locations");
    if(res.statusCode == 200){
     await prefs.setString("locationBasedData", res.body);
      ges = locationBasedDataFromJson(res.body);
    }
  }else{
    String res;
    res = prefs.getString("locationBasedData");
    ges = locationBasedDataFromJson(res);
  }

  return ges;
}
