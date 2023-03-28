import '../catalogs/Warehouse.dart';
import '../catalogs/Personal.dart';
import 'ItemOrder.dart';

class OrderGood {

  int? id;
  String? datecreate;
  Personal? worker;
  bool? edit;
  String? recieveDate;
  Warehouse? warehouse;
  List<ItemOrder>? itemOrders;


  OrderGood({
      this.id, 
      this.datecreate, 
      this.worker, 
      this.edit, 
      this.recieveDate, 
      this.warehouse, 
      this.itemOrders});

  OrderGood.fromJson(dynamic json) {
    id = json['id'];
    datecreate = json['datecreate'];
    worker = json['worker'] != null ? Personal.fromJson(json['worker']) : null;
    edit = json['edit'];
    recieveDate = json['recieveDate'];
    warehouse = json['warehouse'] != null ? Warehouse.fromJson(json['warehouse']) : null;
    if (json['itemOrders'] != null) {
      itemOrders = [];
      json['itemOrders'].forEach((v) {
        itemOrders!.add(ItemOrder.fromJson(v));
      });
    }
  }



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
    if (itemOrders != null) {
      map['itemOrders'] = itemOrders!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}