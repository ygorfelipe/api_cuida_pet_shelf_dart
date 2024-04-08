import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CoursesModel {
  final int? id;
  final String title;
  final String description;
  final String target;
  final int totalHours;
  final bool enabled;
  final String link;
  final String image;
  final DateTime createdAt;
  final DateTime updateAt;
  CoursesModel({
    this.id,
    required this.title,
    required this.description,
    required this.target,
    required this.totalHours,
    required this.enabled,
    required this.link,
    required this.image,
    required this.createdAt,
    required this.updateAt,
  });

  CoursesModel copyWith({
    int? id,
    String? title,
    String? description,
    String? target,
    int? totalHours,
    bool? enabled,
    String? link,
    String? image,
    DateTime? createdAt,
    DateTime? updateAt,
  }) {
    return CoursesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      target: target ?? this.target,
      totalHours: totalHours ?? this.totalHours,
      enabled: enabled ?? this.enabled,
      link: link ?? this.link,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'target': target,
      'totalHours': totalHours,
      'enabled': enabled,
      'link': link,
      'image': image,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updateAt': updateAt.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toDataBase() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'target': target,
      'total_hours': totalHours,
      'enabled': enabled,
      'link': link,
      'image': image,
      'created_at': createdAt,
      'update_at': updateAt
    };
  }

  factory CoursesModel.fromMap(Map<String, dynamic> map) {
    return CoursesModel(
      id: (map['id'] == null ? null : int.parse(map['id'].toString())),
      title: map['title'] as String,
      description: map['description'] as String,
      target: map['target'] as String,
      totalHours: int.parse(map['totalHours'].toString()),
      enabled: bool.parse(map['enabled'].toString()),
      link: map['link'] as String,
      image: map['image'] as String,
      createdAt: (map['created_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['created_at'])),
      updateAt: (map['update_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['update_at'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory CoursesModel.fromJson(String source) =>
      CoursesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CoursesModel updateMap(Map<String, dynamic> data) {
    return CoursesModel(
      id: id,
      title: data['title'] ?? title,
      description: data['description'] ?? description,
      target: data['target'] ?? target,
      totalHours: data['totalHours'] ?? totalHours,
      enabled: data['enabled'] ?? enabled,
      link: data['link'] ?? link,
      image: data['image'] ?? image,
      createdAt: data['created_at'] ?? createdAt,
      updateAt: data['update_at'] ?? updateAt,
    );
  }
}
