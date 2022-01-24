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
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/core/util/widgets/see_more_item.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';
import 'package:hti_library/features/search/presentation/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                      navigateTo(context, SearchPage());
                    },
                    text: 'Search',
                    imagePath: 'search',
                  ),
                ),
                space15Vertical,
                SeeMoreItem(
                  gestureTapCallback: () {},
                  text: 'Top Borrow Books',
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(top: 5.0,bottom: 5.0,),
                  color: HexColor(greyWhite),
                  height: 286.0,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => BookItem(),
                      itemCount: 10),
                ),
                SeeMoreItem(
                  gestureTapCallback: () {},
                  text: 'Recently Returned',
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(top: 5.0,bottom: 5.0,),
                  color: HexColor(greyWhite),
                  height: 286.0,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => BookItem(),
                      itemCount: 10),
                ),
                SeeMoreItem(
                  gestureTapCallback: () {},
                  text: 'HTI Material',
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(top: 5.0,bottom: 5.0,),
                  color: HexColor(greyWhite),
                  height: 286.0,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => BookItem(),
                      itemCount: 10),
                ),
                SeeMoreItem(
                  gestureTapCallback: () {},
                  text: 'Graduation Projects',
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(top: 5.0,bottom: 5.0,),
                  color: HexColor(greyWhite),
                  height: 286.0,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => BookItem(),
                      itemCount: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
