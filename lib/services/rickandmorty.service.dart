import 'package:rickandmorty/models/character.dart';
import 'package:rickandmorty/models/episode.dart';
import 'package:rickandmorty/models/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Service to fetch data from the Rick and Morty API
///
/// https://rickandmortyapi.com/
class RickAndMortyService {
  /// Base URL for the Rick and Morty API
  static const String _baseUrl = 'https://rickandmortyapi.com/api/';

  /// Get characters
  ///
  /// [name] is optional and will filter the characters by name
  ///
  /// [page] is optional, it will return the characters for the given page
  ///
  /// [getCharacters] will return a list of [Character] objects
  ///
  /// https://rickandmortyapi.com/documentation/#filter-characters
  static Future<List<Character>> getCharacters(
      {String name = '', int page = 1}) async {
    final response =
        await fetcher('/character', name: name, page: page.toString());

    List<Character> characters =
        response['results'].map((e) => Character.fromJson(e)).toList();
    return characters;
  }

  /// Get episodes
  ///
  /// [name] is optional, it will filter the episodes by name
  ///
  /// [page] is optional, it will return the episodes from the given page
  ///
  /// [getEpisodes] will return a list of [Episode] objects or an empty list
  /// if no episodes are found
  ///
  /// https://rickandmortyapi.com/documentation/#filter-episodes
  static Future<List<Episode>> getEpisodes(
      {String name = '', int page = 1}) async {
    final response =
        await fetcher('/episode', name: name, page: page.toString());

    List<Episode> episodes =
        response['results'].map((e) => Episode.fromJson(e)).toList();
    return episodes;
  }

  /// Get locations
  ///
  /// [name] is optional and will filter the results by the name
  ///
  /// [page] is optional and will return the locations from the given page
  ///
  /// [getLocations] will return a list of [Location] objects or an empty list
  /// if no locations are found
  ///
  /// https://rickandmortyapi.com/documentation/#filter-locations
  static Future<List<Location>> getLocations(
      {String name = '', int page = 1}) async {
    final response =
        await fetcher('/location', name: name, page: page.toString());

    List<Location> locations =
        response['results'].map((e) => Location.fromJson(e)).toList();
    return locations;
  }

  /// Rick and Morty API fetcher function
  ///
  /// Fetch data from an specific endpoint
  ///
  /// [endpoint] is the endpoint to fetch data from
  ///
  /// [name] is optional and will filter the results
  /// by the name of the character
  ///
  /// [page] is optional and will filter the results
  /// by the page number
  ///
  /// Exmaple:
  ///
  /// ```dart
  /// // [response] will be a Map with the first page of characters that have the name 'Rick'
  /// final response = await fetcher('/character', 'Rick', '1');
  ///
  /// // [response] will be a Map with all the locations of the first page
  /// final response = await fetcher('/location');
  /// ```
  static Future fetcher(String endpoint,
      {String name = '', String page = '1'}) async {
    final url = Uri.https(_baseUrl, endpoint, {'page': page, 'name': name});
    final res = await http.get(url);

    if (res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      final results = jsonDecode(body);
      return results;
    } else {
      throw Exception("Something happen with status: ${res.statusCode}");
    }
  }
}
