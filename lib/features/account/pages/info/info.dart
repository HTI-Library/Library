import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/pages/info/pages/abou_us.dart';
import 'package:hti_library/features/account/pages/info/pages/policyBorrowing.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';

import 'pages/get_help.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        title: "${appTranslation(context).info}",
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              MyBtnAccount(text:'${appTranslation(context).borrowingPolicy}' ,voidCallback: (){
                  navigateTo(context, PolicyBorrowing());
              },imagePath: "",),
              space20Vertical,
              MyBtnAccount(text:'${appTranslation(context).getHelp}' ,voidCallback: (){
                navigateTo(context, GetHelpPage());


              },imagePath: "",),
              space20Vertical,
              MyBtnAccount(text:'${appTranslation(context).aboutUs}' ,voidCallback: (){
                navigateTo(context, const AboutUs());
              },imagePath: "",),
              space20Vertical,
            ],
          ),
        ),

      ),);

  }
}
