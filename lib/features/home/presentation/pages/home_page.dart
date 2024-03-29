import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/keep_alive_widget.dart';
import 'package:hti_library/core/util/widgets/book_item.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/core/util/widgets/see_more_item.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';
import 'package:hti_library/features/search/presentation/search.dart';
import 'package:hti_library/features/see_more/presentation/page/see_more.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MainCubit cubit;
  CarouselController controlledSlider = CarouselController();
  PageController pageController = PageController();
  int num = 0;

  List<String> list = [
    'assets/images/libm.jpg',
    'assets/images/main_library.jpg',
    'assets/images/m-lib.jpg',
    'assets/images/s_library.jpg',
  ];

  @override
  void initState() {
    super.initState();
    cubit = context.read<MainCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return KeepAliveWidget(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MyBtnAccount(
                    voidCallback: () {
                      navigateTo(
                        context,
                        const SearchPage(),
                      );
                    },
                    text: appTranslation(context).search,
                    imagePath: 'search',
                  ),
                ),
                space15Vertical,
                CarouselSlider(
                  carouselController: controlledSlider,
                  items: list
                      .map(
                        (e) => ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image(
                            image: AssetImage('${e}'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4.2,
                    initialPage: 1,
                    viewportFraction: .85,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        num = index;
                      });
                    },
                    reverse: false,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(seconds: 3),
                    autoPlayCurve: Curves.linearToEaseOut,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                space10Vertical,
                AnimatedSmoothIndicator(activeIndex: num, count: list.length),
                space15Vertical,
                SeeMoreItem(
                  gestureTapCallback: () {
                    navigateTo(
                        context,
                        SeeMore(
                          title: "Top Borrow Books",
                          model: MainCubit.get(context).topBorrowModel!,
                          loadMorePressed: () {
                            MainCubit.get(context).topBorrow(
                              isFirst: false,
                            );
                          },
                        ));
                  },
                  text: appTranslation(context).topBorrowBooks,
                ),

                // if (MainCubit.get(context).allReturnedBook != null && MainCubit.get(context).allReturnedBook!.books.isNotEmpty)
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  color: MainCubit.get(context).isDark
                      ? HexColor(secondaryColorD)
                      : HexColor(greyWhite),
                  height: MediaQuery.of(context).size.width / 3.2 * 2.2,
                  child: MainCubit.get(context).topBorrowModel != null
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => BookItem(
                                book: MainCubit.get(context)
                                    .topBorrowModel!
                                    .books[index],
                              ),
                          itemCount: MainCubit.get(context)
                              .topBorrowModel!
                              .books
                              .length)
                      : const LoadingWidget(),
                ),
                if (MainCubit.get(context).allReturnedBook != null && MainCubit.get(context).allReturnedBook!.books.isNotEmpty)
                SeeMoreItem(
                  gestureTapCallback: () {
                    navigateTo(
                        context,
                        SeeMore(
                          title: appTranslation(context).recentlyReturned,
                          data: MainCubit.get(context).allReturnedBook!,
                          loadMorePressed: () {
                            MainCubit.get(context).getAllReturned(
                              isFirst: false,
                            );
                          },
                        ));
                  },
                  text: appTranslation(context).recentlyReturned,
                ),
                if (MainCubit.get(context).allReturnedBook != null &&
                    MainCubit.get(context).allReturnedBook!.books.isNotEmpty)
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    color: MainCubit.get(context).isDark
                        ? HexColor(secondaryColorD)
                        : HexColor(greyWhite),
                    height: MediaQuery.of(context).size.width / 3.2 * 2.2,
                    child: MainCubit.get(context).allReturnedBook != null
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => BookItem(
                                  returned: MainCubit.get(context)
                                      .allReturnedBook!
                                      .books[index],
                                ),
                            itemCount: MainCubit.get(context)
                                .allReturnedBook!
                                .books
                                .length)
                        : const LoadingWidget(),
                  ),
                if (cubit.categoryDetailsModelHti != null &&
                    cubit.categoryDetailsModelHti!.books.isNotEmpty)
                  SeeMoreItem(
                    gestureTapCallback: () {
                      navigateTo(
                          context,
                          SeeMore(
                            title: "HTI Materials",
                            model:
                                MainCubit.get(context).categoryDetailsModelHti,
                            loadMorePressed: () {
                              // todo  HTI
                            },
                          ));
                    },
                    text: appTranslation(context).htiMaterial,
                  ),
                if (cubit.categoryDetailsModelHti != null &&
                    cubit.categoryDetailsModelHti!.books.isNotEmpty)
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    color: MainCubit.get(context).isDark
                        ? HexColor(secondaryColorD)
                        : HexColor(greyWhite),
                    height: MediaQuery.of(context).size.width / 3.2 * 2.2,
                    child:
                        MainCubit.get(context).categoryDetailsModelHti != null
                            ? ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => BookItem(
                                      book: MainCubit.get(context)
                                          .categoryDetailsModelHti!
                                          .books[index],
                                    ),
                                itemCount: MainCubit.get(context)
                                    .categoryDetailsModelHti!
                                    .books
                                    .length)
                            : const LoadingWidget(),
                  ),
                if (cubit.categoriesModelProject != null &&
                    cubit.categoriesModelProject!.books.isNotEmpty)
                  SeeMoreItem(
                    gestureTapCallback: () {
                      navigateTo(
                          context,
                          SeeMore(
                            title: "graduation Projects",
                            model:
                                MainCubit.get(context).categoriesModelProject,
                            loadMorePressed: () {
                              // todo  graduation Projects
                            },
                          ));
                    },
                    text: appTranslation(context).graduationProjects,
                  ),
                if (cubit.categoriesModelProject != null &&
                    cubit.categoriesModelProject!.books.isNotEmpty)
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    color: MainCubit.get(context).isDark
                        ? HexColor(secondaryColorD)
                        : HexColor(greyWhite),
                    height: MediaQuery.of(context).size.width / 3.2 * 2.2,
                    child: MainCubit.get(context).categoriesModelProject != null
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => BookItem(
                                  book: MainCubit.get(context)
                                      .categoriesModelProject!
                                      .books[index],
                                ),
                            itemCount: MainCubit.get(context)
                                .categoriesModelProject!
                                .books
                                .length)
                        : const LoadingWidget(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
