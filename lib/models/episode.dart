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
/// [characters] List of characters' ids who have been seen in the episode.
///
/// [url] Link to the episode's own URL endpoint.
class Episode {
  int id;
  String name;
  String airDate;
  String episode;
  List<int> characters;
  String overview;
  String stillPath;
  String url;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.overview,
    required this.stillPath,
    required this.url,
  });

  /// Factory constructor for Episode (parse JSON to Episode).
  factory Episode.fromJson(Map<String, dynamic> json, json2) {
    return Episode(
      id: json["id"],
      name: json["name"],
      airDate: json["air_date"],
      episode: json["episode"],
      // get the id of the characters
      characters: json["characters"]
          .map<int>((character) => int.parse(character.split("/").last))
          .toList(),
      overview: json2["overview"],
      stillPath: 'https://image.tmdb.org/t/p/w500${json2["still_path"]}',
      url: json["url"],
    );
  }
}
