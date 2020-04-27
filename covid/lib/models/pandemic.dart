// To parse this JSON data, do
//
//     final pandemic = pandemicFromJson(jsonString);

import 'dart:convert';

Pandemic pandemicFromJson(String str) => Pandemic.fromJson(json.decode(str));

String pandemicToJson(Pandemic data) => json.encode(data.toJson());

class Pandemic {
  List<Datum> data;
  String status;

  Pandemic({
    this.data,
    this.status,
  });

  factory Pandemic.fromJson(Map<String, dynamic> json) => Pandemic(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  Id id;
  String description;
  String firstOccurenceDate;
  String firstReportedAt;
  Latest latest;
  List<Location> locations;
  String name;

  Datum({
    this.id,
    this.description,
    this.firstOccurenceDate,
    this.firstReportedAt,
    this.latest,
    this.locations,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: Id.fromJson(json["_id"]),
    description: json["description"],
    firstOccurenceDate: json["first_occurence_date"],
    firstReportedAt: json["first_reported_at"],
    latest: Latest.fromJson(json["latest"]),
    locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id.toJson(),
    "description": description,
    "first_occurence_date": firstOccurenceDate,
    "first_reported_at": firstReportedAt,
    "latest": latest.toJson(),
    "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
    "name": name,
  };
}

class Id {
  String oid;

  Id({
    this.oid,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    oid: json["\u0024oid"],
  );

  Map<String, dynamic> toJson() => {
    "\u0024oid": oid,
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
    confirmed: json["confirmed"] == null ? null : json["confirmed"],
    deaths: json["deaths"] == null ? null : json["deaths"],
    recovered: json["recovered"] == null ? null : json["recovered"],
  );

  Map<String, dynamic> toJson() => {
    "confirmed": confirmed == null ? null : confirmed,
    "deaths": deaths == null ? null : deaths,
    "recovered": recovered == null ? null : recovered,
  };
}

class Location {
  String countryCode;
  String countryName;
  Latest latest;

  Location({
    this.countryCode,
    this.countryName,
    this.latest,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    countryCode: json["country_code"],
    countryName: json["country_name"],
    latest: Latest.fromJson(json["latest"]),
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode,
    "country_name": countryName,
    "latest": latest.toJson(),
  };
}
