import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahra/data/controllers/page_controller/pagecontroller.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';

class MovieListView extends StatelessWidget {
  final List<MovieModel> movies;

  const MovieListView({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(movies[index].title!),
        );
      },
    );
  }
}

class MovieListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the state from the provider
    final mainPageState = ref.watch(MainPageController as ProviderListenable);

    return Scaffold(
      appBar: AppBar(title: Text('Movies')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
            },
            child: Text('Fetch Movies'),
          ),
          Expanded(
            // Pass the movies list from the state
            child: MovieListView(movies: mainPageState.movies),
          ),
        ],
      ),
    );
  }
}
