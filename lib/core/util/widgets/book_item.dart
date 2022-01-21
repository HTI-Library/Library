import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';
import 'asset_svg.dart';
import 'available_item.dart';

class BookItem extends StatelessWidget {
  const BookItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: 171.0,
      margin: const EdgeInsetsDirectional.only(
        start: 15.0,
      ),
      height: 314.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: HexColor(greyWhite),
      ),
      child: Material(
        color: HexColor(greyWhite),
        child: InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(
              15.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Image(
                    image: NetworkImage(
                        'https://edit.org/images/cat/book-covers-big-2019101610.jpg'),
                    height: 225.0,
                    width: 141.0,
                    fit: BoxFit.fill,
                  ),
                ),
                space5Vertical,
                Text(
                  'My Book Name',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  'My Book Author',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                ),
                space5Vertical,
                Row(
                  children: [
                    Text(
                      '4.5',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    space5Horizontal,
                    AssetSvg(
                      imagePath: 'star',
                      color: starColor,
                      size: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: CircleAvatar(
                        radius: 2.0,
                        backgroundColor: HexColor(mainColor),
                      ),
                    ),
                    const AvailableItem(label: 'Available',),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
