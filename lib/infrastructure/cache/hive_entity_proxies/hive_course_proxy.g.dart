// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_course_proxy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCourseAdapter extends TypeAdapter<HiveCourse> {
  @override
  final int typeId = 3;

  @override
  HiveCourse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCourse(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      trainer: fields[3] as HiveTrainer,
      category: fields[4] as String,
      image: fields[5] as String,
      tags: (fields[6] as List).cast<String>(),
      level: fields[7] as String,
      durationMinutes: fields[9] as String,
      durationWeeks: fields[8] as String,
      released: fields[10] as DateTime,
      lessons: (fields[11] as List).cast<HiveLesson>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveCourse obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.trainer)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.durationWeeks)
      ..writeByte(9)
      ..write(obj.durationMinutes)
      ..writeByte(10)
      ..write(obj.released)
      ..writeByte(11)
      ..write(obj.lessons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveLessonAdapter extends TypeAdapter<HiveLesson> {
  @override
  final int typeId = 2;

  @override
  HiveLesson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLesson(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      video: fields[3] as String,
      order: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLesson obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.video)
      ..writeByte(4)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLessonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
