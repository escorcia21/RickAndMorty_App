import 'package:rickandmorty/models/character_location.dart';

/// Character's model.
///
/// [id] The id of the character.
///
/// [name] The name of the character.
///
/// [status] The status of the character ('Alive', 'Dead' or 'unknown').
///
/// [species] The species of the character.
///
/// [type] The type or subspecies of the character.
///
/// [gender] The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
///
/// [origin] Character's origin location.
///
/// [location] Character's last known location.
///
/// [image] Link to the character's image.
///
/// [episodes] List of episodes in which this character appeared.
///
/// [url] Link to the character's own URL endpoint.
class Character {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  CharacterLocation origin;
  CharacterLocation location;
  String image;
  List<String> episodes;
  String url;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episodes,
    required this.url,
  });

  /// Factory constructor for Character (parse JSON to Character).
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      type: json["type"] != "" ? json["type"] : "",
      gender: json["gender"],
      origin: CharacterLocation.fromJson(json["origin"]),
      location: CharacterLocation.fromJson(json["location"]),
      image: json["image"],
      episodes: List<String>.from(json["episode"].map((x) => x)),
      url: json["url"],
    );
  }
}
