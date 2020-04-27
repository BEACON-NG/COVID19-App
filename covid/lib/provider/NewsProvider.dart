import 'package:covid/endpoints/index.dart';
import 'package:covid/provider/checkNetwork.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/*
  THE FIRST ARGUMENT COUNTRY HERE IS OPTIONAL AND 
  IF NOT DEFINED IT GETS NEWS FROM NIGERIA
*/
//"ng"
Future<String> getNewsModel({String country = "ng"}) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool net = await checkNetwork();
  String msg;
  if(net == true){
    if(prefs.getInt("count") == null){
      print("is null i mean count");
      final res = await http.get((country == "ng")?EndPoint.localurl:EndPoint.inturl);
      print(res.statusCode);
      if(res.statusCode == 200){
        prefs.setString("news", res.body);
        msg = prefs.getString("news");
        print(msg);
        final intlres = await http.get(EndPoint.inturl);
        if(intlres.statusCode == 200){
          prefs.setString("intlres", intlres.body);
        }
        final localres = await http.get(EndPoint.localurl);
        if(localres.statusCode == 200){
          prefs.setString("localres", localres.body);
        }
      }
      prefs.setInt("count", 1);
    }else{
      if(prefs.getInt("count") != 0){
        var i = prefs.getInt("count") - 1;
        prefs.setInt("count", i);
        if(country == "ng"){
          msg = prefs.getString("localres");
          print(msg);
        }else{
          msg = prefs.getString("intlres");
          print(msg);
        }
      }else{
        prefs.remove("count");
        if(country == "ng"){
          msg = prefs.getString("localres");
          print(msg);
        }else{
          msg = prefs.getString("intlres");
          print(msg);
        }
      }
    }
  }else{
    if(country == "ng"){
      msg = prefs.getString("localres");
      print(msg);
    }else{
      msg = prefs.getString("intlres");
      print(msg);
    }
  }
  return msg;
}