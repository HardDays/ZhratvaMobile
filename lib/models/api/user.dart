import 'package:intl/intl.dart';

import 'menu_category.dart';
import 'working_hour.dart';

import '../../helpers/api/main_api.dart';
import '../../helpers/util/geolocation_cache.dart';

class User {
  String id;

  String firstName;
  String lastName;
  String phone;
  String email;
  String password;
  String token;
  String coverId;

  User({this.id, this.firstName, this.lastName, this.phone, this.email, this.password, this.token, this.coverId}){
 
  }

  String getCover(){
    return MainAPI.getImageUrl(coverId);
  }

  Map <String, dynamic> toJson(){
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'password': password,
      'cover_id': coverId,
      'token': token
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      coverId: json['cover_id'],
      token: json['token'],
    );
  }
}