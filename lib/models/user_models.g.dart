// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelsAdapter extends TypeAdapter<UserModels> {
  @override
  final int typeId = 0;

  @override
  UserModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModels(
      email: fields[0] as String,
      name: fields[2] as String,
      password: fields[1] as String,
      phonenumber: fields[3] as String,
      status: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserModels obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.phonenumber)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
