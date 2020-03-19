
import 'dart:convert';

Map<String, List<Covids>> covidsFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<Covids>>(k, List<Covids>.from(v.map((x) => Covids.fromJson(x)))));

String covidsToJson(Map<String, List<Covids>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));

class Covids {
  String date;
  int confirmed;
  int deaths;
  int recovered;

  Covids({
    this.date,
    this.confirmed,
    this.deaths,
    this.recovered,
  });

  factory Covids.fromJson(Map<String, dynamic> json) => Covids(
    date: json["date"],
    confirmed: json["confirmed"],
    deaths: json["deaths"],
    recovered: json["recovered"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "confirmed": confirmed,
    "deaths": deaths,
    "recovered": recovered,
  };
}
