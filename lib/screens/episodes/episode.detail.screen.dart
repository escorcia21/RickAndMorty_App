import 'package:flutter/material.dart';
import 'package:rickandmorty/models/character.dart';
import 'package:rickandmorty/models/episode.dart';
import 'package:rickandmorty/screens/characters/widgets/character.card.dart';
import 'package:rickandmorty/services/rickandmorty.service.dart';

/// **EpisodeDetailScreen** is a widget that displays the details of an episode
///
/// The [EpisodeDetailScreen] takes an [Episode] as an argument
///
/// the [Image.network] widget to display the episode's image
///
/// and the [Text] widget to display the episode's name, air date and episode code
///
/// /// Using a [FutureBuilder] to fetch the data,
/// a [ListView.builder] to display a list of characters
class EpisodeDetailScreen extends StatefulWidget {
  const EpisodeDetailScreen({super.key, required this.episode});
  final Episode episode;

  @override
  State<EpisodeDetailScreen> createState() => _EpisodeDetailScreenState();
}

class _EpisodeDetailScreenState extends State<EpisodeDetailScreen> {
  // List of characters that live in the location
  late Future<List<Character>> _characters;

  @override
  void initState() {
    super.initState();

    // Fetch the list of characters that live in the location
    _characters =
        RickAndMortyService.getCharactersByIds(widget.episode.characters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.episode.name),
      ),
      body: Column(
        children: [
          // Show the name, type and dimension of the location
          Image.network(
            widget.episode.stillPath,
            fit: BoxFit.fill,
          ),
          Text(
            widget.episode.airDate,
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            widget.episode.overview,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 20,
          ),

          // Show the list of characters that appear in the episode
          Text(
            'Characters',
            style: Theme.of(context).textTheme.headline1,
          ),
          Expanded(
            child: FutureBuilder(
              future: _characters,
              builder: (context, snapshot) {
                // If the list of characters is empty, show a message
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No characters found'),
                  );
                }

                // If the data is not fetched yet, show a loading indicator
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // If the list of characters is loaded, show the list of characters
                return ListView.builder(
                  itemCount: widget.episode.characters.length,
                  itemBuilder: (context, index) {
                    Character character = snapshot.data![index];
                    return CharacterCard(character: character);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
