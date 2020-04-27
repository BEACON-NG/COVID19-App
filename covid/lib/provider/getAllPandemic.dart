import 'package:covid/models/pandemic.dart';
import 'package:covid/provider/checkNetwork.dart';
import 'package:covid/provider/secureStorage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Pandemic> getAllPandemic() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Pandemic ges;
  bool net = await checkNetwork();
  if(net == true){
    final res = await http.get("https://beacon-api.herokuapp.com/v2/all-epidemics");
    if(res.statusCode == 200){
      await storage.write(key: "pandemic", value: res.body);
      await prefs.setString("pandemic", res.body);
      ges = pandemicFromJson(res.body);
    }
  }else{
    String res;
    String data = await storage.read(key: "worldtotalData");
    (data == null)? res = prefs.getString("pandemic"): res = data;
    ges = pandemicFromJson(res);
  }

  return ges;
}