// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

// ignore_for_file: file_names

// l'code hedha 5dhito men https://app.quicktype.io/ elli houa men format JSON walle en DART

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
  });

  ObjectId id;
  // ObjectId generated while the creation of any document by MongoDb
  String fullname;
  String email;
  String password;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        fullname: json["FullName"],
        email: json["Email"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "FullName": fullname,
        "Email": email,
        "Password": password,
      };
}
