import 'package:flutter/material.dart';
import 'package:rickandmorty/models/location.dart';
import 'package:rickandmorty/screens/locations/location.detail.screen.dart';

/// **LocationCard** is a widget that displays a location card
///
/// It displays a [Text] with the location name
///
/// It displays a [Text] with the location type
///
/// It displays a [Text] with the location dimension
class LocationCard extends StatelessWidget {
  final Location location;
  const LocationCard({super.key, required this.location});

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
              // Show the location name, type and dimension
              Text('Name', style: Theme.of(context).textTheme.headline3),
              Text(location.name, style: Theme.of(context).textTheme.subtitle1),
              Text('Type', style: Theme.of(context).textTheme.headline3),
              Text(location.type, style: Theme.of(context).textTheme.subtitle1),
              Text('Dimension', style: Theme.of(context).textTheme.headline3),
              Text(location.dimension,
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
          LocationDetailScreen(location: location),
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
