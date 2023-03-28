class ItemOrder {

  int? id;
  String? name;
  double? quantity;


  ItemOrder({
      this.id, 
      this.name, 
      this.quantity,});

  ItemOrder.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['quantity'] = quantity;
    return map;
  }

}