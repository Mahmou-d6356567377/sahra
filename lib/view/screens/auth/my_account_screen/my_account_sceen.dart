import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/core/constants/font_constant.dart';
import 'package:sahra/core/routes/app_routes.dart';
import 'package:sahra/view/pub_widgets/pub_widgets_lite/custom_info_container.dart';

class MyAccountSceen extends StatelessWidget {
  const MyAccountSceen({super.key});
  
   

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
       
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'my acount',
          style: TextStyle(
            fontFamily: kmainfont2,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          _backgroundWidget(),
          _foregroundWidget(deviceheight, devicewidth, context),
        ],
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
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

  Widget _foregroundWidget(double height, double width ,BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, height * .01),
        width: width * .9,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage(klogo2),
              ),
            ),
            const CustomInfoContainer(title: 'Mahmoud Ashraf Mohammed'),
            const CustomInfoContainer(title: 'ma2327424@gmail.com'),
            const CustomInfoContainer(title: '+20 1027892188'),
            Row(
              children: [
                Text(
                  'You\'r not registered?   ',
                  style: mainfont1.copyWith(color: Colors.grey, fontSize: 20),
                ),
                GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRoutes.bas);
                    },
                    child: Text(
                      'make account ',
                      style: mainfont1.copyWith(
                          color: Colors.deepPurpleAccent, fontSize: 20),
                    ))
              ],
            ),
            Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'You Have Account ?  ',
                          style: mainfont1.copyWith(fontSize: 20, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(AppRoutes.lns);
                          },
                          child: Text(
                            'LogIn',
                            style: mainfont1.copyWith(
                                color: Colors.blueAccent, fontSize: 20),
                          ),
                        )
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}
