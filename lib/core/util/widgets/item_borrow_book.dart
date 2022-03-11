import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';

import '../constants.dart';

class ItemBorrowBook extends StatelessWidget {
  const ItemBorrowBook({Key? key}) : super(key: key);
  final String txt = "The Book is The green book ";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: FractionallySizedBox(
            heightFactor: 0.2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: HexColor(greyWhite),
              ),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'name : ${txt.length > 15 ? txt.substring(0, 15)+'...' : txt}',
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Author : ',
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 2,
                      ),
                      Text(
                        'Date of Recently :',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        'Date of returned : ',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        'book Number : ',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            right: 30,
            child:
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network('https://edit.org/images/cat/book-covers-big-2019101610.jpg',
                    fit: BoxFit.cover , height: 120 , width: 80,),// Image border
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 5),
                  child: Row(
                    children: [
                      Text(
                        '2.5',
                        maxLines: 2,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      space5Horizontal,
                      AssetSvg(
                        imagePath: 'star',
                        color: starColor,
                        size: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),

      ],
    );
  }
}
