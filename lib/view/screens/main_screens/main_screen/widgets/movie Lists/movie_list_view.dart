import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahra/bloc/get_populer_cubits/getmovies_cubit.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie_item.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  final ScrollController _scrollController = ScrollController();
  int page = 1; // Initial page
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
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
  void _loadMoreMovies({bool isScrollingDown = true}) {
    // Call the Cubit to fetch movies for the new page
    BlocProvider.of<GetmoviesCubit>(context).fetchMovies(page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetmoviesCubit, GetmoviesState>(
      builder: (context, state) {
        if (state is GetmoviesSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                page = 1;
              });
              await BlocProvider.of<GetmoviesCubit>(context).fetchMovies(page);
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
        } else if (state is GetmoviesFailure) {
          return Center(
            child: Text(
              state.errmsg,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is GetmoviesLoading) {
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
