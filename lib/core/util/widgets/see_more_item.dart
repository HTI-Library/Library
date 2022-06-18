import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';

import '../constants.dart';
import 'asset_svg.dart';

class SeeMoreItem extends StatelessWidget {
  const SeeMoreItem({
    Key? key,
    required this.gestureTapCallback,
    required this.text,
    this.padding = 15,


  }) : super(key: key);
  final GestureTapCallback gestureTapCallback;
  final String text;
  final double padding ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      child: InkWell(
        onTap: gestureTapCallback,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18.0,
                color:  MainCubit.get(context).isDark?HexColor(surface):HexColor(mainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
