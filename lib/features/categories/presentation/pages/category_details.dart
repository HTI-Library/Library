import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        actionIcon: IconButton(
          onPressed: () {},
          icon: AssetSvg(
            imagePath: 'search',
            size: 18.0,
            color: HexColor(mainColor),
          ),
        ),
        body: Column(),
        title: 'Python',
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
