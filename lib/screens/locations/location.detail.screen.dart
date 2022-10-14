import 'package:flutter/material.dart';
import 'package:rickandmorty/models/location.dart';

class LocationDetailScreen extends StatefulWidget {
  const LocationDetailScreen({super.key, required Location location});

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
      ),
      body: const Center(
        child: Text('Location Details'),
      ),
    );
  }
}
