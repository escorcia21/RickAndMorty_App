/// **Episode's model**
///
/// [id] The id of the episode.
///
/// [name] The name of the episode.
///
/// [airDate] The air date of the episode.
///
/// [episode] The code of the episode.
///
/// [characters] List of characters who have been seen in the episode.
///
/// [url] Link to the episode's own URL endpoint.
class Episode {
  int id;
  String name;
  String airDate;
  String episode;
  List<String> characters;
  String url;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
  });

  /// Factory constructor for Episode (parse JSON to Episode).
  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json["id"],
      name: json["name"],
      airDate: json["air_date"],
      episode: json["episode"],
      characters: List<String>.from(json["characters"].map((x) => x)),
      url: json["url"],
    );
  }
}
