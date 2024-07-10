// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_trainer_details_proxy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTrainerDetailsAdapter extends TypeAdapter<HiveTrainerDetails> {
  @override
  final int typeId = 5;

  @override
  HiveTrainerDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTrainerDetails(
      trainer: fields[0] as HiveTrainer,
      isFollowing: fields[1] as bool,
      courseCount: fields[2] as int,
      blogCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTrainerDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.trainer)
      ..writeByte(1)
      ..write(obj.isFollowing)
      ..writeByte(2)
      ..write(obj.courseCount)
      ..writeByte(3)
      ..write(obj.blogCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTrainerDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
