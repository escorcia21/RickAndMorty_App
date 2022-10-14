import 'package:rickandmorty/screens/characters/character.details.screen.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/models/character.dart';
import 'package:rickandmorty/theme/colors.dart';

/// **CharacterCard** is a widget that displays a character card
/// with a name and image. It takes a [Character] as input
///
/// It displays a [Text] with the character name
///
/// It displays a [Image] with the character image
///
/// It displays a [Text] with the character status
///
/// It displays a [Text] with the character species
///
/// It displays a [Text] with the character origin
class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character}) : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    // color of the status text(Alive, Dead, Unknown)
    final BoxDecoration coloredDot = BoxDecoration(
      shape: BoxShape.circle,
      color: getStatusColor(character.status),
    );

    // Wrap the widget with an InkWell to make it tappable
    return InkWell(
      // Navigate to the details screen
      onTap: () {
        Navigator.push(context, _createRoute());
      },

      // The card itself
      child: AnimatedBuilder(
        animation: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: const AlwaysStoppedAnimation(0),
            curve: Curves.easeIn,
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return Card(
            child: Row(children: [
              Image.network(
                character.image,
                width: 150,
                height: 150,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Show the character name and status
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Row(
                      children: [
                        Container(
                            width: 12, height: 12, decoration: coloredDot),
                        const SizedBox(width: 8.0),
                        Text(
                          '${character.status} - ${character.species}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )
                      ],
                    ),

                    // Show the character's origin and Last known location
                    Text(
                      'Last known location:',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      character.location.name,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      'Origin:',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      character.origin.name,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  /// Returns the color based on the [status] (Alive, Dead, Unknown)
  Color getStatusColor(String status) {
    if (status == 'Alive') {
      return AppColors.primaryColor;
    } else if (status == 'Dead') {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  // Router to the details screen with a transition animation
  Route _createRoute() {
    return PageRouteBuilder(
      // The page to navigate to
      pageBuilder: (context, animation, secondaryAnimation) =>
          CharacterDetailScreen(character: character),
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
