import '../catalogs/Warehouse.dart';
import '../catalogs/Personal.dart';
import 'ItemOreders.dart';

class OrderGoods {
  OrderGoods({
      this.id, 
      this.datecreate, 
      this.worker, 
      this.edit, 
      this.recieveDate, 
      this.warehouse, 
      this.itemOreders});

  OrderGoods.fromJson(dynamic json) {
    id = json['id'];
    datecreate = json['datecreate'];
    worker = json['worker'] != null ? Personal.fromJson(json['worker']) : null;
    edit = json['edit'];
    recieveDate = json['recieveDate'];
    warehouse = json['warehouse'] != null ? Warehouse.fromJson(json['warehouse']) : null;
    if (json['itemOreders'] != null) {
      itemOreders = [];
      json['itemOreders'].forEach((v) {
        itemOreders!.add(ItemOreders.fromJson(v));
      });
    }
  }
  int? id;
  String? datecreate;
  Personal? worker;
  bool? edit;
  String? recieveDate;
  Warehouse? warehouse;
  List<ItemOreders>? itemOreders;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['datecreate'] = datecreate;
    if (worker != null) {
      map['worker'] = worker!.toJson();
    }
    map['edit'] = edit;
    map['recieveDate'] = recieveDate;
    if (warehouse != null) {
      map['warehouse'] = warehouse!.toJson();
    }
    if (itemOreders != null) {
      map['itemOreders'] = itemOreders!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}