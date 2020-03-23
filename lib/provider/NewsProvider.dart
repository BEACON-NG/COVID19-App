import 'package:covid/endpoints/index.dart';
import 'package:covid/models/NewsModel.dart';
import 'package:http/http.dart' as http;

/*
  THE FIRST ARGUMENT COUNTRY HERE IS OPTIONAL AND 
  IF NOT DEFINED IT GETS NEWS FROM NIGERIA
*/

Future<Map<String, List<NewsModel>>> getNewsModel({String country = "ng"}) async{
  final res = await http.get((EndPoint.url += ( country == "ng" ? EndPoint.NG:EndPoint.US ) ));
  print(res.body);
  if(res.statusCode == 200)return  newsFromJson(res.body);
}