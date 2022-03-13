import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/di/injection.dart' as di;

import 'core/di/injection.dart';
import 'core/network/local/cache_helper.dart';
import 'core/util/bloc_observer.dart';
import 'core/util/constants.dart';
import 'core/util/cubit/cubit.dart';
import 'core/util/cubit/state.dart';
import 'features/main/presentation/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await di.init();

  bool isRtl = false;

  await sl<CacheHelper>().get('isRtl').then((value) {
    debugPrint('trl ------------- $value');
    if (value != null) {
      isRtl = value;
    }
  });

  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

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

  debugPrint('dark mode ------------- $isDark');

  runApp(MyApp(
    isDark: isDark,
    isRtl: isRtl,
    translation: translation,
  ));
  debugPrint(translation);
}

class MyApp extends StatefulWidget {
  final bool isDark;
  final bool isRtl;
  final String translation;

  const MyApp({
    Key? key,
    required this.isDark,
    required this.isRtl,
    required this.translation,
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
              rtl: widget.isRtl,
              dark: widget.isDark,
            )
            ..changeUser(token!.isNotEmpty)
            ..setTranslation(
              translation: widget.translation,
            )
            ..checkInternet()
            ..checkConnectivity()
            ..categories()
            ..topBorrow(page: 1)
            ..getRecentlyReturned(page: 1)
            ..postBorrowBook(bookID: '6225df6faf57b7ef4675f50a')
            ..getRecentlyReturned(page: 1)
            ..getSavedBooks(),
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
            // home: token == '' ? LoginPage() : MainPage(),
            home: MainPage(),
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
