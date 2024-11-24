import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  double? _deviceheight;
  double? _devicewidth;
  TextEditingController? textfieldcontroller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceheight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;
    textfieldcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backGroundWidget(),
            _forGroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backGroundWidget() {
    return Container(
      height: _deviceheight,
      width: _devicewidth,
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

  Widget _forGroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceheight! * .02, 0, 0),
      width: _devicewidth! * .9,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceheight! * .08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchFieldWidget(),
        _dropMenue(),
        ],
      ),
    );
  }

  Widget _dropMenue() {
    return DropdownButton(
      value: "populer",
      items: [
      DropdownMenuItem(value: "populer",child: Text("populer")),
      DropdownMenuItem(value: "upcoming",child: Text("upcoming")),
      DropdownMenuItem(value: "latest",child: Text("latest")),

    ], onChanged: (value) {});
  }

  Widget _searchFieldWidget() {
    InputBorder _border = InputBorder.none;
    return Container(
      width: _devicewidth! * .5,
      height: _deviceheight! * .05,
      child: TextField(
        controller: textfieldcontroller,
        onSubmitted: (_input) {},
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            focusedBorder: _border,
            border: _border,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white24,
            ),
            hintStyle: TextStyle(
              color: Colors.white24,
            ),
            filled: false,
            fillColor: Colors.white24,
            hintText: "search ...."),
      ),
    );
  }
}
