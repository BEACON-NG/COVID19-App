
import 'package:covid/models/Data.dart';

class Centerr {
    List<Datas> datas;
    String status;

    Centerr({this.datas, this.status});

    factory Centerr.fromJson(Map<String, dynamic> json) {
        return Centerr(
            datas: json['data'] != null ? (json['data'] as List).map((i) => Datas.fromJson(i)).toList() : null,
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['status'] = this.status;
        if (this.datas != null) {
            data['data'] = this.datas.map((v) => v.toJson()).toList();
        }
        return data;
    }
}