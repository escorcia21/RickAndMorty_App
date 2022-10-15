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
        // Card color
        color: Colors.black,

        // Show the episode banner at the bottom with the stack widget
        child: Stack(children: [
          // Make the image fade in to the bottom
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                ],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              episode.stillPath,
              fit: BoxFit.fill,
            ),
          ),

          // Make the Row expand to the bottom
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // show the episode's name
                  Text(episode.name,
                      style: Theme.of(context).textTheme.headline4),

                  // make a dot between the name and the air date
                  const Text(' • '),

                  // show the episode's air date
                  Text(episode.airDate,
                      style: Theme.of(context).textTheme.headline4),
                ],
              ),
            ),
          ),
        ]),
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
