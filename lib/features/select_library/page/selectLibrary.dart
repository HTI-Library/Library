import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/di/injection.dart';
import 'package:hti_library/core/network/local/cache_helper.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/home/presentation/pages/home_page.dart';
import 'package:hti_library/features/main/presentation/pages/main_page.dart';
import 'package:hti_library/features/select_library/widget/selectLibraryItem.dart';
import 'package:hti_library/features/select_type/page/selectType.dart';

class SelectLibrary extends StatefulWidget {
  const SelectLibrary({Key? key}) : super(key: key);

  @override
  State<SelectLibrary> createState() => _SelectLibraryState();
}

class _SelectLibraryState extends State<SelectLibrary> {

  @override
  void initState() {
    super.initState();
    if (token! == null) {
      navigateAndFinish(context, const HomePage());
      sl<CacheHelper>().put('type', 'programming');
      sl<CacheHelper>().put('library', 'm library ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return MainScaffold(
          scaffold: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Select Library'),
            ),
            body: BuildCondition(
              condition: MainCubit.get(context).userSigned,
              builder:(context) =>  SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SelectLibraryItem(
                      name: 'Main Library',
                      img: 'main_library',
                      callbackHandle: () {
                        showToast(
                            message: 'geometry library',
                            toastStates: ToastStates.SUCCESS);
                        navigateAndFinish(
                            context, SelectType(library: 'main library '));
                      },
                    ),
                    SelectLibraryItem(
                      name: 'S library',
                      img: 's_library',
                      callbackHandle: () {
                        showToast(
                            message: 'business library',
                            toastStates: ToastStates.SUCCESS);
                        navigateAndFinish(
                            context, SelectType(library: 's library'));
                      },
                    ),
                    SelectLibraryItem(
                      name: 'M library',
                      img: 's_library',
                      callbackHandle: () {
                        showToast(
                            message: 'computer science library',
                            toastStates: ToastStates.SUCCESS);
                        navigateAndFinish(
                            context, SelectType(library: 'm library '));
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              fallback: (context)=> const LoadingWidget(),
            ),
          ),
        );
      },
    );
  }
}
