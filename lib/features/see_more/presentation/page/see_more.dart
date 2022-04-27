import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/models/getAllReturnedBooks.dart';
import 'package:hti_library/core/models/top_borrow_model.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/book_item.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/features/search/presentation/search.dart';
import 'package:hti_library/features/see_more/wedget/see_more_item.dart';

import '../../../../core/util/constants.dart';
import '../../../../core/util/widgets/asset_svg.dart';

class SeeMore extends StatefulWidget {
  SeeMore({
    Key? key,
    required this.title,
    this.model,
    this.data,

  }) : super(key: key);
  TopBorrowModel? model;
  GetAllReturnedBooks? data;
  final String title;

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit.get(context).categoryDetails(
        categoryName: widget.model == null ? widget.data!.books[0].book.name : widget.model!.books[0].name,
        library: widget.model == null ? widget.data!.books[0].book.library : widget.model!.books[0].library,
        type: widget.model == null ? widget.data!.books[0].book.type : widget.model!.books[0].type);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BackScaffold(
          title: widget.title,
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
                  itemBuilder: (context, index) =>
                  widget.model != null ?
                      SeeMoreItem(
                          simpleData: widget.model!.books[index],) :
                  SeeMoreItem(
                    data: widget.data!.books[index],),
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.model != null ? widget.model!.books.length : widget.data!.books.length,
                )
              : const LoadingWidget(),
        );
      },
    );
  }
}
