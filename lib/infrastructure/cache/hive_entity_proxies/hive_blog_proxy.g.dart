// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_blog_proxy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveBlogAdapter extends TypeAdapter<HiveBlog> {
  @override
  final int typeId = 0;

  @override
  HiveBlog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveBlog(
      id: fields[0] as String,
      title: fields[1] as String,
      body: fields[2] as String,
      released: fields[3] as DateTime,
      images: (fields[4] as List).cast<String>(),
      trainer: fields[5] as HiveTrainer,
      category: fields[7] as String,
      tags: (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveBlog obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.released)
      ..writeByte(4)
      ..write(obj.images)
      ..writeByte(5)
      ..write(obj.trainer)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveBlogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
