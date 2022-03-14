import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/models/categories_model.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/features/category_details/presentation/pages/category_details_page.dart';

class CatItem extends StatelessWidget {
  const CatItem({Key? key, required this.model}) : super(key: key);
  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      shadowColor: HexColor(greyWhite),
      margin:
          const EdgeInsetsDirectional.only(bottom: 15.0, start: 5.0, end: 5.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              CategoryDetailsPage(
                catName: model.name,
                type: model.type,
                library: model.library,
              ));
        },
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: NetworkImage(model.image),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                model.name,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
