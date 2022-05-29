import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/di/injection.dart';
import 'package:hti_library/core/network/local/cache_helper.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MainCubit cubit;
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
                SeeMoreItem(
                  gestureTapCallback: () {
                    navigateTo(
                        context,
                        SeeMore(
                          title: "Top Borrow Books",
                          model: MainCubit.get(context).topBorrowModel!,
                        ));
                  },
                  text: appTranslation(context).topBorrowBooks,
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  color: HexColor(greyWhite),
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
                SeeMoreItem(
                  gestureTapCallback: () {
                    navigateTo(
                        context,
                        SeeMore(
                          title: "Recently Returned",
                          data: MainCubit.get(context).allReturnedBook!,
                        ));
                  },
                  text: appTranslation(context).recentlyReturned,
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  color: HexColor(greyWhite),
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
                SeeMoreItem(
                  gestureTapCallback: () {
                    navigateTo(
                        context,
                        SeeMore(
                          title: "HTI Materials",
                          model: MainCubit.get(context).categoryDetailsModelHti,
                        ));
                  },
                  text: appTranslation(context).htiMaterial,
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  color: HexColor(greyWhite),
                  height: MediaQuery.of(context).size.width / 3.2 * 2.2,
                  child: MainCubit.get(context).categoryDetailsModelHti != null
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
                SeeMoreItem(
                  gestureTapCallback: () {
                    navigateTo(
                        context,
                        SeeMore(
                          title: "graduation Projects",
                          model: MainCubit.get(context).categoriesModelProject,
                        ));
                  },
                  text: appTranslation(context).graduationProjects,
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  color: HexColor(greyWhite),
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
  }}
