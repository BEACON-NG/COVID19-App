import 'package:covid/models/Covids.dart';
import 'package:http/http.dart' as http;

Future<Map<String, List<Covids>>> getData() async{
  final res = await http.get("https://pomber.github.io/covid19/timeseries.json");
  if(res.statusCode == 200){
    final ges = covidsFromJson(res.body);
      return ges;
  }
}