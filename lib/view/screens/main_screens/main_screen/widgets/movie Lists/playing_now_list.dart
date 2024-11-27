import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahra/bloc/get_PlayIngNow_cubits/get_play_iing_now_cubit.dart';
import 'package:sahra/bloc/get_upcoming_cubit/get_up_coming_cubit_cubit.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie_item.dart';

class PlayingNowList extends StatefulWidget {
  const PlayingNowList({Key? key}) : super(key: key);

  @override
  _PlayingNowListState createState() => _PlayingNowListState();
}

class _PlayingNowListState extends State<PlayingNowList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlayIingNowCubit, GetPlayIingNowState>(
      builder: (context, state) {
        if (state is GetPlayIingNowSuccess) {
          return ListView.builder(
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              return MovieItem(
                  movieItemDetails: state.movies[index],
                  height: 200,
                  width: 100);
            },
          );
        } else if (state is GetPlayIingNowFailure) {
          return Center(
            child: Text(
              state.errmsg,
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
