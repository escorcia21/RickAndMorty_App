import 'package:flutter/material.dart';
import 'package:rickandmorty/models/episode.dart';
import 'package:rickandmorty/screens/episodes/widgets/episodes.card.dart';
import 'package:rickandmorty/services/rickandmorty.service.dart';

/// **EpisodesScreen** is a widget that displays a list of episodes
///
/// Using a [FutureBuilder] to fetch the data,
/// a [ListView.builder] to display a list of episodes
///
/// and a [DropdownButton] to filter the episodes by season
///
/// It displays a [ListView] with a list of [EpisodeCard]
class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

/*
  Extending mixin [AutomaticKeepAliveClientMixin] to keep the state of the 
  widget alive when navigating to another screen
*/
class _EpisodesScreenState extends State<EpisodesScreen>
    with AutomaticKeepAliveClientMixin {
  // The list of seasons
  final _seasons = [
    'Season 1',
    'Season 2',
    'Season 3',
    'Season 4',
    'Season 5',
  ];
  var currentSeason = 1;

  // The list of episodes
  late Future<List<Episode>> _episodes;

  @override
  void initState() {
    super.initState();
    /*
      Fetch the Episodes from the API and store the result in  _episodes 
      Showing a loading indicator while fetching the data
      and showing an error message with a SnackBar if something went wrong
    */
    try {
      _episodes = RickAndMortyService.getEpisodes();
    } catch (e) {
      // Show a snackbar to notify the user that there was an error
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // Fetch the episodes of a season
  void _getSeason(String name, int season) async {
    try {
      // Add the new episodes to the list
      if (season != currentSeason) {
        setState(() {
          _episodes = RickAndMortyService.getEpisodes(
              episode: name, seasonNumber: season);
          currentSeason = season;
        });
      }
    } catch (error) {
      // Show a snackbar to notify the user that there was an error
      final snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _dropdownButton(),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(top: 10),

          // FutureBUilder to build the widget based on the state
          child: FutureBuilder(
            future: _episodes,
            initialData: const [],
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // If the data is not fetched yet, show a loading indicator
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Build a list of episodes
              return ListView.builder(
                physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  // Get the episode from the snapshot and creating a EpisodeCard
                  Episode episode = snapshot.data[index];
                  return EpisodeCard(episode: episode);
                },
              );
            },
          ),
        )),
      ],
    );
  }

  /// **_dropdownButton** displays a dropdown button
  Widget _dropdownButton() {
    return DropdownButtonFormField(
      items: _dropdownItems(),
      value: 'Season 1',
      onChanged: (value) {
        switch (value) {
          case 'Season 1':
            _getSeason('S01', 1);
            break;
          case 'Season 2':
            _getSeason('S02', 2);
            break;
          case 'Season 3':
            _getSeason('S03', 3);
            break;
          case 'Season 4':
            _getSeason('S04', 4);
            break;
          case 'Season 5':
            _getSeason('S05', 5);
            break;
          default:
            _getSeason('S01', 1);
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }

  /// Create a list of [DropdownMenuItem]
  List<DropdownMenuItem> _dropdownItems() {
    return _seasons
        .map((season) => DropdownMenuItem(
              value: season,
              child: Text(season),
            ))
        .toList();
  }

  // Keep the state of the widget alive
  @override
  bool get wantKeepAlive => true;
}
