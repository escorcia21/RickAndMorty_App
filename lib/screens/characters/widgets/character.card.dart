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

    // Card itself
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
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Row(
                children: [
                  Container(width: 12, height: 12, decoration: coloredDot),
                  const SizedBox(width: 8.0),
                  Text(
                    '${character.status} - ${character.species}',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),

              // Show the character's origin and Last known location
              Text(
                'Last known location:',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                character.location.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Origin:',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                character.origin.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ]),
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
}
