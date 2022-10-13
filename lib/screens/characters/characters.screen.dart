import 'package:flutter/material.dart';
import 'package:rickandmorty/models/character.dart';
import 'package:rickandmorty/screens/characters/widgets/character.card.dart';
import 'package:rickandmorty/services/rickandmorty.service.dart';

/// **CharactersScreen** is a widget that displays a list of characters
///
/// Using a [FutureBuilder] to fetch the data
/// and a [ListView.builder] to display a list of characters
///
/// It displays a [ListView] with a list of [CharacterCard]
class CharactersSreen extends StatefulWidget {
  const CharactersSreen({Key? key}) : super(key: key);

  @override
  State<CharactersSreen> createState() => _CharactersSreenState();
}

/*
  Extending mixin [AutomaticKeepAliveClientMixin] to keep the state of the 
  widget alive when navigating to another screen
*/
class _CharactersSreenState extends State<CharactersSreen>
    with AutomaticKeepAliveClientMixin {
  /// The list of characters
  late Future<List<Character>> _characters;

  @override
  void initState() {
    super.initState();
    /*
      Fetch the characters from the API and store the result in  _characters 
      Showing a loading indicator while fetching the data
      and showing an error message with a SnackBar if something went wrong
    */
    _characters = RickAndMortyService.getCharacters().catchError((error) {
      final snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // FutureBuilder to build the widget based on the state of the future
    return FutureBuilder(
      future: _characters,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            // Get the character from the snapshot and creating a CharacterCard
            Character character = snapshot.data[index];
            return CharacterCard(character: character);
          },
        );
      },
    );
  }

  // The method that keeps the state of the widget
  @override
  bool get wantKeepAlive => true;
}
