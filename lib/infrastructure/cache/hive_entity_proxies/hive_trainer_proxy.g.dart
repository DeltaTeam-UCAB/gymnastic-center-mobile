// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_trainer_proxy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTrainerAdapter extends TypeAdapter<HiveTrainer> {
  @override
  final int typeId = 4;

  @override
  HiveTrainer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTrainer(
      id: fields[0] as String,
      name: fields[1] as String,
      location: fields[2] as String,
      image: fields[4] as String,
      followers: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTrainer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.followers)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTrainerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
