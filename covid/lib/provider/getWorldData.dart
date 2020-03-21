import 'package:covid/models/Worldtotal.dart';
import 'package:http/http.dart' as http;

Future<Worldtotal> getWorldData() async{
  final res = await http.get("https://beacon-api.herokuapp.com/v2/latest");
  Worldtotal ges;
  if(res.statusCode == 200){
    ges = worldtotalFromJson(res.body);
  }
  return ges;
}