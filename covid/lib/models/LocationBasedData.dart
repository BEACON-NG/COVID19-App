import 'dart:convert';

LocationBasedData locationBasedDataFromJson(String str) => LocationBasedData.fromJson(json.decode(str));

String locationBasedDataToJson(LocationBasedData data) => json.encode(data.toJson());

class LocationBasedData {
  Latest latest;
  List<Location> locations;

  LocationBasedData({
    this.latest,
    this.locations,
  });

  factory LocationBasedData.fromJson(Map<String, dynamic> json) => LocationBasedData(
    latest: Latest.fromJson(json["latest"]),
    locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "latest": latest.toJson(),
    "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
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

class Location {
  Coordinates coordinates;
  String country;
  String countryCode;
  int id;
  String lastUpdated;
  Latest latest;
  String province;
  Latest yesterday;

  Location({
    this.coordinates,
    this.country,
    this.countryCode,
    this.id,
    this.lastUpdated,
    this.latest,
    this.province,
    this.yesterday,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    coordinates: Coordinates.fromJson(json["coordinates"]),
    country: json["country"],
    countryCode: json["country_code"],
    id: json["id"],
    lastUpdated: json["last_updated"],
    latest: Latest.fromJson(json["latest"]),
    province: json["province"],
    yesterday: Latest.fromJson(json["yesterday"]),
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates.toJson(),
    "country": country,
    "country_code": countryCode,
    "id": id,
    "last_updated": lastUpdated,
    "latest": latest.toJson(),
    "province": province,
    "yesterday": yesterday.toJson(),
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
