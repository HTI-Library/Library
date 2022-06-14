import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import '../constants.dart';

class AssetSvg extends StatelessWidget {
  final String imagePath;
  Color? color;
  double? size;
  int? change;

  AssetSvg({
    Key? key,
    required this.imagePath,
    this.color = secondaryVariant,
    this.size ,
    this.change = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: isRtl ? -1 : 1,
      child: SvgPicture.asset(
        'assets/images/$imagePath.svg',
        color: color,
        width: size,
        height: size,
      ),
    );
  }
}