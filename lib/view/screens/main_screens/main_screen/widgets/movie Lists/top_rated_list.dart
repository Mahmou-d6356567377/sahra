import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahra/bloc/get_top_rated_cubit/get_top_rated_cubit_cubit.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie_item.dart';

class TopRatedList extends StatefulWidget {
  const TopRatedList({super.key});

  @override
  _TopRatedListState createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTopRatedCubitCubit, GetTopRatedCubitState>(
      builder: (context, state) {
        if (state is GetTopRatedCubitSuccess) {
          return ListView.builder(
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              return MovieItem(
                  movieItemDetails: state.movies[index],
                  height: 200,
                  width: 100);
            },
          );
        } else if (state is GetTopRatedCubitFailure) {
          return Center(
            child: Text(
              state.errmsg,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is GetTopRatedCubitLoading) {
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
