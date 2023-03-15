class ItemOreders {
  ItemOreders({
      this.id, 
      this.name, 
      this.quantity,});

  ItemOreders.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
  }
  int id;
  String name;
  double quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['quantity'] = quantity;
    return map;
  }

}