import 'package:flutter/material.dart';
import 'package:rickandmorty/models/character.dart';
import 'package:rickandmorty/screens/characters/widgets/character.card.dart';
import 'package:rickandmorty/services/rickandmorty.service.dart';

/// **CustomSearchDelegate** widget that extends [SearchDelegate]
///
/// it provides a search bar to search for characters and
/// a body to display the results
///
/// It uses a [FutureBuilder] to fetch the data
/// and a [ListView.builder] to display a list of characters
class CustomSearchDelegate extends SearchDelegate {
  List<Character> _characters = [];

  /// Fetch the characters from the API and store the result in  _characters
  Future<List<Character>> _getCharacters() async {
    // If the query is empty, return an empty list
    if (query.isEmpty) {
      return [];
    }

    // If the query is not empty, fetch the characters from the API
    List<Character> characters = await RickAndMortyService.getCharacters(
      name: query,
    ).catchError((error) {
      _characters = [];
    });

    _characters = characters;

    return characters;
  }

  // manages the actions of the search bar
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        // Clear the query when tap the clear button
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // manages the leading icon (back button) returns to the previous screen
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, Future.value(false));
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  /*
    Builds the body of the search delegate
    It uses a [FutureBuilder] to build the widget based on the state of the future

    If the results are empty, it displays an Not Found image or a list of characters

  */
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _getCharacters(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data.isEmpty) {
          return Center(
            child: Image.asset(
              'assets/NotFound.png',
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Character character = snapshot.data[index];
              return CharacterCard(character: character);
            },
          ),
        );
      },
    );
  }

  /*
    Builds the results of the search delegate

    If the results are empty, it displays an Not Found image or a list of characters

  */
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: Future.value(_characters),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data.isEmpty) {
          return Center(
            child: Image.asset(
              'assets/NotFound.png',
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Character character = snapshot.data[index];
              return CharacterCard(character: character);
            },
          ),
        );
      },
    );
  }
}
