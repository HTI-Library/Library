import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/main/presentation/pages/main_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late MainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<MainCubit>();
    Timer(const Duration(seconds: 4),() {
      navigateAndFinish(context, MainPage(library: libraryCache, type: typeCache));
    });

  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: Scaffold(
        body: Column(
          children: [
            space100Vertical,
            Lottie.asset('assets/images/spash_lotti.json'),
            Text(
                'HTI Library',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: cubit.isDark ? HexColor(surface) : HexColor(mainColor)
                ),
                textAlign: TextAlign.center),

          ],
        ),
      ),
    );
  }
}