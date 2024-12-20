import 'package:flutter/material.dart';
import 'package:sahra/view/pub_widgets/elements/background_widget.dart';
import 'package:sahra/view/screens/fav_screen/widgets/fav_list.dart';


class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {

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
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: FavListView()),
          ],
        ),
      ),
    );
  }

 
}