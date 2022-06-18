import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';

class GetHelpPage extends StatelessWidget {
  const GetHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: appTranslation(context).getHelp,
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appTranslation(context).getHelpQ1,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            space10Vertical,
            Text(
              appTranslation(context).getHelpA1,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.blueAccent
                ),),
            space30Vertical,
            Text(
              appTranslation(context).getHelpQ2,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            space10Vertical,
            Text(
              appTranslation(context).getHelpA2,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.blueAccent
                ),),
            space30Vertical,
          ],
        ),
      ),
    );
  }
}
