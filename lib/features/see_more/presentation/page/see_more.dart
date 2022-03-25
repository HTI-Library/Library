import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/models/top_borrow_model.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/features/category_details/presentation/widgets/cat_details_item.dart';
import 'package:hti_library/features/search/presentation/search.dart';
import 'package:hti_library/features/see_more/wedget/see_more_item.dart';

import '../../../../core/util/constants.dart';
import '../../../../core/util/widgets/app_button.dart';
import '../../../../core/util/widgets/asset_svg.dart';
import '../../../../core/util/widgets/available_item.dart';
import '../../../book/view_book.dart';

class SeeMore extends StatefulWidget {
  SeeMore({
    Key? key,
    this.model,
  }) : super(key: key);
  TopBorrowModel? model;

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit.get(context).categoryDetails(
        categoryName: widget.model!.books[0].name,
        library: widget.model!.books[0].library,
        type: widget.model!.books[0].type);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BackScaffold(
          title: widget.model!.books[0].library,
          actionIcon: IconButton(
            icon: AssetSvg(
              imagePath: 'search',
              size: 18.0,
            ),
            onPressed: () {
              navigateTo(
                  context,
                  SearchPage(
                    model: MainCubit.get(context).lastSearchModel!,
                  ));
            },
          ),
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: MainCubit.get(context).categoryDetailsModel != null
              ? ListView.builder(
                  itemBuilder: (context, index) => SeeMoreItem(
                    model: widget.model!.books[index],
                  ),
                    //   CatDetailsItem(
                    // model: MainCubit.get(context)
                    //     .categoryDetailsModel!
                    //     .books[index],
                  // ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.model!.books.length,
                )
              : const LoadingWidget(),
        );
      },
    );
  }
}
