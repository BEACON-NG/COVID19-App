import 'package:covid/models/LocationBasedData.dart';
import 'package:http/http.dart' as http;

Future<LocationBasedData> getLocationBasedData() async{
  final res = await http.get("https://beacon-api.herokuapp.com/v2/locations");
  LocationBasedData ges;
  if(res.statusCode == 200){
    
    ges = locationBasedDataFromJson(res.body);
  }
  return ges;
}