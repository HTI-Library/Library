import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';
import 'asset_svg.dart';

class SeeMoreItem extends StatelessWidget {
  const SeeMoreItem({
    Key? key,
    required this.gestureTapCallback,
    required this.text,
  }) : super(key: key);
  final GestureTapCallback gestureTapCallback;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      child: InkWell(
        onTap: gestureTapCallback,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: HexColor(mainColor),
                      fontSize: 18.0,
                    ),
              ),
              const Spacer(),
              AssetSvg(
                imagePath: 'arrow_right',
                color: HexColor(mainColor),
                size: 18.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
