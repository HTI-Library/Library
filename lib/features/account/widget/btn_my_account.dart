import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';

import '../../../core/util/constants.dart';

class MyBtnAccount extends StatelessWidget {
  final VoidCallback voidCallback;
  final String text;
  double radius;
  bool stroke;
  String? imagePath;
  double height;
  double width;
  FontWeight fontWeight;
  double fontSize;

  MyBtnAccount({
    Key? key,
    this.imagePath,
    required this.voidCallback,
    required this.text,
    this.radius = 10.0,
    this.height = 55.0,
    this.width = double.infinity,
    this.stroke = false,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: stroke ? Border.all(color: HexColor(mainColor)) : null,
        // color: HexColor(greyWhite),
      ),
      child: Material(
        color: HexColor(greyWhite),
        child: InkWell(
          onTap: voidCallback,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: HexColor(mainColor),
                        fontSize: fontSize,
                      ),
                ),
                const Spacer(),
                AssetSvg(
                  imagePath: imagePath!,
                  color: HexColor(mainColor),
                  size: 23,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
