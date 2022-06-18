import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';

import '../../../core/util/constants.dart';

class MyBtnAccount extends StatefulWidget {
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
  Color? color;
  Color? textColor;
  bool isCenter;
  TextStyle? textStyle;

  MyBtnAccount({
    Key? key,
    this.imagePath,
    this.textStyle,
    this.isCenter = false,
    required this.voidCallback,
    required this.text,
    this.radius = 10.0,
    this.height = 50.0,
    this.color,
    this.textColor,
    this.textAlign = TextAlign.start,
    this.width = double.infinity,
    this.stroke = false,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  State<MyBtnAccount> createState() => _MyBtnAccountState();
}

class _MyBtnAccountState extends State<MyBtnAccount> {
  late MainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<MainCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        border: widget.stroke ? Border.all(color: HexColor(mainColor)) : null,
      ),
      child: Material(
        color: cubit.isDark ? HexColor(secondaryColorD) : HexColor(greyWhite),
        child: InkWell(
          onTap: widget.voidCallback,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: cubit.isDark ? Colors.white : HexColor(mainColor),
                        fontSize: widget.fontSize,
                      ),
                ),
                space10Horizontal,
                if (!widget.isCenter) const Spacer(),
                if (widget.imagePath != null)
                  AssetSvg(
                    imagePath: widget.imagePath!,
                    color: cubit.isDark ? Colors.white : HexColor(mainColor),
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
