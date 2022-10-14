import 'package:flutter/material.dart';
import 'package:rickandmorty/models/episode.dart';
import 'package:rickandmorty/screens/episodes/episode.detail.screen.dart';

/// **EpisodeCard** is a widget that displays the episode card
///
/// It takes an [Episode] as input
///
/// It displays a [Text] with the episode name
///
/// It displays a [Text] with the episode air date
///
/// It displays a [Text] with the episode code
class EpisodeCard extends StatelessWidget {
  const EpisodeCard({super.key, required this.episode});
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    // Wrap the widget with an InkWell to make it tappable
    return InkWell(
      // Navigate to the details screen
      onTap: () {
        Navigator.push(context, _createRoute());
      },

      // The card itself
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // show the episode's name
              Text('Name', style: Theme.of(context).textTheme.headline3),
              Text(episode.name, style: Theme.of(context).textTheme.subtitle1),

              // show the episode's air date
              Text('Air Date', style: Theme.of(context).textTheme.headline3),
              Text(episode.airDate,
                  style: Theme.of(context).textTheme.subtitle1),

              // show the episode's code
              Text('Code', style: Theme.of(context).textTheme.headline3),
              Text(episode.episode,
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
      ),
    );
  }

  // Router to the details screen with a transition animation
  Route _createRoute() {
    return PageRouteBuilder(
      // The page to navigate to
      pageBuilder: (context, animation, secondaryAnimation) =>
          EpisodeDetailScreen(episode: episode),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        // Animate the position of the child
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        // Slide the page from bottom to top while fading it in
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
