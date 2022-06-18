import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';

class SettingPages extends StatefulWidget {
  const SettingPages({Key? key}) : super(key: key);

  @override
  State<SettingPages> createState() => _SettingPagesState();
}

class _SettingPagesState extends State<SettingPages> {
  late MainCubit cubit;
  
  @override
  void initState() {
    super.initState();
    cubit = context.read<MainCubit>();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit,MainState>(
      builder: (context,state){
        return
          MainScaffold(
            scaffold: BackScaffold(
              scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: appTranslation(context).setting,
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    space20Vertical,
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
                                      ? HexColor(cubit.scaffoldBackground) : HexColor(greyWhite),
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
                                          color: MainCubit.get(context).isDark
                                              ? HexColor(secondaryColorD) : HexColor(greyWhite),
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
                                          color: MainCubit.get(context).isDark
                                              ? HexColor(secondaryColorD) : HexColor(greyWhite),
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
                      text: appTranslation(context).language,
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
                                      ? HexColor(cubit.scaffoldBackground) : HexColor(greyWhite),
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
                                        text: appTranslation(context).light,
                                        imagePath: 'sun_mode',
                                      ),
                                      space10Vertical,
                                      MyBtnAccount(
                                        voidCallback: () {
                                          MainCubit.get(context)
                                              .changeMode(value: true);
                                        },
                                        text: appTranslation(context).dark,
                                        imagePath: "dark_mode",
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                        // navigateTo(context, ThemesPage());
                      },
                      text: appTranslation(context).themes,
                      imagePath: "",
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }
}
