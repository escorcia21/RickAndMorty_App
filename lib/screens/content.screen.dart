import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/widgets/searchdelegate.dart';

import 'characters/characters.screen.dart';

/// This is the stateless widget that contains the pages
/// and manages the app routes.
class ContentScreen extends StatefulWidget {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final PageController controller = PageController();
  // The index of the selected page.
  int currentIndex = 0;

  // The list of pages.
  List<Widget> pages = [
    const CharactersSreen(),
    const Center(child: Text('Episodes')),
    const Center(child: Text('Locations')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
        centerTitle: true,
        actions: [
          IconButton(
            // Open the search screen
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: PageView(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          controller: controller,
          children: pages,

          // Change the current index when the page changes
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Episodes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Locations',
          ),
        ],

        // Navigates to the selected page
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
