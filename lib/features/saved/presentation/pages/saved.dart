import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/core/util/widgets/not_login.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/core/util/widgets/not_login.dart';
import 'package:hti_library/features/no_save/no_save.dart';
import 'package:hti_library/features/saved/presentation/widgets/saved_details_item.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return BuildCondition(
        condition: MainCubit.get(context).userSigned,
        builder: (context) => BuildCondition(
          condition: MainCubit.get(context).savedBooksModel != null,
          builder: (context) =>
              MainCubit.get(context).savedBooksModel!.books!.isNotEmpty
                  ? Column(
                      children: [
                        if (state is RemoveSavedBooksLoading)
                          const LinearProgressIndicator(),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => SavedItem(
                                model: MainCubit.get(context)
                                    .savedBooksModel!
                                    .books![index]),
                            physics: const BouncingScrollPhysics(),
                            itemCount: MainCubit.get(context)
                                .savedBooksModel!
                                .books!
                                .length,
                          ),
                        ),
                      ],
                    )
                  : const NoSavedPage(),
          fallback: (context) => const LoadingWidget(),
        ),
        fallback: (context) => const NotLogin(),
      );
    });
  }
}
