import 'package:covid/models/LocationBasedData.dart';
import 'package:covid/provider/checkNetwork.dart';
import 'package:covid/provider/secureStorage.dart';
import 'package:http/http.dart' as http;

Future<LocationBasedData> getLocationBasedData() async{
  LocationBasedData ges;
  bool net = await checkNetwork();
  if(net == true){
    final res = await http.get("https://beacon-api.herokuapp.com/v2/locations");
    if(res.statusCode == 200){
     await storage.write(key: "locationBasedData", value: res.body);
      ges = locationBasedDataFromJson(res.body);
    }else{
      String data = await storage.read(key: "locationBasedData");
      ges = locationBasedDataFromJson(data);
    }
  }

  return ges;
}