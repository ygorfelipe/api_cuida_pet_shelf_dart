// ignore_for_file: public_member_api_docs, sort_constructors_first
//* nessa classe de modelo, foi obrigatorio realizar muitas modificações, por causa do DataClassGenerate

import 'dart:convert';

class User {
  final int? id;
  final String email;
  final String password;
  final String? typeSignup;
  final String iosToken;
  final String androidToken;
  final String refreshToken;
  final String imgAvatar;
  final String socialId;
  final int? supplierId;
  final DateTime createdAt;
  final DateTime updatedAt;
  User({
    this.id,
    required this.email,
    required this.password,
    this.typeSignup,
    required this.iosToken,
    required this.androidToken,
    required this.refreshToken,
    required this.imgAvatar,
    required this.socialId,
    required this.createdAt,
    required this.updatedAt,
    this.supplierId,
  });

  User copyWith({
    int? id,
    String? email,
    String? password,
    String? typeSignup,
    String? iosToken,
    String? androidToken,
    String? refreshToken,
    String? imgAvatar,
    String? socialId,
    int? supplierId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      typeSignup: typeSignup ?? this.typeSignup,
      iosToken: iosToken ?? this.iosToken,
      androidToken: androidToken ?? this.androidToken,
      refreshToken: refreshToken ?? this.refreshToken,
      imgAvatar: imgAvatar ?? this.imgAvatar,
      socialId: socialId ?? this.socialId,
      supplierId: supplierId ?? this.supplierId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'typeSignup': typeSignup,
      'iosToken': iosToken,
      'androidToken': androidToken,
      'refreshToken': refreshToken,
      'imgAvatar': imgAvatar,
      'socialId': socialId,
      'supplierId': supplierId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  //! outra coisa importente, foi a criação do toDataBase e updateMap, pois isso não é algo que tem, e sim que precisamos criar

  Map<String, dynamic> toDataBase() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'type_signup': typeSignup,
      'ios_token': iosToken,
      'android_token': androidToken,
      'refresh_token': refreshToken,
      'img_avatar': imgAvatar,
      'social_id': socialId,
      'supplier_id': supplierId,
      'created_at':
          createdAt, //! aqui não deve ser millisecondsSinceEpoch, apenas o nome da var
      'updated_at': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      //* aqui no id foi realizado uma verificação do mesmo o parser do dataclass não resolveu o problema
      id: (map['id'] == null) ? null : int.parse(map['id'].toString()),
      email: map['email'] as String,
      password: map['password'] as String,
      typeSignup:
          (map['type_signup']) != null ? map['type_signup'] as String : '',
      iosToken: (map['ios_token']) != null ? map['ios_token'] as String : '',
      androidToken:
          (map['android_token']) != null ? map['android_token'] as String : '',
      refreshToken:
          (map['refresh_token']) != null ? map['refresh_token'] as String : '',
      imgAvatar: (map['img_avatar']) != null ? map['img_avatar'] as String : '',
      socialId: (map['social_id']) != null ? map['social_id'] as String : '',
      supplierId: (map['supplier_id'] == null)
          ? null
          : int.parse(map['social_id'].toString()),
      createdAt: (map['created_at'] == null)
          ? DateTime.now()
          : DateTime.parse(map['created_at']),
      updatedAt: (map['updated_at'] == null)
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User updateMap(Map<String, dynamic> data) {
    return User(
      id: id,
      email: data['email'] ?? email,
      password: data['password'] ?? password,
      typeSignup: data['type_signup'] ?? typeSignup,
      iosToken: data['ios_token'] ?? iosToken,
      androidToken: data['android_token'] ?? androidToken,
      refreshToken: data['refresh_token'] ?? refreshToken,
      imgAvatar: data['img_avatar'] ?? imgAvatar,
      socialId: data['social_id'] ?? socialId,
      createdAt: data['created_at'] ?? createdAt,
      updatedAt: data['updated_at'] ?? updatedAt,
      supplierId: data['supplier_id'] ?? supplierId,
    );
  }

  @override
  String toString() {
    return 'User{id=$id, email=$email, password=$password, typeSignup=$typeSignup, iosToken=$iosToken, androidToken=$androidToken, refreshToken=$refreshToken, imgAvatar=$imgAvatar, socialId=$socialId, createdAt=$createdAt, updatedAt=$updatedAt, supplierId=$supplierId}';
  }
}
