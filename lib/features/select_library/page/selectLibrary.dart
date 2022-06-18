import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
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
          scaffold: BackScaffold(
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,title: appTranslation(context).selectLibrary,
            body: BuildCondition(
              condition: MainCubit.get(context).userSigned,
              builder:(context) =>  SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SelectLibraryItem(
                      type: 1,
                      name: 'Main Library',
                      img: 'main_library',
                      color:HexColor('1b9aaa').withOpacity(0.8),
                      callbackHandle: () {
                        showToast(
                            message: 'geometry library',
                            toastStates: ToastStates.SUCCESS);
                        navigateAndFinish(
                            context, SelectType(library: 'main library '));
                      },
                    ),
                    SelectLibraryItem(
                      type: 1,
                      color:HexColor('50723c').withOpacity(0.8),
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
                      type: 1,
                      color:HexColor('ff934f').withOpacity(0.8),
                      name: 'M library',
                      img: 'm-lib',
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
