import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahra/bloc/get_search_movies_cubit/get_seach_movie_cubit.dart';
import 'package:sahra/view/pub_widgets/elements/background_widget.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/search_list_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  int page = 1;
  String searchKeyword = 'populer';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: deviceheight,
        width: devicewidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const BackgroundWidget(),
            _foregroundWidget(deviceheight, devicewidth),
          ],
        ),
      ),
    );
  }

 
  Widget _foregroundWidget(double height, double width) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, height * .01),
        width: width * .9,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _topBarWidget(),
            Expanded(child: _itemListWidget()),
          ],
        ),
      ),
    );
  }

  Widget _itemListWidget() {
    return SearchListView(moviename: searchKeyword);
  }

  Widget _topBarWidget() {
    return Container(
      height: 60.0,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(child: _searchFieldWidget()),
    );
  }

  Widget _searchFieldWidget() {
    return TextField(
      controller: _searchController,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white24,
        ),
        hintText: "Search...",
        hintStyle: TextStyle(color: Colors.white24),
      ),
      onSubmitted: (value) {
        searchKeyword = value;
        BlocProvider.of<GetSeachMovieCubit>(context).fetchSearchMovies(
            moviename: value, page: page, language: 'en', adult: true);
      },
    );
  }
}
