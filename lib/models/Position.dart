class Position {
    int? id;
    String? name;

    Position({this.id, this.name});

    factory Position.fromJson(Map<String, dynamic> json) {
        return Position(
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