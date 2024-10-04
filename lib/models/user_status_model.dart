import 'package:hive/hive.dart';

part 'user_status_model.g.dart'; // Required for Hive TypeAdapter generation

@HiveType(typeId: 1) // Define a unique type ID
class UserStatusModel {
  @HiveField(0)
  bool isLoggedIn;

  UserStatusModel({required this.isLoggedIn});

  // Optional: Method to update login status
  UserStatusModel copyWith({bool? isLoggedIn}) {
    return UserStatusModel(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}