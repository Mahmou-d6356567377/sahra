import 'package:flutter/material.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/view/pub_widgets/elements/background_widget.dart';
import 'package:sahra/view/pub_widgets/elements/custom_drawer.dart';
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
  String searchKeyword = 'populer';
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
      drawer: const CustomDrawer(),
      appBar: AppBar(
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
      ),
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
    if (_selectedCategory == 'populer') {
      return const MovieListView();
    } else if (_selectedCategory == 'upcoming') {
      return const UpcomingMovieList();
    } else if (_selectedCategory == 'PlayingNow') {
      return const PlayingNowList();
    } else {
      //'TopRated'
      return const TopRatedList();
    }
  }
}