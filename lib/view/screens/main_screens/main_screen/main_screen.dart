import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/movie_list_view.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/playing_now_list.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/top_rated_list.dart';
import 'package:sahra/view/screens/main_screens/main_screen/widgets/movie%20Lists/upcoming_movie_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _selectedCategory = 'populer';
  int page = 1;
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
            _backgroundWidget(),
            _foregroundWidget(deviceheight, devicewidth),
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
            _topBarWidget(),
            Expanded(child: _itemListWidget()),
          ],
        ),
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _searchFieldWidget(),
          _dropDownMenu(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    return const SizedBox(
      width: 200.0,
      height: 40.0,
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white24,
          ),
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.white24),
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
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
    );
  }

  Widget _itemListWidget() {
    if (_selectedCategory == 'populer') {
      return const MovieListView();
    } else if (_selectedCategory == 'upcoming') {
      return const UpcomingMovieList();
    } else if (_selectedCategory == 'PlayingNow') {
      return const PlayingNowList();
    } else {
      return const TopRatedList();
    }
  }
}
