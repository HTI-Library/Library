import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

class NoSavedPage extends StatelessWidget {
  const NoSavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              space60Vertical,
              space60Vertical,
              Image.asset(MainCubit.get(context).isDark ? "assets/images/saved.png" : "assets/images/saved.png"),
              space30Vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appTranslation(context).noSaved,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              space80Vertical,
              space80Vertical,
            ],
          ),
        ),
      ),
    );
  }
}
