import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/models/getAllReturnedBooks.dart';
import 'package:hti_library/core/models/top_borrow_model.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/features/search/presentation/search.dart';
import 'package:hti_library/features/see_more/wedget/see_more_item.dart';

import '../../../../core/util/constants.dart';
import '../../../../core/util/widgets/asset_svg.dart';

class SeeMore extends StatefulWidget {
  SeeMore({
    Key? key,
    required this.title,
    required this.loadMorePressed,
    this.model,
    this.data,
  }) : super(key: key);
  TopBorrowModel? model;
  GetAllReturnedBooks? data;
  final String title;
  final VoidCallback loadMorePressed;

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      MainCubit.get(context).topBorrow(isFirst: true, model: widget.model);
    } else {
      MainCubit.get(context).getAllReturned(isFirst: true, data: widget.data);
    }
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
                const SearchPage(),
              );
            },
          ),
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              Expanded(
                child: BlocBuilder<MainCubit, MainState>(
                  buildWhen: (previous, current) => current is TopBorrowSuccess,
                  builder: (context, state) {
                    return ListView.builder(
                      itemBuilder: (context, index) => widget.model != null
                          ? SeeMoreItem(
                              simpleData:
                                  MainCubit.get(context).paginationBooks[index],
                            )
                          : SeeMoreItem(
                              data:
                                  MainCubit.get(context).paginationBooks[index],
                            ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: MainCubit.get(context).paginationBooks.length,
                    );
                  },
                ),
              ),
              Container(
                height: 50.0,
                color: Colors.transparent.withOpacity(.01),
                margin: const EdgeInsetsDirectional.only(
                    bottom: 15.0, end: 15.0, start: 15.0),
                child: state is SetPaginationLoading
                    ? const LoadingWidget()
                    : AppButton(
                        label: 'Load More',
                        height: 50,
                        onPress: () {
                          widget.loadMorePressed();
                        }),
              ),
            ],
          ),
        );
      },
    );
  }
}
