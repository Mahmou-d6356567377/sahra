import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahra/bloc/get_upcoming_cubit/get_up_coming_cubit_cubit.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie_item.dart';

class UpcomingMovieList extends StatefulWidget {
  const UpcomingMovieList({super.key});

  @override
  _UpcomingMovieListState createState() => _UpcomingMovieListState();
}

class _UpcomingMovieListState extends State<UpcomingMovieList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUpComingCubitCubit, GetUpComingCubitState>(
      builder: (context, state) {
        if (state is GetUpComingCubitSuccess) {
          return ListView.builder(
            itemCount: state.upcomingMovies.length,
            itemBuilder: (context, index) {
              return MovieItem(
                  movieItemDetails: state.upcomingMovies[index],
                  height: 200,
                  width: 100);
            },
          );
        } else if (state is GetUpComingCubitFailure) {
          return Center(
            child: Text(
              state.errMsg,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is GetUpComingCubitLoading) {
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
