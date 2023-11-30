// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DbAdapter extends TypeAdapter<Db> {
  @override
  final int typeId = 0;

  @override
  Db read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Db(
      imagepath: fields[0] as String,
      name: fields[1] as String,
      number: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Db obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imagepath)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
