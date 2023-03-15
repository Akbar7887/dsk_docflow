import 'Position.dart';

class Personal {
  Personal({
    this.id,
    this.name,
    this.position,
    this.phone,
    this.datestart,
  });

  Personal.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    position =
        json['position'] != null ? Position.fromJson(json['position']) : null;
    phone = json['phone'];
    datestart = json['datestart'];
  }

  int? id;
  String? name;
  Position? position;
  String? phone;
  String? datestart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (position != null) {
      map['position'] = position!.toJson();
    }
    map['phone'] = phone;
    map['datestart'] = datestart;
    return map;
  }
}
