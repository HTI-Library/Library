import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  // bool isDark = false;
  // void changeMode({bool? fromShared}) {
  //   if(fromShared != null) {
  //     isDark = fromShared;
  //     emit(ChangeModeThemeApp());
  //   } else {
  //     isDark = !isDark;
  //     CashHelper.putBoolean(key: 'dark' , value: isDark ).
  //     then((value) {
  //       emit(ChangeModeThemeApp());
  //
  //     });
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        scaffoldBackgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        title: 'Language',
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              space20Vertical,
              MyBtnAccount(voidCallback: () {},
                text: 'Arabic',
                imagePath: '',),
              space10Vertical,
              MyBtnAccount(voidCallback: () {},
                text: 'English', imagePath: '',),
            ],
          ),
        ),
      ),
    );
  }
}
