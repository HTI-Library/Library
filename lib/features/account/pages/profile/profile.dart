import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';
import 'package:hti_library/features/change_new_photo/presintation/page/change_new_photo.dart';
import 'package:hti_library/features/no_save/no_save.dart';

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
              MyBtnAccount(
                text: 'Picture',
                voidCallback: () {
                  navigateTo(context, ChangeNewPhoto());
                },
                imagePath: "face",
              ),
              space20Vertical,
              MyBtnAccount(
                text: 'Saved',
                voidCallback: () {
                  navigateTo(context, SavedPage());
                },
                imagePath: "save",
              ),
              space20Vertical,
            ],
          ),
        ),
      ),
    );
  }
}
