import 'package:hive_flutter/hive_flutter.dart';

part 'spoken_language.g.dart'; // Required for Hive code generation.

@HiveType(typeId: 1) // Assign a unique typeId.
class SpokenLanguage {
  @HiveField(0)
  String? englishName;

  @HiveField(1)
  String? iso6391;

  @HiveField(2)
  String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'] as String?,
      iso6391: json['iso_639_1'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'english_name': englishName,
        'iso_639_1': iso6391,
        'name': name,
      };
}
