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
import 'package:hti_library/features/main/presentation/pages/main_page.dart';
import 'package:hti_library/features/select_library/page/selectLibrary.dart';
import 'package:hti_library/features/select_library/widget/selectLibraryItem.dart';

class SelectType extends StatefulWidget {
  SelectType({Key? key , required this.library}) : super(key: key);
  String library;

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {

  @override
  void initState() {
    super.initState();
    MainCubit.get(context).getAllType(
      page: 1,
      library: widget.library,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          navigateAndFinish(context, const SelectLibrary());
          return true;
        },
        child: MainScaffold(
            scaffold: BackScaffold(
              title: 'Select Type',
              scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: MainCubit.get(context).allTypeModel != null ? ListView.builder(
                  itemBuilder:
                      (context, index) =>
                          SelectLibraryItem(
                      img: MainCubit.get(context).allTypeModel!.types[index].image,
                      name: MainCubit.get(context).allTypeModel!.types[index].name,
                      callbackHandle: (){
                        showToast(message: MainCubit.get(context).allTypeModel!.types[index].name, toastStates: ToastStates.SUCCESS);
                        sl<CacheHelper>().put('library', widget.library);
                        sl<CacheHelper>().put('type', MainCubit.get(context).allTypeModel!.types[index].name);
                        navigateAndFinish(context, MainPage(library: widget.library,type: MainCubit.get(context).allTypeModel!.types[index].name,));
                      }
                  ) ,
                  itemCount: MainCubit.get(context).allTypeModel!.types.length,
                  physics: const BouncingScrollPhysics()
              ) : const LoadingWidget(),

            )
        ),
      );
    });
  }
}
