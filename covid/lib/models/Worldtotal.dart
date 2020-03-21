import 'dart:convert';

Worldtotal worldtotalFromJson(String str) => Worldtotal.fromJson(json.decode(str));

String worldtotalToJson(Worldtotal data) => json.encode(data.toJson());

class Worldtotal {
  Latest latest;

  Worldtotal({
    this.latest,
  });

  factory Worldtotal.fromJson(Map<String, dynamic> json) => Worldtotal(
    latest: Latest.fromJson(json["latest"]),
  );

  Map<String, dynamic> toJson() => {
    "latest": latest.toJson(),
  };
}

class Latest {
  int confirmed;
  int deaths;
  int recovered;

  Latest({
    this.confirmed,
    this.deaths,
    this.recovered,
  });

  factory Latest.fromJson(Map<String, dynamic> json) => Latest(
    confirmed: json["confirmed"],
    deaths: json["deaths"],
    recovered: json["recovered"],
  );

  Map<String, dynamic> toJson() => {
    "confirmed": confirmed,
    "deaths": deaths,
    "recovered": recovered,
  };
}
