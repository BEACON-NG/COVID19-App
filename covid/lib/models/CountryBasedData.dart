
import 'dart:convert';

CountryBasedData countryBasedDataFromJson(String str) => CountryBasedData.fromJson(json.decode(str));

String countryBasedDataToJson(CountryBasedData data) => json.encode(data.toJson());

class CountryBasedData {
  List<Location> locations;

  CountryBasedData({
    this.locations,
  });

  factory CountryBasedData.fromJson(Map<String, dynamic> json) => CountryBasedData(
    locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
  };
}

class Location {
  Coordinates coordinates;
  String country;
  String countryCode;
  int id;
  String lastUpdated;
  Latest latest;
  String province;

  Location({
    this.coordinates,
    this.country,
    this.countryCode,
    this.id,
    this.lastUpdated,
    this.latest,
    this.province,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    coordinates: Coordinates.fromJson(json["coordinates"]),
    country: json["country"],
    countryCode: json["country_code"],
    id: json["id"],
    lastUpdated: json["last_updated"],
    latest: Latest.fromJson(json["latest"]),
    province: json["province"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates.toJson(),
    "country": country,
    "country_code": countryCode,
    "id": id,
    "last_updated": lastUpdated,
    "latest": latest.toJson(),
    "province": province,
  };
}

class Coordinates {
  String latitude;
  String longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
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
