import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/models/get_saved_books_model.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/available_item.dart';
import 'package:hti_library/features/book/view_book.dart';

class SavedItem extends StatelessWidget {

  const SavedItem({Key? key , required this.model}) : super(key: key);
  final BookSavedData model;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: MediaQuery.of(context).size.width / 4.9 * 1.6 + 20,
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
          color:MainCubit.get(context).isDark?HexColor(secondaryColorD):HexColor(greyWhite),
        child: InkWell(
          onTap: () {
           navigateTo(context, ViewBookPage(bookId: model.id,));
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
                    image: NetworkImage(
                        model.bookImage),
                    height: MediaQuery.of(context).size.width / 4.9 * 1.6,
                    width: MediaQuery.of(context).size.width / 4.9,
                    fit: BoxFit.fill,
                  ),
                ),
                space10Horizontal,
                Expanded(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space10Vertical,

                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 2,
                      ),
                      space10Vertical,
                      Text(
                        '${appTranslation(context).author}   : ${model.author[0].authorName}',
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 2,
                      ),
                      space10Vertical,
                      Text(
                        '${appTranslation(context).edition}  : ${model.edition}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      space10Vertical,
                      Text(
                        '${appTranslation(context).pagesNum} : ${model.pages}',
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Material(
                        color:  HexColor(greyWhite),
                        child: InkWell(
                          onTap: (){
                            MainCubit.get(context).postRemoveBookSave(bookID: model.id);
                          },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AssetSvg(
                          imagePath: 'save_soled',
                          color: HexColor(mainColor),
                        ),
                            )),
                      ),
                    ),
                    const Spacer(),
                    AvailableItem(
                      amount: 1,
                    ),
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
