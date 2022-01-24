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
  TextAlign textAlign;
  double fontSize;
  bool isCenter;

  MyBtnAccount({
    Key? key,
    this.imagePath,
    this.isCenter = false,
    required this.voidCallback,
    required this.text,
    this.radius = 10.0,
    this.height = 50.0,
    this.textAlign = TextAlign.start,
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
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: stroke ? Border.all(color: HexColor(mainColor)) : null,
      ),
      child: Material(
        color: HexColor(greyWhite),
        child: InkWell(
          onTap: voidCallback,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: HexColor(mainColor),
                        fontSize: fontSize,

                      ),
                ),
                space10Horizontal,
                if(!isCenter)
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
