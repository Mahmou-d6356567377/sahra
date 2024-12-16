import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahra/bloc/get_search_movies_cubit/get_seach_movie_cubit.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie_item.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({super.key, required this.moviename});
final String moviename;
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchListView> {
  final ScrollController _scrollController = ScrollController();
  int page = 1; // Initial page
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSeachMovieCubit>(context).fetchSearchMovies(moviename: widget.moviename, page: page, language: 'en', adult: true);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Detect scrolling position to increase or decrease the page
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached bottom, increase the page
      setState(() {
        page++;
      });
      _loadMoreMovies();
    } else if (_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent) {
      // Reached top, decrease the page
      if (page > 1) {
        setState(() {
          page--;
        });
        _loadMoreMovies(isScrollingDown: false);
      }
    }
  }

  // Fetch more movies when page changes
  void _loadMoreMovies({bool isScrollingDown = true})async {
    // Call the Cubit to fetch movies for the new page
   await BlocProvider.of<GetSeachMovieCubit>(context).fetchSearchMovies(moviename: widget.moviename, page: page, language: 'en', adult: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSeachMovieCubit, GetSeachMovieState>(
      builder: (context, state) {
        if (state is GetSeachMovieSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                page = 1;
              });
              await BlocProvider.of<GetSeachMovieCubit>(context).fetchSearchMovies(moviename: widget.moviename, page: page, language: 'en', adult: true);
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return MovieItem(
                    movieItemDetails: state.movies[index],
                    height: 200,
                    width: 100);
              },
            ),
          );
        } else if (state is GetSeachMovieFailure) {
          return Center(
            child: Text(
              state.errmsg,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is GetSeachMovieLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.blue,
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }
}
