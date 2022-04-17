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
import 'package:hti_library/features/select_type/page/selectType.dart';

class SelectLibrary extends StatelessWidget {
  const SelectLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return MainScaffold(
          scaffold: BackScaffold(
            title: 'Select Library',
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SelectLibraryItem(
                    name: 'Main Library',
                    img: 'main_library',
                    callbackHandle: (){
                      showToast(message: 'geometry library', toastStates: ToastStates.SUCCESS);
                      navigateAndFinish(context, SelectType(library: 'main library '));
                    },),
                  SelectLibraryItem(
                    name: 'S library',
                    img: 's_library',
                    callbackHandle: (){
                      showToast(message: 'business library', toastStates: ToastStates.SUCCESS);
                      navigateAndFinish(context, SelectType(library: 's library'));
                    },),
                  SelectLibraryItem(
                    name: 'M library',
                    img: 's_library',
                    callbackHandle: (){
                      showToast(message: 'computer science library', toastStates: ToastStates.SUCCESS);
                      navigateAndFinish(context, SelectType(library: 'm library '));
                    },),
                  const SizedBox(height: 40,),
                ],
              ),
            ), scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          )
      );
    });
  }
}
