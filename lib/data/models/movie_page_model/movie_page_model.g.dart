// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_page_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoviePageModelAdapter extends TypeAdapter<MoviePageModel> {
  @override
  final int typeId = 0;

  @override
MoviePageModel read(BinaryReader reader) {
  final numOfFields = reader.readByte();
  final fields = <int, dynamic>{
    for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
  };

  // Handling the type mismatch for 'originalTitle' field (convert if needed)
  var originalTitle = fields[1];
  if (originalTitle is int) {
    originalTitle = originalTitle.toString(); // Convert int to String
  }

  return MoviePageModel(
    id: fields[0] as int?,  // Ensure 'id' is cast correctly
    originalTitle: originalTitle as String?,  // Ensure 'originalTitle' is a String?
    posterPath: fields[2] as String?,
  );
}


  @override
  void write(BinaryWriter writer, MoviePageModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.originalTitle)
      ..writeByte(2)
      ..write(obj.posterPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviePageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
