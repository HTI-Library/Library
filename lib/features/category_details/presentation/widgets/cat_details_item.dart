import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/available_item.dart';
import 'package:hti_library/features/book/view_book.dart';

class CatDetailsItem extends StatelessWidget {
  const CatDetailsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: MediaQuery.of(context).size.width / 3.9 * 1.6 + 20,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsetsDirectional.only(
        bottom: 15.0,
        start: 15.0,
        end: 15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Material(
        color: HexColor(greyWhite),
        child: InkWell(
          onTap: () {
            navigateTo(context, ViewBookPage());
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image(
                    image: const NetworkImage(
                        'https://edit.org/images/cat/book-covers-big-2019101610.jpg'),
                    height: MediaQuery.of(context).size.width / 3.9 * 1.6,
                    width: MediaQuery.of(context).size.width / 3.9,
                    fit: BoxFit.fill,
                  ),
                ),
                space10Horizontal,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Python Programming dddddd ddddddf',
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 1,
                      ),
                      Text(
                        'Author : Franklin',
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 1,
                      ),
                      Text(
                        '3th Edition',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        '205, Pages',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const Divider(),
                      Row(
                        children: [
                          RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 16.0,
                              itemBuilder: (context, _) => const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                  ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              }),
                          const Spacer(),
                          AvailableItem(
                            fontSize: 14.0,
                            label: 'Available',
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppButton(
                              height: 36.0,
                              label: 'Borrow',
                              onPress: () {},
                            ),
                          ),
                          space10Horizontal,
                          Expanded(
                            child: AppButton(
                                height: 36.0,
                                color: HexColor(greyWhite),
                                label: 'Read',
                                textColor: HexColor(mainColor),
                                onPress: () {}),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
