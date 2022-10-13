/// **Character's last known location or Character's origin location**
///
/// [name] The name of the location.
///
/// [url] Link to the location's own URL endpoint.
class CharacterLocation {
  String name;
  String url;

  CharacterLocation({
    required this.name,
    required this.url,
  });

  /// Factory constructor for CharacterLocation (parse JSON to CharacterLocation).
  factory CharacterLocation.fromJson(Map<String, dynamic> json) {
    return CharacterLocation(
      name: json["name"],
      url: json["url"],
    );
  }
}
