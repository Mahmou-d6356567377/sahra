import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahra/bloc/get_search_movies_cubit/get_seach_movie_cubit.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/view/pub_widgets/elements/custom_drawer.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/movie_list_view.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/playing_now_list.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/search_list_view.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/top_rated_list.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/upcoming_movie_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchKeyword = 'populer';
  String? _selectedCategory = 'populer';
  int page = 1;
  bool _isSearchActive = false;
  bool _isHomeActive = true;
  bool _isNotiActive = false;
  bool _islastiActive = false;

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
      drawer: const CustomDrawer(),
      appBar: _isHomeActive
          ? AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                'Sahra',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: kmainfont2,
                  color: Colors.grey,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _dropDownMenu(),
                ),
              ],
            )
          : null,
      body: SizedBox(
        height: deviceheight,
        width: devicewidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidget(deviceheight, devicewidth),
            Positioned(
              bottom: 20,
              child: Container(
                width: devicewidth * 0.9, // Adjust the width
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: _isHomeActive ? 35 : 25,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = false;
                          _isHomeActive = true;
                          _islastiActive = false;
                          _isNotiActive = false;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: _isSearchActive ? 35 : 25,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = true;
                          _isHomeActive = false;
                          _islastiActive = false;
                          _isNotiActive = false;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: _isNotiActive ? 35 : 25,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = false;
                          _isHomeActive = false;
                          _islastiActive = false;
                          _isNotiActive = true;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: _islastiActive ? 35 : 25,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = false;
                          _isHomeActive = false;
                          _islastiActive = false;
                          _isNotiActive = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
            fit: BoxFit.cover, image: AssetImage('assets/images/tstimg.jpg')),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(.2)),
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
            Visibility(visible: _isSearchActive, child: _topBarWidget()),
            Expanded(child: _itemListWidget()),
          ],
        ),
      ),
    );
  }

  Widget _dropDownMenu() {
    return DropdownButton<String>(
      value: _selectedCategory,
      dropdownColor: Colors.black.withOpacity(.6),
      style: const TextStyle(color: Colors.white60),
      items: const [
        DropdownMenuItem<String>(value: "populer", child: Text("Populer")),
        DropdownMenuItem<String>(value: "upcoming", child: Text("Upcoming")),
        DropdownMenuItem<String>(value: "latest", child: Text("Latest")),
        DropdownMenuItem<String>(
            value: "PlayingNow", child: Text("PlayingNow")),
        DropdownMenuItem<String>(value: "TopRated", child: Text("TopRated")),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
    );
  }

  Widget _itemListWidget() {
    if (_selectedCategory == 'populer' && _isHomeActive) {
      return const MovieListView();
    } else if (_selectedCategory == 'upcoming' && _isHomeActive) {
      return const UpcomingMovieList();
    } else if (_selectedCategory == 'PlayingNow' && _isHomeActive) {
      return const PlayingNowList();
    } else if (_selectedCategory == 'TopRated' && _isHomeActive) {
      return const TopRatedList();
    } else if (_isSearchActive) {
      return SearchListView(moviename: searchKeyword);
    } else {
      return SearchListView(moviename: searchKeyword);
    }
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
