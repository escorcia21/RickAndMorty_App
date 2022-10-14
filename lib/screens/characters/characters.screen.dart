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
  final _controller = ScrollController();
  var pagination = 2;

  /// Loading more characters when the user scrolls to the bottom of the list
  void _loadMoreCharacters() async {
    // if the pagination is more than 41, then stop loading more characters
    if (pagination > 41) {
      // Show a snackbar to notify the user that there are no more characters
      const snackBar = SnackBar(content: Text('No more characters'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Stop the listener
      _controller.dispose();
      return;
    }

    // Fetch the next page of characters
    try {
      final page = await RickAndMortyService.getCharacters(page: pagination);

      // Add the new characters to the list and increment the pagination
      setState(() {
        pagination++;
        _characters = _characters.then((characters) {
          return [...characters, ...page];
        });
      });
    } catch (error) {
      // Show a snackbar to notify the user that there was an error
      final snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    /*
      Fetch the characters from the API and store the result in  _characters 
      Showing a loading indicator while fetching the data
      and showing an error message with a SnackBar if something went wrong
    */
    try {
      _characters = RickAndMortyService.getCharacters();
    } catch (error) {
      // Show a snackbar to notify the user that there was an error
      final snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    /*
      Adding a listener to the controller to load more characters when scrolling
      to the bottom of the list    
    */
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMoreCharacters();
      }
    });
  }

  // When the widget is removed from the widget tree, dispose the controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          itemCount: snapshot.data.length + 1,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            // Get the character from the snapshot and creating a CharacterCard
            if (index < snapshot.data.length) {
              final character = snapshot.data[index];
              return CharacterCard(character: character);
            }

            // Show a loading indicator when the user are in the end of the list
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  // The method that keeps the state of the widget
  @override
  bool get wantKeepAlive => true;
}
