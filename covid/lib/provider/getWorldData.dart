import 'package:covid/models/Worldtotal.dart';
import 'package:covid/provider/checkNetwork.dart';
import 'package:covid/provider/secureStorage.dart';
import 'package:http/http.dart' as http;

Future<Worldtotal> getWorldData() async{
  Worldtotal ges;
  bool net = await checkNetwork();
  if(net == true){
    final res = await http.get("https://beacon-api.herokuapp.com/v2/latest");
    if(res.statusCode == 200){
      await storage.write(key: "worldtotalData", value: res.body);
      ges = worldtotalFromJson(res.body);
    }
  }else{
    String data = await storage.read(key: "worldtotalData");
    ges = worldtotalFromJson(data);
  }

  return ges;
}