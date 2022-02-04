import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
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
              // MyBtnAccount(
              //   voidCallback: () {
              //     navigateTo(context, NotificatioPage());
              //   },
              //   text: 'Notification',
              //   imagePath: 'notification_notification_outline',
              // ),
              // space10Vertical,
              MyBtnAccount(
                voidCallback: () {
                  showModalBottomSheet<void>(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            color: MainCubit.get(context).isDark
                                ? HexColor(secondBackground)
                                : HexColor(surface),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 50.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Material(
                                    color: HexColor(greyWhite),
                                    child: InkWell(
                                      onTap: () {
                                        MainCubit.get(context)
                                            .changeLanguage(value: true);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (MainCubit.get(context).isRtl)
                                              const Spacer(),
                                            Text(
                                              appTranslation(context).arabic,
                                              textAlign: TextAlign.end,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: HexColor(mainColor),
                                                    fontSize: 14.0,
                                                  ),
                                            ),
                                            if (!MainCubit.get(context).isRtl)
                                              const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                space15Vertical,
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 50.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Material(
                                    color: HexColor(greyWhite),
                                    child: InkWell(
                                      onTap: () {
                                        MainCubit.get(context)
                                            .changeLanguage(value: false);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (MainCubit.get(context).isRtl)
                                              const Spacer(),
                                            Text(
                                              appTranslation(context).english,
                                              textAlign: TextAlign.end,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: HexColor(mainColor),
                                                    fontSize: 14.0,
                                                  ),
                                            ),
                                            if (!MainCubit.get(context).isRtl)
                                              const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  // navigateTo(context, LanguagePage());
                },
                text: 'Language',
                imagePath: "",
              ),
              space10Vertical,
              MyBtnAccount(
                voidCallback: () {
                  showModalBottomSheet<void>(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            color: MainCubit.get(context).isDark
                                ? HexColor(secondBackground)
                                : HexColor(surface),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MyBtnAccount(
                                  voidCallback: () {
                                    MainCubit.get(context)
                                        .changeMode(value: false);
                                  },
                                  text: 'Light',
                                  imagePath: 'sun_mode',
                                ),
                                space10Vertical,
                                MyBtnAccount(
                                  voidCallback: () {
                                    MainCubit.get(context)
                                        .changeMode(value: true);
                                  },
                                  text: 'Dark',
                                  imagePath: "dark_mode",
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  // navigateTo(context, ThemesPage());
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
