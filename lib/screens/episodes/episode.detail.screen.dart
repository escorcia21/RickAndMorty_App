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
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.episode.airDate,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.episode.overview,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          // Show the list of characters that appear in the episode
          Text(
            'Characters: ${widget.episode.characters.length}',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Expanded(
            child: FutureBuilder(
              future: _characters,
              builder: (context, snapshot) {
                // If the data is not fetched yet, show a loading indicator
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // If the list of characters is loaded, show the list of characters
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: widget.episode.characters.length,
                    itemBuilder: (context, index) {
                      Character character = snapshot.data![index];
                      return CharacterCard(character: character);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
