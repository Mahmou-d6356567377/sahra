import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/data/models/movie_page_model/movie_page_model.dart';
import 'package:sahra/view/screens/fav_screen/widgets/fav_movie_item.dart';

class FavListView extends StatefulWidget {
  const FavListView({super.key});

  @override
  _FavListViewState createState() => _FavListViewState();
}

class _FavListViewState extends State<FavListView> {
  final ScrollController _scrollController = ScrollController();
  Box? movieBox;

  @override
  void initState() {
    super.initState();
    _openBox();
   // deleteBox();
  }

  Future<void> deleteBox() async {
    
     movieBox?.deleteFromDisk();
    print('The box has been deleted from disk.');
  }

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen(kboxname)) {
    movieBox = await Hive.openBox<MoviePageModel>(kboxname);
  } else {
    movieBox = Hive.box<MoviePageModel>(kboxname);
  }
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    movieBox?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (movieBox == null) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.blue,
        ),
      );
    }

    final movies = movieBox!.values.toList();
    //  for (var element in movies) {
    //    print('the id is ${element.id}  and the title is ${element.originalTitle}  and the poster path is ${element.posterPath}');
    //  }

    if (movies.isEmpty) {
      return const Center(
        child: Text(
          'No favorite movies found!',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .55,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      controller: _scrollController,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index]; 
        return MovieCard(
          id: movie.id!,
          image: movie.posterPath ?? '',
          description: movie.originalTitle ?? 'No description available',
        );
      },
    );
  }
}
