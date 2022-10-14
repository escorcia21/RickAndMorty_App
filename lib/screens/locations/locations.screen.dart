import 'package:flutter/material.dart';
import 'package:rickandmorty/models/location.dart';
import 'package:rickandmorty/screens/locations/widgets/location.card.dart';
import 'package:rickandmorty/services/rickandmorty.service.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

/*
  Extending mixin [AutomaticKeepAliveClientMixin] to keep the state of the 
  widget alive when navigating to another screen
*/
class _LocationsScreenState extends State<LocationsScreen>
    with AutomaticKeepAliveClientMixin {
  /// The list of Locations
  late Future<List<Location>> _locations;
  final _controller = ScrollController();
  var pagination = 2;

  /// Loading more locations when the user scrolls to the bottom of the list
  void _loadMorelocations() async {
    // if the pagination is more than 41, then stop loading more locations
    if (pagination > 41) {
      const snackBar = SnackBar(content: Text('No more locations'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    // Fetch the next page of locations
    try {
      final page = await RickAndMortyService.getLocations(page: pagination);

      // Add the new locations to the list and increment the pagination
      setState(() {
        pagination++;
        _locations = _locations.then((locations) {
          return [...locations, ...page];
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
      Fetch the locations from the API and store the result in  _locations 
      Showing a loading indicator while fetching the data
      and showing an error message with a SnackBar if something went wrong
    */
    try {
      _locations = RickAndMortyService.getLocations();
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
        _loadMorelocations();
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
      future: _locations,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: snapshot.data.length + 1,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            // Get the location from the snapshot and creating a locationCard
            if (index < snapshot.data.length) {
              final location = snapshot.data[index];
              return LocationCard(location: location);
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
