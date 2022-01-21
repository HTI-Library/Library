import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/pages/setting/presntation/setting.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Account",style:
        Theme.of(context).textTheme .headline4!.copyWith(color: HexColor(mainColor),fontSize: 18,)),

         centerTitle: true,
         backgroundColor:Theme.of(context) .scaffoldBackgroundColor,
       ),
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
              Text('Htian Here', style:
              Theme.of(context).textTheme .headline4!.copyWith(color: HexColor(mainColor),fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
              space20Vertical,
              MyBtnAccount(voidCallback: () {},
                text: 'My Profile',
                imagePath: 'user_user_circle',),
              space10Vertical,
              MyBtnAccount(voidCallback: () {},
                text: 'My Message',
                imagePath: 'message_account',),
              space10Vertical,
              MyBtnAccount(voidCallback: () {},
                text: 'My Bookmark',
                imagePath: 'pop_mark',),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {}, text: 'Calender', imagePath: 'calendar',),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {
                  navigateTo(context, SettingPages());
                }, text: 'Setting', imagePath: 'settings',),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {}, text: 'Info', imagePath: 'info',),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {}, text: 'Log Out', imagePath: 'sign_out',),
              space10Vertical,

            ],
          ),
        ),
      );
  }
}
