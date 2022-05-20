import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/features/category_details/presentation/widgets/cat_details_item.dart';
import 'package:hti_library/features/search/presentation/search.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({
    Key? key,
    required this.catName,
    required this.type,
    required this.library,
  }) : super(key: key);
  final String catName;
  final String type;
  final String library;

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit.get(context).categoryDetails(
        categoryName: widget.catName,
        library: widget.library,
        type: widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BackScaffold(
          title: widget.catName,
          actionIcon: IconButton(
            icon: AssetSvg(
              imagePath: 'search',
              size: 18.0,
            ),
            onPressed: () {
              navigateTo(context, const SearchPage());
            },
          ),
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: MainCubit.get(context).categoryDetailsModel != null
              ? ListView.builder(
                  itemBuilder: (context, index) => CatDetailsItem(
                    model: MainCubit.get(context)
                        .categoryDetailsModel!
                        .books[index],
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      MainCubit.get(context).categoryDetailsModel!.books.length,
                )
              : const LoadingWidget(),
        );
      },
    );
  }
}
