import 'dart:convert';

class Order {
  final int? id;
  final String name;
  final String address;

  final DateTime createdAt;
  final DateTime updatedAt;
  Order({
    this.id,
    required this.name,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  Order copyWith({
    int? id,
    String? name,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: (map['id'] == null) ? null : int.parse(map['id'].toString()),
      name: map['name'] as String,
      address: map['address'] as String,
      createdAt: (map['created_at'] == null)
          ? DateTime.now()
          : DateTime.parse(map['created_at']),
      updatedAt: (map['updated_at'] == null)
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  Order updateMap(Map<String, dynamic> data) {
    return Order(
      id: id,
      name: data['name'] ?? name,
      address: data['address'] ?? address,
      createdAt: data['created_at'] ?? createdAt,
      updatedAt: data['updated_at'] ?? updatedAt,
    );
  }

  @override
  String toString() {
    return 'Order{id=$id, name=$name, address=$address, createdAt=$createdAt, updatedAt=$updatedAt}';
  }
}
