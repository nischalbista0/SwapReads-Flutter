// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeHiveModelAdapter extends TypeAdapter<HomeHiveModel> {
  @override
  final int typeId = 1;

  @override
  HomeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeHiveModel(
      bookId: fields[0] as String?,
      title: fields[1] as String,
      author: fields[2] as String,
      description: fields[3] as String,
      genre: fields[4] as String,
      language: fields[5] as String,
      bookCover: fields[6] as String?,
      date: fields[7] as String?,
      user: (fields[8] as Map?)?.cast<String, dynamic>(),
      formattedCreatedAt: fields[9] as String?,
      isBookmarked: fields[10] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HomeHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.genre)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.bookCover)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.user)
      ..writeByte(9)
      ..write(obj.formattedCreatedAt)
      ..writeByte(10)
      ..write(obj.isBookmarked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
