import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/features/search/widget/btn_my_account.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/core/util/widgets/my_button.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: 'Account',
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Image.asset('assets/images/hti_logo.png'),
                radius: 55,
              ),
              space20Vertical,
              MyBtnAccount(voidCallback: () {}, text: 'My Profile', imagePath: 'user_user_circle',),
              space10Vertical,
              MyBtnAccount(voidCallback: () {}, text: 'My Message', imagePath: 'message_account',),
              space10Vertical,
              MyBtnAccount(voidCallback: () {}, text: 'My Bookmark', imagePath: 'pop_mark',),
              space10Vertical,
              MyBtnAccount(voidCallback: () {}, text: 'Calender', imagePath: 'calendar',),
              space10Vertical,
              MyBtnAccount(voidCallback: () {}, text: 'Setting', imagePath: 'settings',),
              space10Vertical,
              MyBtnAccount(voidCallback: () {}, text: 'Info', imagePath: 'info',),
              space10Vertical,
              MyBtnAccount(voidCallback: () {}, text: 'Log Out', imagePath: 'sign_out',),
              space10Vertical,

            ],
          ),
        ),
      ),
    );
  }
}
