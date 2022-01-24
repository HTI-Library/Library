import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/pages/account/account.dart';
import 'package:hti_library/features/categories/presentation/pages/categories.dart';
import 'package:hti_library/features/home/presentation/pages/home_page.dart';
import 'package:hti_library/features/internet_connection/page/internet_connection_page.dart';
import 'package:hti_library/features/wishlist/presentation/pages/wishlist_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              !MainCubit.get(context).noInternetConnection,
          widgetBuilder: (context) => MainScaffold(
            scaffold: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                // leading: IconButton(
                //     onPressed: () {
                //       scaffoldKey.currentState!.openDrawer();
                //     },
                //     icon: Icon(FontAwesomeIcons.blog),),
                // actions: [
                //   IconButton(
                //     onPressed: () {
                //       if(MainCubit.get(context).userSigned){
                //         MainCubit.get(context).getNotification();
                //         navigateTo(context, const NotificationScreen());
                //       }else{
                //         showToast(toastStates: ToastStates.WARNING, message: appTranslation(context).please_login_to_get_notifications);
                //         navigateTo(context, LoginPage());
                //       }
                //
                //     },
                //     icon: const MyThemeIcon(
                //       path: 'notification',
                //     ),
                //   ),
                //   IconButton(
                //       onPressed: () {
                //         navigateTo(context, SearchPage());
                //       },
                //       icon: const MyThemeIcon(
                //         path: 'search',
                //       )),
                // ],
                centerTitle: false,
                titleSpacing: 15.0,
                title: Text(
                  'LIBRARY',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              body: BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const HomePage(),
                            const Categories(),
                            const WishlistPage(),
                            AccountPage(),
                          ],
                          // onPageChanged: (index) {
                          //   MainCubit.get(context).bottomChanged(index);
                          // },
                        ),
                      ),
                      if (MainCubit.get(context).isDark) myDivider(context),
                    ],
                  );
                },
              ),
              // drawer: Drawer(
              //   child: SafeArea(
              //     child: BlocBuilder<MainCubit, MainState>(
              //       builder: (context, state) {
              //         return Container(
              //           color: MainCubit.get(context).isDark
              //               ? HexColor(
              //                   MainCubit.get(context).scaffoldBackground)
              //               : null,
              //           child: SingleChildScrollView(
              //             physics: const BouncingScrollPhysics(),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 if (!MainCubit.get(context).userSigned ||
              //                     MainCubit.get(context).myAccountModel == null)
              //                   Padding(
              //                     padding: const EdgeInsets.all(14.0),
              //                     child: Row(
              //                       children: [
              //                         Expanded(
              //                           child: MyButton(
              //                             voidCallback: () {
              //                               navigateTo(context, LoginPage());
              //                             },
              //                             text: appTranslation(context).sign_in,
              //                             color: HexColor(mainColor),
              //                             radius: 8.0,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 if (MainCubit.get(context).userSigned &&
              //                     MainCubit.get(context).myAccountModel != null)
              //                   Padding(
              //                     padding: const EdgeInsets.all(14.0),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         CircleAvatar(
              //                           radius: 30.0,
              //                           backgroundImage: NetworkImage(
              //                             MainCubit.get(context)
              //                                 .myAccountModel!
              //                                 .data
              //                                 .image,
              //                           ),
              //                         ),
              //                         space10Vertical,
              //                         if (MainCubit.get(context)
              //                                 .myAccountModel !=
              //                             null)
              //                           Text(
              //                             MainCubit.get(context)
              //                                 .myAccountModel!
              //                                 .data
              //                                 .name,
              //                             textAlign: TextAlign.start,
              //                             style: Theme.of(context)
              //                                 .textTheme
              //                                 .bodyText1,
              //                           ),
              //                         space3Vertical,
              //                         if (MainCubit.get(context)
              //                                 .myAccountModel !=
              //                             null)
              //                           Text(
              //                             MainCubit.get(context)
              //                                 .myAccountModel!
              //                                 .data
              //                                 .email,
              //                             style: Theme.of(context)
              //                                 .textTheme
              //                                 .caption,
              //                           ),
              //                         // InkWell(
              //                         //   onTap: () {
              //                         //     signOut(context);
              //                         //   },
              //                         //   child: Padding(
              //                         //     padding: const EdgeInsets.symmetric(
              //                         //         vertical: 10.0),
              //                         //     child: Row(
              //                         //       children: [
              //                         //         SvgPicture.asset(
              //                         //           'assets/images/sign_out.svg',
              //                         //           color: secondaryVariant,
              //                         //         ),
              //                         //         space10Horizontal,
              //                         //         Text(
              //                         //           appTranslation(context).sign_out,
              //                         //           style: Theme.of(context)
              //                         //               .textTheme
              //                         //               .bodyText1!
              //                         //               .copyWith(
              //                         //                 color: HexColor(grey),
              //                         //               ),
              //                         //         )
              //                         //       ],
              //                         //     ),
              //                         //   ),
              //                         // ),
              //                       ],
              //                     ),
              //                   ),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsetsDirectional.only(
              //                           start: 14.0, top: 10.0),
              //                       child: Text(
              //                         appTranslation(context).category,
              //                         style: Theme.of(context)
              //                             .textTheme
              //                             .headline6!
              //                             .copyWith(
              //                                 fontWeight: FontWeight.w400),
              //                       ),
              //                     ),
              //                     space10Vertical,
              //                     if (MainCubit.get(context).categoriesModel !=
              //                         null)
              //                       ListView.builder(
              //                         physics:
              //                             const NeverScrollableScrollPhysics(),
              //                         shrinkWrap: true,
              //                         itemBuilder: (context, index) =>
              //                             ListItemDrawer(
              //                           model: MainCubit.get(context)
              //                               .categoriesModel!
              //                               .data
              //                               .categoriesList[index],
              //                         ),
              //                         itemCount: MainCubit.get(context)
              //                             .categoriesModel!
              //                             .data
              //                             .categoriesList
              //                             .length,
              //                       ),
              //                     space40Vertical,
              //                   ],
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsetsDirectional.only(
              //                       start: 14.0, top: 10.0),
              //                   child: Text(
              //                     appTranslation(context).help_info,
              //                     style: Theme.of(context)
              //                         .textTheme
              //                         .headline6!
              //                         .copyWith(fontWeight: FontWeight.w400),
              //                   ),
              //                 ),
              //                 space10Vertical,
              //                 Column(
              //                   children: [
              //                     SettingsItem(
              //                       function: () {
              //                         navigateTo(context, const NewsListPage());
              //                         //Navigator.pop(context);
              //                       },
              //                       title: appTranslation(context).blogs,
              //                       icon: FontAwesomeIcons.blog,
              //                       sign: false,
              //                       showIcon: false,
              //                       showAssetsIcon: true,
              //                       imagePath: 'blogs',
              //                     ),
              //                     SettingsItem(
              //                       function: () {
              //                         navigateTo(context, const AboutUsPage());
              //                       },
              //                       title: appTranslation(context).about_us,
              //                       icon: FontAwesomeIcons.info,
              //                       sign: false,
              //                       showIcon: false,
              //                       showAssetsIcon: true,
              //                       imagePath: 'info',
              //                     ),
              //                     SettingsItem(
              //                       function: () {
              //                         navigateTo(context, ContactUsPage());
              //                       },
              //                       title: appTranslation(context).contact_us,
              //                       icon: FontAwesomeIcons.tag,
              //                       sign: false,
              //                       showIcon: false,
              //                       showAssetsIcon: true,
              //                       imagePath: 'contact_us',
              //                     ),
              //                     SettingsItem(
              //                       function: () {
              //                         navigateTo(context, FAQPage());
              //                       },
              //                       title: appTranslation(context).faq,
              //                       icon: FontAwesomeIcons.umbrella,
              //                       sign: false,
              //                       showIcon: false,
              //                       showAssetsIcon: true,
              //                       imagePath: 'faq',
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  return BottomNavigationBar(
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    onTap: (int index) {
                      _pageController.jumpToPage(
                        index,
                      );

                      MainCubit.get(context).bottomChanged(index);
                    },
                    elevation: 20.0,
                    unselectedLabelStyle: TextStyle(
                      color: HexColor(grey),
                      height: 15.0,
                      fontSize: 1.0,
                    ),
                    selectedLabelStyle: const TextStyle(
                      height: 15.0,
                      fontSize: 1.0,
                    ),
                    currentIndex: MainCubit.get(context).currentIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: AssetSvg(
                            color: HexColor(mainColor),
                            imagePath: MainCubit.get(context).currentIndex == 0
                                ? 'home_soled'
                                : 'home',
                          ),
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: AssetSvg(
                            color: HexColor(mainColor),
                            imagePath: MainCubit.get(context).currentIndex == 1
                                ? 'category_soled'
                                : 'category',
                          ),
                        ),
                        label: 'Categories',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: AssetSvg(
                            color: HexColor(mainColor),
                            imagePath: MainCubit.get(context).currentIndex == 2
                                ? 'save_soled'
                                : 'no_save',
                          ),
                        ),
                        label: 'Saved',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: AssetSvg(
                            color: HexColor(mainColor),
                            imagePath: MainCubit.get(context).currentIndex == 3
                                ? 'user_soled'
                                : 'user',
                          ),
                        ),
                        label: 'User',
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          fallbackBuilder: (context) => const InternetConnectionPage(),
        );
      },
    );
  }
}
