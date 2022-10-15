import 'package:flutter/material.dart';
import 'package:rickandmorty/models/character.dart';
import 'package:rickandmorty/models/location.dart';
import 'package:rickandmorty/screens/characters/widgets/character.card.dart';
import 'package:rickandmorty/services/rickandmorty.service.dart';

/// **LocationDetailScreen** is the screen that shows the details of a location
///
/// It receives a [Location] object as a parameter
///
/// It shows the name, type, dimension and the list of characters that
/// live in that location
class LocationDetailScreen extends StatefulWidget {
  final Location location;
  const LocationDetailScreen({super.key, required this.location});

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  // List of characters that live in the location
  late Future<List<Character>> _residents;

  @override
  void initState() {
    super.initState();

    // Fetch the list of characters that live in the location
    _residents =
        RickAndMortyService.getCharactersByIds(widget.location.residents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Show the name, type and dimension of the location
            Text(
              '${widget.location.name} is a ${widget.location.type} located in ${widget.location.dimension}',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Habitants',
              style: Theme.of(context).textTheme.headline1,
            ),

            // Show the list of characters that live in the location
            Expanded(
              child: FutureBuilder(
                future: _residents,
                builder: (context, snapshot) {
                  // If the list of characters is empty, show a message
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('No Habitants found'),
                    );
                  }

                  // If the list of characters is not loaded yet, show a loading indicator
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // If the list of characters is loaded, show the list of characters
                  return ListView.builder(
                    itemCount: widget.location.residents.length,
                    itemBuilder: (context, index) {
                      // Get the character from the snapshot and creating a CharacterCard
                      Character character = snapshot.data![index];
                      return CharacterCard(character: character);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
