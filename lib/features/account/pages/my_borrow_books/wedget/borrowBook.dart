import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/models/old/search_model.dart';
import 'package:hti_library/features/book/view_book.dart';

import '../../../../../core/models/myBorrowBookModel.dart';
import '../../../../../core/util/constants.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/widgets/asset_svg.dart';

class BorrowBook extends StatelessWidget {
  BorrowBook({Key? key ,  this.model , this.data}) : super(key: key);
  Books? model;
  SearchData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: MediaQuery.of(context).size.width / 4.9 * 1.6 + 20,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsetsDirectional.only(
        bottom: 15.0,
        start: model == null ? 0.0 : 15.0,
        end: model == null ? 0.0 : 15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Material(
          color:MainCubit.get(context).isDark ? HexColor(secondaryColorD) : HexColor(greyWhite),
        child: InkWell(
          onTap: () {
            if (model != null)
            navigateTo(context, ViewBookPage(bookId: model!.book.id));
            if (data != null)
            navigateTo(context, ViewBookPage(bookId: data!.id));
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
                         model == null ? '${data!.bookImage}' : model!.book.bookImage),
                    height: MediaQuery.of(context).size.width / 4.9 * 1.6,
                    width: MediaQuery.of(context).size.width / 4.9,
                    fit: BoxFit.fill,
                  ),
                ),
                space20Horizontal,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space5Vertical,
                      Text(
                        model == null ? '${data!.name}' : model!.book.name,
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 2,
                      ),
                      space20Vertical,
                      Text(
                        '${appTranslation(context).author} : ${model!.book.auther[0].name}',
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 1,
                      ),
                      space10Vertical,
                      Text(
                        '${appTranslation(context).edition}  : ${model == null ? '${data!.edition}' : model!.book.edition}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      space10Vertical,
                      Text(
                        '${appTranslation(context).pagesNum} : ${model == null ? '${data!.pages}' : model!.book.pages}',
                        style: Theme.of(context).textTheme.subtitle2,
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
