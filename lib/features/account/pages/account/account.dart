import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/pages/info/info.dart';
import 'package:hti_library/features/account/pages/message/message.dart';
import 'package:hti_library/features/account/pages/notificatio/notificatio.dart';
import 'package:hti_library/features/account/pages/setting/presntation/setting.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';
import 'package:hti_library/features/change_new_photo/presintation/page/change_new_photo.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  var _width = 230.0;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: Scaffold(
        // appBar: AppBar(
        //   title: Text("Account",style:
        //  Theme.of(context).textTheme .headline4!.copyWith(color: HexColor(mainColor),fontSize: 18,)),
        //
        //   centerTitle: true,
        //   backgroundColor:Theme.of(context) .scaffoldBackgroundColor,
        // ),
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
              Text('Htian Here',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: HexColor(mainColor),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
              space20Vertical,
              MyBtnAccount(
                voidCallback: () {
                  navigateTo(context, ChangeNewPhoto());
                },
                text: 'My Profile',
                imagePath: 'user_user_circle',
              ),

              space10Vertical,
              MyBtnAccount(
                voidCallback: () {
                  navigateTo(context, NotificatioPage());
                },
                text: 'Notification',
                imagePath: 'notification_notification_outline',
              ),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {
                  navigateTo(context, MessagePage());
                },
                text: 'My Message',
                imagePath: 'message_account',
              ),
              // space10Vertical,
              // MyBtnAccount(
              //   voidCallback: () {
              //     navigateTo(context, NoBookmarkPage());
              //   },
              //   text: 'My Bookmark',
              //   imagePath: 'pop_mark',
              // ),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {
                  // navigateTo(context, CalenderPage());
                  showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      builder: (context) {
                        return Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: MediaQuery.of(context).size.height / 1.3,
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: MainCubit.get(context).isDark
                                ? HexColor(secondBackground)
                                : HexColor(surface),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/4,
                                height: 5.0,
                                margin: const EdgeInsetsDirectional.only(bottom: 10.0,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: HexColor(mainColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                text: 'calender',
                imagePath: 'calendar',
              ),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {
                  navigateTo(context, SettingPages());
                },
                text: 'Setting',
                imagePath: 'settings',
              ),
              space10Vertical,

              MyBtnAccount(
                voidCallback: () {
                  navigateTo(context, InfoPage());
                },
                text: 'Info',
                imagePath: 'info',
              ),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {
                  AwesomeDialog(
                    dialogBorderRadius: BorderRadius.circular(10.0),
                    buttonsBorderRadius: BorderRadius.circular(10.0),
                    context: context,
                    keyboardAware: false,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: true,
                    dialogType: DialogType.WARNING,
                    animType: AnimType.BOTTOMSLIDE,
                    btnCancelText: "Cancel",
                    btnOkText: "Yes",
                    title: 'log out ',
                    // padding: const EdgeInsets.all(5.0),
                    desc: 'Do you want to log out ?',
                    btnCancelOnPress: () {
                      print('Yes');
                    },
                    btnOkOnPress: () {
                      print('No');
                    },
                  ).show();
                },
                text: 'Log Out',
                imagePath: 'sign_out',
              ),
              space10Vertical,
            ],
          ),
        ),
      ),
    );
  }
}
