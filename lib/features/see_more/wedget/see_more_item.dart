import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/models/getAllReturnedBooks.dart';
import 'package:hti_library/core/models/top_borrow_model.dart';
import 'package:hti_library/features/book/view_book.dart';

import '../../../../core/util/constants.dart';
import '../../../../core/util/widgets/app_button.dart';
import '../../../../core/util/widgets/available_item.dart';

class SeeMoreItem extends StatelessWidget {
  SeeMoreItem({Key? key , this.simpleData , this.data}) : super(key: key);
  SimpleBook? simpleData;
  BooksReturned? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: MediaQuery.of(context).size.width / 3.9 * 1.6 + 34,
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
            navigateTo(
                context,
                ViewBookPage(
                  bookId: simpleData != null ? simpleData!.id : data!.book.id,
                ));
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
                    image: NetworkImage('${simpleData != null ? simpleData!.bookImage : data!.book.bookImage}'),
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
                        simpleData != null ? simpleData!.name : data!.book.name,
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 1,
                      ),
                      Text(
                        // '${appTranslation(context).author} : ${simpleData.authors[0].authorName}',
                        '${appTranslation(context).author}',
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 1,
                      ),
                      Text(
                        'Edition : ${simpleData != null ? simpleData!.edition[0] : data!.book.edition[0]}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        '${appTranslation(context).pagesNum} : ${simpleData != null ? simpleData!.pages : data!.book.pages}',
                        // '${appTranslation(context).pagesNum} : ',
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
                            amount: 2,
                            // amount: model.amount.toInt(),
                          ),
                        ],
                      ),
                      space10Vertical,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppButton(
                              height: 35.0,
                              label: appTranslation(context).borrow,
                              onPress: () {},
                            ),
                          ),
                          space10Horizontal,
                          Expanded(
                            child: AppButton(
                                height: 35.0,
                                color: HexColor(greyWhite),
                                label: appTranslation(context).read,
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
