import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
      title: "My Profile",
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
           children: [
             MyBtnAccount(text:'Picture' ,voidCallback: (){},imagePath: "face",),
             space20Vertical,
             MyBtnAccount(text:'Saved' ,voidCallback: (){},imagePath: "save_soled",),
             space20Vertical,

           ],
        ),
      ),

    ),);
  }
}
