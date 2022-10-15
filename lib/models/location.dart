/// **Location's model**
///
/// [id] The id of the episode.
///
/// [name] The name of the episode.
///
/// [type] The type of the location.
///
/// [dimension] The dimension in which the location is located.
///
/// [residents] List of characters' ids who have been last seen in the location.
///
/// [url] Link to the location's own endpoint.
class Location {
  int id;
  String name;
  String type;
  String dimension;
  List<int> residents;
  String url;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      dimension: json["dimension"],
      residents: json["residents"]
          .map<int>((character) => int.parse(character.split("/").last))
          .toList(),
      url: json["url"],
    );
  }
}
