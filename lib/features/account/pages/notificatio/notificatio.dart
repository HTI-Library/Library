import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

class NotificatioPage extends StatelessWidget {
  const NotificatioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        scaffoldBackgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        title: 'Notificatio',
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Image.asset("assets/images/test.png"),
          space20Vertical,
          Text('Not a part of a component yet.' ,
              style: Theme.of(context).textTheme .bodyText2!,),

            ],
          ),
        ),
      ),
    );
  }
}
