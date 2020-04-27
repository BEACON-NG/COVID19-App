

import 'package:covid/models/Id.dart';

class Datas {
    Ids id;
    String address;
    String email;
    String name;
    List<String> other_numbers;
    String phone_number;

    Datas({this.id, this.address, this.email, this.name, this.other_numbers, this.phone_number});

    factory Datas.fromJson(Map<String, dynamic> json) {
        return Datas(
            id: json['_id'] != null ? Ids.fromJson(json['_id']) : null,
            address: json['address'], 
            email: json['email'], 
            name: json['name'], 
            other_numbers: json['other_numbers'] != null ? new List<String>.from(json['other_numbers']) : null, 
            phone_number: json['phone_number'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['email'] = this.email;
        data['name'] = this.name;
        data['phone_number'] = this.phone_number;
        if (this.id != null) {
            data['_id'] = this.id.toJson();
        }
        if (this.other_numbers != null) {
            data['other_numbers'] = this.other_numbers;
        }
        return data;
    }
}