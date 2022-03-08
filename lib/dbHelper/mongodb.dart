// ignore_for_file: prefer_typing_uninitialized_variables, unused_import, avoid_print

// -- THIS IS A DART FILE FOR MONGOdb CONNECTION --
// ADD Mongo_Dart package fel pubspec.yaml bech tconnecti el dart bel mongo

import 'dart:developer';
import 'dart:ffi';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:ui_authetification/MongoDbModel.dart';
import 'package:ui_authetification/dbHelper/constant.dart';

class MongoDatabase {
  static var db, userCollection;
  // create static connect function to connect with database
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

//Creating Function for button click to call insert Data
  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      // Coneverting our model class data into JSON
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong While inserting data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
