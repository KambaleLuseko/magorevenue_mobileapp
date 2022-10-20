import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final Size size;
  const AppLogo({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.zero,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Container() // Image.asset("Assets/Images/logo_h_black.png"),
          ),
    );
  }
}

class DisplayImage extends StatelessWidget {
  final Size size;
  final String imagePath;
  final double radius;
  const DisplayImage(
      {Key? key,
      required this.size,
      required this.imagePath,
      required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(imagePath),
      ),
    );
  }
}
