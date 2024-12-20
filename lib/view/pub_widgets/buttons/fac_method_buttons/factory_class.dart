



import 'package:sahra/view/pub_widgets/buttons/fac_method_buttons/custom_button1.dart';

class CustomButtonFactory {
  static CustomButton1 createButton (String buttonType){
    switch (buttonType) {
      case "CustomButton1":
        return CustomButton1();
      default:
      throw Exception('Button type not found');
    }
  }
}