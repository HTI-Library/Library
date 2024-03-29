import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/keep_alive_widget.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';
import 'package:hti_library/features/categories/presentation/widgets/cat_item.dart';
import 'package:hti_library/features/categories/presentation/widgets/custom_delegate.dart';
import 'package:hti_library/features/search/presentation/search.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return KeepAliveWidget(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: MyBtnAccount(
                      voidCallback: () {
                        navigateTo(context, const SearchPage());
                      },
                      text: '${appTranslation(context).search}',
                      imagePath: 'search',
                    ),
                  ),
                  space15Vertical,
                  BuildCondition(
                    condition: MainCubit.get(context).categoriesModel != null,
                    builder:(context)=> GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 2,
                        // mainAxisSpacing: 10.0,
                        crossAxisSpacing: 5.0,
                        height: MediaQuery.of(context).size.width / 1.8,
                      ),
                      itemCount: MainCubit.get(context)
                          .categoriesModel!
                          .categories.length,
                      itemBuilder: (context, index) => CatItem(
                        model: MainCubit.get(context)
                            .categoriesModel!
                            .categories[index],
                      ),
                    ),
                    fallback: (context)=> const LoadingWidget(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
