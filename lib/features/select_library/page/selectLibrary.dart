import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/di/injection.dart';
import 'package:hti_library/core/network/local/cache_helper.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/main/presentation/pages/main_page.dart';
import 'package:hti_library/features/select_library/widget/selectLibraryItem.dart';

class SelectLibrary extends StatelessWidget {
  const SelectLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return MainScaffold(
          scaffold: BackScaffold(
            title: 'Select Library',
            body: Column(
              children: [
                SelectLibraryItem(
                  name: 'Main Library',
                  img: 'main_library',
                  callbackHandle: (){
                    sl<CacheHelper>().put(library!, "main library");
                    showToast(message: 'المكتبة الرئيسيه يابا', toastStates: ToastStates.SUCCESS);
                    navigateAndFinish(context, MainPage());
                  },),
                SelectLibraryItem(
                  name: 'S library',
                  img: 's_library',
                  callbackHandle: (){
                    sl<CacheHelper>().put(library!, "s library");
                    showToast(message: 'المكتبة بتاعت اداره يابا', toastStates: ToastStates.SUCCESS);
                    navigateAndFinish(context, MainPage());
                  },),
                SelectLibraryItem(
                  name: 'M library',
                  img: 's_library',
                  callbackHandle: (){
                    sl<CacheHelper>().put(library!, "m library");
                    showToast(message: 'المكتبة بتاعت العباقره يابا', toastStates: ToastStates.SUCCESS);
                    navigateAndFinish(context, MainPage());
                  },),
              ],
            ), scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          )
      );
    });
  }
}
