import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPngImage extends StatelessWidget {
  final String imageName;
  final double height;
  final double width;
  final Color color;
  final BoxFit fit;
  CustomPngImage(
      {this.imageName, this.height, this.width, this.color, this.fit});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.png',
      height: height ?? 30,
      width: width ?? 30,
      fit: fit ?? BoxFit.fill,
      color: color,
    );
  }
}

class CustomSvgImage extends StatelessWidget {
  final String imageName;
  final double height;
  final double width;
  final Color color;
  CustomSvgImage({
    this.imageName,
    this.height,
    this.width,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/$imageName.svg',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: BoxFit.contain,
    );
  }
}

