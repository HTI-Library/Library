import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/di/injection.dart' as di;
import 'package:hti_library/features/on_boarding/presentation/pages/on_boarding_page.dart';

import 'core/di/injection.dart';
import 'core/models/cart_model.dart';
import 'core/network/local/cache_helper.dart';
import 'core/util/bloc_observer.dart';
import 'core/util/constants.dart';
import 'core/util/cubit/cubit.dart';
import 'core/util/cubit/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await di.init();

  bool isDark = false;

  await sl<CacheHelper>().get('isDark').then((value) {
    debugPrint('dark mode ------------- $value');
    if (value != null) {
      isDark = value;
    }
  });

  sl<CacheHelper>().get('token').then((value) {
    debugPrint('token_---------------------------- $value');
    if (value == null) {
      token = '';
    } else {
      token = value;
    }
  });

  sl<CacheHelper>().get('cart').then((value) {
    debugPrint('cart ---------------------------- $value');

    if (value != null) {
      cartListData = MainCartModel.fromJson(value).data;
    }
  });

  debugPrint('dark mode ------------- $isDark');

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatefulWidget {
  final bool isDark;

  const MyApp({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<MainCubit>()
            ..setThemes(
              dark: widget.isDark,
            )
            ..checkInternet()
            ..checkConnectivity(),
        ),
      ],
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'HTI Library',
            debugShowCheckedModeBanner: false,
            themeMode: MainCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: MainCubit.get(context).lightTheme,
            darkTheme: MainCubit.get(context).darkTheme,
            home: OnBoardingPage(),
          );
        },
      ),
    );
  }
}
// test add new code to git
// test create the first branch
// test create old
// my first git homa hadoba
// second branch
