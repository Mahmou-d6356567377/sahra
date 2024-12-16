import 'package:flutter/material.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/view/pub_widgets/elements/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.6,
      shape: const  RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(30), // Adds a circular edge to the right
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
       
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  const EdgeInsets.only(top: 30.0 , bottom: 10),
              child:  Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(klogo),
            ),
          ),
        ),
            ),
          ],
        ),
      

         DrawerItem(ontap: (){}, title: 'Register', drawIcon: const Icon(Icons.app_registration_rounded)),
         DrawerItem(ontap: (){}, title: 'Login', drawIcon: const Icon(Icons.login)),
          ],
        ),
      ),
    );
  }
}

