class Warehouse {
    int? id;
    String? name;

    Warehouse({this.id, this.name});

    factory Warehouse.fromJson(Map<String, dynamic> json) {
        return Warehouse(
            id: json['id'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        return data;
    }
}