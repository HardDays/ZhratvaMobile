import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

import '../../models/api/user.dart';

class Database {

  static Map<String, dynamic> _db = {};

  static File _file;

  static Future init() async {
    String path = (await getApplicationDocumentsDirectory()).path;

    _file = File('$path/test1.json');
    bool exists = await _file.exists();

    if (exists){
      String body = await _file.readAsString(); 
      _db = json.decode(body);     
    } else {
      await _file.create();
      await _file.writeAsString('{}');
    }
  }

  static User getCurrentUser() {
    if (_db.containsKey('current_user')) {
      return User.fromJson(json.decode(_db['current_user']));
    }
  }

  static void setCurrentUser(User value) {
    _db['current_user'] = json.encode(value.toJson());
    _file.writeAsStringSync(json.encode(_db));
  }

  static void deleteCurrentUser() {
    _db.remove('current_user');
    _file.writeAsStringSync(json.encode(_db));
  }

}