import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';

class AvailableItem extends StatelessWidget {
  const AvailableItem({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 3.0,
      ),
      decoration: BoxDecoration(
        color: HexColor(green),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.caption!.copyWith(
              color: HexColor(surface),
          fontSize: 10.0,
            ),
      ),
    );
  }
}
