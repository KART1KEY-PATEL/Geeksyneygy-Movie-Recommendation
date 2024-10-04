// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStatusModelAdapter extends TypeAdapter<UserStatusModel> {
  @override
  final int typeId = 1;

  @override
  UserStatusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserStatusModel(
      isLoggedIn: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserStatusModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isLoggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
