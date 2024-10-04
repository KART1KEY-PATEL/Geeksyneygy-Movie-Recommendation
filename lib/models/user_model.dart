import 'dart:convert';
import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Required for Hive TypeAdapter generation

@HiveType(typeId: 0) // Hive Type ID
class UserModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phoneNumber;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  @HiveField(4)
  String profession;


 
  UserModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.profession,
    
  });

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? password,
    String? profession,
   
  }) {
    return UserModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      profession: profession ?? this.profession,
      
    );
  }

  // JSON Serialization methods
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        password: json['password'],
        profession: json['profession'],
       
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
        'profession': profession,
        
      };

  

  // Optional: Method to create a UserModel from a JSON string
  static UserModel fromJsonString(String jsonString) {
    return UserModel.fromJson(jsonDecode(jsonString));
  }

  // Optional: Method to convert UserModel to a JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
