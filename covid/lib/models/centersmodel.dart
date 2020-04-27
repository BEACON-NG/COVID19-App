// To parse this JSON data, do
//
//     final centers = centersFromJson(jsonString);

import 'dart:convert';

Centers centersFromJson(String str) => Centers.fromMap(json.decode(str));

String centersToJson(Centers data) => json.encode(data.toMap());

class Centers {
  List<Datum> data;
  String status;

  Centers({
    this.data,
    this.status,
  });

  factory Centers.fromMap(Map<String, dynamic> json) => Centers(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "status": status,
  };
}

class Datum {
  String email;
  Id id;
  String address;
  String name;
  List<String> otherNumbers;
  String phoneNumber;

  Datum({
    this.email,
    this.id,
    this.address,
    this.name,
    this.otherNumbers,
    this.phoneNumber,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    email: json["Email"] == null ? null : json["Email"],
    id: Id.fromMap(json["_id"]),
    address: json["address"],
    name: json["name"],
    otherNumbers: List<String>.from(json["other_numbers"].map((x) => x)),
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toMap() => {
    "Email": email == null ? null : email,
    "_id": id.toMap(),
    "address": address,
    "name": name,
    "other_numbers": List<dynamic>.from(otherNumbers.map((x) => x)),
    "phone_number": phoneNumber,
  };
}

class Id {
  String oid;

  Id({
    this.oid,
  });

  factory Id.fromMap(Map<String, dynamic> json) => Id(
    oid: json["\u0024oid"],
  );

  Map<String, dynamic> toMap() => {
    "\u0024oid": oid,
  };
}
