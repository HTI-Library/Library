import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/features/category_details/presentation/widgets/cat_details_item.dart';
import 'package:hti_library/features/search/presentation/search.dart';

class CategoryDetailsPage extends StatelessWidget {
  const CategoryDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: 'Python',
      actionIcon: IconButton(
        icon: AssetSvg(
          imagePath: 'search',
          size: 18.0,
          color: HexColor(mainColor),
        ),
        onPressed: () {
          navigateTo(context, SearchPage());
        },
      ),
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView.builder(
        itemBuilder: (context, index) => CatDetailsItem(),
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
      ),
    );
  }
}
