import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/pages/language/presentation/language.dart';
import 'package:hti_library/features/account/pages/notificatio/notificatio.dart';
import 'package:hti_library/features/account/pages/themes/themes.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';

class SettingPages extends StatelessWidget {
  const SettingPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: 'Setting',
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              space20Vertical,
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
                  navigateTo(context, LanguagePage());
                },
                text: 'Language',
                imagePath: "",
              ),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {
                  navigateTo(context, ThemesPage());
                },
                text: 'Themes',
                imagePath: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
