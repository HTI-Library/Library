import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        title: "Info",
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              MyBtnAccount(text:'Privacy @ Data' ,voidCallback: (){},imagePath: "",),
              space20Vertical,
              MyBtnAccount(text:'Get Help' ,voidCallback: (){},imagePath: "",),
              space20Vertical,
              MyBtnAccount(text:'About Us' ,voidCallback: (){},imagePath: "",),
              space20Vertical,
            ],
          ),
        ),

      ),);

  }
}
