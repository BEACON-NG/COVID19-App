
class Ids {
    String $oid;

    Ids({this.$oid});

    factory Ids.fromJson(Map<String, dynamic> json) {
        return Ids(
            $oid: json['\u0024oid'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['\u0024oid'] = this.$oid;
        return data;
    }
}