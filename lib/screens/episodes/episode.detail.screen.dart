import 'package:flutter/material.dart';
import 'package:rickandmorty/models/episode.dart';

class EpisodeDetailScreen extends StatefulWidget {
  const EpisodeDetailScreen({super.key, required this.episode});
  final Episode episode;

  @override
  State<EpisodeDetailScreen> createState() => _EpisodeDetailScreenState();
}

class _EpisodeDetailScreenState extends State<EpisodeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.episode.name),
      ),
      body: const Center(
        child: Text('Episode Details'),
      ),
    );
  }
}
