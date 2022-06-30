import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';
import 'package:hti_library/features/login/presentation/pages/login_page.dart';
import 'package:lottie/lottie.dart';

import '../cubit/cubit.dart';

class NotLogin extends StatelessWidget {
  const NotLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
  builder: (context, state) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appTranslation(context).loginFirst,
              style: Theme.of(context).textTheme.headline6,
            ),
            space10Vertical,
            Image.asset(MainCubit.get(context).isDark ? 'assets/images/login_dark.png' : 'assets/images/login.png'),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MyBtnAccount(
                voidCallback: () {
                  navigateTo(context, LoginPage());
                },
                text: appTranslation(context).logIn,
                imagePath: 'arrow_start',
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
