import 'dart:convert';

import 'package:covid/endpoints/index.dart';
import 'package:http/http.dart' as http;

/*
  THE FIRST ARGUMENT COUNTRY HERE IS OPTIONAL AND 
  IF NOT DEFINED IT GETS NEWS FROM NIGERIA
*/

Future<String> getNewsModel({String country = "ng"}) async{
  final res = await http.get((EndPoint.url += ( country == "ng" ? EndPoint.NG:EndPoint.US ) ));
  print(res.statusCode);
  if(res.statusCode == 200)return  res.body;
}