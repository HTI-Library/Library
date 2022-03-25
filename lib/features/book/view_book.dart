import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/available_item.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/book_item.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/core/util/widgets/see_more_item.dart';
import 'package:hti_library/features/borrowing/presentation/pages/borrowing_page.dart';
import 'package:hti_library/features/see_more/presentation/page/see_more.dart';

class ViewBookPage extends StatefulWidget {
  const ViewBookPage({Key? key, required this.bookId}) : super(key: key);
  final String bookId;

  @override
  State<ViewBookPage> createState() => _ViewBookPageState();
}

class _ViewBookPageState extends State<ViewBookPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit.get(context).bookDetails(bookId: widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is PostSavedBooksSuccess) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return BackScaffold(
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actionIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    MainCubit.get(context).postSaveBook(bookID: widget.bookId);
                  },
                  icon: AssetSvg(
                    imagePath: 'save_soled',
                    size: 20.0,
                    color: HexColor(mainColor),
                  ),
                  // icon: Icon(
                  //   Icons.bookmark_border_rounded,
                  //   color: HexColor(mainColor),
                  // ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share_rounded,
                    color: HexColor(mainColor),
                  ),
                )
              ],
            ),
          ),
          body: BuildCondition(
            condition: MainCubit.get(context).bookModel != null,
            builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (state is PostSavedBooksLoading)
                      const LinearProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.width / 2.7 * 1.6,
                              width: MediaQuery.of(context).size.width / 2.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    MainCubit.get(context)
                                        .bookModel!
                                        .book
                                        .bookImage,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          space20Vertical,
                          Text(
                            MainCubit.get(context).bookModel!.book.name,
                            style: Theme.of(context).textTheme.subtitle2!,
                          ),
                          space3Vertical,
                          Text(
                            '${appTranslation(context).author} : ${MainCubit.get(context).bookModel!.book.authors[0].authorName}',
                            style: Theme.of(context).textTheme.subtitle2!,
                          ),
                          space3Vertical,
                          Text(
                            '${appTranslation(context).edition} : ${MainCubit.get(context).bookModel!.book.edition}',
                            style: Theme.of(context).textTheme.subtitle2!,
                          ),
                          space3Vertical,
                          Text(
                            '${appTranslation(context).pagesNum} : ${MainCubit.get(context).bookModel!.book.pages}',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          space8Vertical,
                          Row(
                            children: [
                              AvailableItem(
                                amount: MainCubit.get(context)
                                    .bookModel!
                                    .book
                                    .amount
                                    .toInt(),
                              ),
                              const Spacer(),
                              RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: MainCubit.get(context)
                                      .bookModel!
                                      .book
                                      .rate
                                      .toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 25,
                                  itemBuilder: (context, _) => const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  }),
                            ],
                          ),
                          space10Vertical,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AppButton(
                                    label: '${appTranslation(context).borrow}',
                                    onPress: () {
                                      navigateTo(context, BorrowingPage(
                                        book_id: MainCubit.get(context)
                                            .bookModel!
                                            .book
                                            .id,
                                      ));
                                    }),
                              ),
                              space10Horizontal,
                              Expanded(
                                child: AppButton(
                                    color: HexColor(greyWhite),
                                    label: '${appTranslation(context).read}',
                                    textColor: HexColor(mainColor),
                                    onPress: () {}),
                              ),
                            ],
                          ),
                          space15Vertical,
                          Text(
                            '${appTranslation(context).overview}.',
                            style: Theme.of(context).textTheme.headline6!,
                          ),
                          space5Vertical,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor(greyWhite),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                MainCubit.get(context).bookModel!.book.overview,
                                maxLines: 8,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (MainCubit.get(context)
                        .bookModel!
                        .sameEdition
                        .isNotEmpty)
                      SeeMoreItem(
                        padding: 15,
                        gestureTapCallback: () {},
                        text: 'More Edition of this book',
                      ),
                    if (MainCubit.get(context)
                        .bookModel!
                        .sameEdition
                        .isNotEmpty)
                      Container(
                        padding: const EdgeInsetsDirectional.only(
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        color: HexColor(greyWhite),
                        height: MediaQuery.of(context).size.width / 3.2 * 2.2,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => BookItem(
                                  book: MainCubit.get(context)
                                      .bookModel!
                                      .sameEdition[index],
                                ),
                            itemCount: MainCubit.get(context)
                                .bookModel!
                                .sameEdition
                                .length),
                      ),
                    if (MainCubit.get(context)
                        .bookModel!
                        .sameCategory
                        .isNotEmpty)
                      SeeMoreItem(
                        padding: 15,
                        gestureTapCallback: () {
                          navigateTo(context, SeeMore(
                            model: MainCubit.get(context).topBorrowModel,
                          ));
                        },
                        text: 'More books from the same category',
                      ),
                    if (MainCubit.get(context)
                        .bookModel!
                        .sameCategory
                        .isNotEmpty)
                      Container(
                        padding: const EdgeInsetsDirectional.only(
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        color: HexColor(greyWhite),
                        height: MediaQuery.of(context).size.width / 3.2 * 2.2,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => BookItem(
                                  book: MainCubit.get(context)
                                      .bookModel!
                                      .sameCategory[index],
                                ),
                            itemCount: MainCubit.get(context)
                                .bookModel!
                                .sameCategory
                                .length),
                      ),
                    if (MainCubit.get(context).bookModel!.sameAuthor.isNotEmpty)
                      SeeMoreItem(
                        padding: 15,
                        gestureTapCallback: () {},
                        text: 'More books from the same author',
                      ),
                    if (MainCubit.get(context).bookModel!.sameAuthor.isNotEmpty)
                      Container(
                        padding: const EdgeInsetsDirectional.only(
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        color: HexColor(greyWhite),
                        height: MediaQuery.of(context).size.width / 3.2 * 2.2,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => BookItem(
                                  book: MainCubit.get(context)
                                      .bookModel!
                                      .sameAuthor[index],
                                ),
                            itemCount: MainCubit.get(context)
                                .bookModel!
                                .sameAuthor
                                .length),
                      ),
                  ],
                )),
            fallback: (context) => const LoadingWidget(),
          ),
        );
      },
    );
  }
}
