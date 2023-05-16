import 'package:flutter/material.dart';
import 'package:responsive_login_page/widgets/pallete.dart';

class Socialbutton extends StatelessWidget {
  final String iconPath;
  final double paddingborder;
  final String label;
  const Socialbutton({super.key, 
    
    required this.iconPath,
    required this.label,
    this.paddingborder = 100,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      // icon: SvgPicture.asset(iconPath,
      //   width: 25,
      //   color: Pallete.whiteColor,
      // ),
      icon: Image.asset(iconPath,
      color: Pallete.whiteColor,
      width:25 ),
      label: Text(
        label,
        style: const TextStyle(color: Pallete.whiteColor, fontSize: 17),
      ),
      style: TextButton.styleFrom(
          padding:
              EdgeInsets.symmetric(vertical: 30, horizontal: paddingborder),
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Pallete.borderColor, width: 3),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
