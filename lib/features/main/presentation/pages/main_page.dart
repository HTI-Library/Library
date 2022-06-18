import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/di/injection.dart';
import 'package:hti_library/core/network/local/cache_helper.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/pages/account/account.dart';
import 'package:hti_library/features/categories/presentation/pages/categories.dart';
import 'package:hti_library/features/home/presentation/pages/home_page.dart';
import 'package:hti_library/features/internet_connection/page/internet_connection_page.dart';
import 'package:hti_library/features/saved/presentation/pages/saved.dart';
import 'dart:io';

import 'package:hti_library/features/select_library/page/selectLibrary.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.type, required this.library}) : super(key: key);
  final String? type;
  final String? library;



  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late MainCubit cubit;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
    cubit = context.read<MainCubit>();

    MainCubit.get(context).categoryDetailsHti(
      categoryName: 'hti matrial',
      library: widget.library!,
      type: widget.type!,
    );

    MainCubit.get(context).categories(
        library: widget.library!,
        type: widget.type!,
    );

    MainCubit.get(context).categoryProject(
      categoryName: 'categoryName',
      library: widget.library!,
      type: widget.type!,
    );

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
        return WillPopScope(
          onWillPop: () async {
            // exit(0);
            SystemNavigator.pop();
            return true;
          } ,
          child: Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                !MainCubit.get(context).noInternetConnection,
            widgetBuilder: (context) => MainScaffold(
              scaffold: Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  titleSpacing: 15.0,
                  title: Text(
                    MainCubit.get(context).isRtl?
                    MainCubit.get(context).mainPageTitles[MainCubit.get(context).currentIndex]['ar']:
                    MainCubit.get(context).mainPageTitles[MainCubit.get(context).currentIndex]['en'],
                    style: Theme.of(context).textTheme.headline6,
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
                            children: const [
                              HomePage(),
                              Categories(),
                              SavedPage(),
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
                bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
                  builder: (context, state) {
                    return BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
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
                              color:MainCubit.get(context).isDark
                                  ? HexColor(surface)
                                  : HexColor(mainColor),
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
                              color:MainCubit.get(context).isDark
                                  ? HexColor(surface)
                                  : HexColor(mainColor),
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
                              color: MainCubit.get(context).isDark
                                  ? HexColor(surface)
                                  :HexColor(mainColor),
                              imagePath: MainCubit.get(context).currentIndex == 2
                                  ? 'save_soled'
                                  : 'save',
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
                              color:MainCubit.get(context).isDark
                                  ? HexColor(surface)
                                  : HexColor(mainColor),
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
          ),
        );
      },
    );
  }
}
