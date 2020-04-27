import 'package:covid/models/centersmodel.dart';
import 'package:covid/provider/checkNetwork.dart';
import 'package:covid/provider/secureStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


Future<Centers> getCenters() async{
    Centers ges;
    bool net = await checkNetwork();
    String resss;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(net == true){

//        if(prefs.getInt("counts") == null){
            final res = await http.get("https://beacon-api.herokuapp.com/v2/centres");
            if(res.statusCode == 200){
    //            await storage.write(key: "center", value: res.body).then((_)=>print(storage.read(key: "center")));
                await prefs.setString("center", res.body);
                resss = res.body;
            }
//            prefs.setInt("counts", 5);
//        }else{
//
//            if(prefs.getInt("counts") != 0) {
//                var i = prefs.getInt("counts") - 1;
//                prefs.setInt("counts", i);
//                resss = await prefs.getString("center");
//            }else{
//                prefs.remove("center");
//                resss = await prefs.getString("center");
//            }
//        }
    }else{
        resss = await prefs.getString("center");
    }
    ges = centersFromJson(resss);
    return ges;
}
