import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';

import '../../../../../core/util/cubit/cubit.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: appTranslation(context).aboutUs,
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MainCubit.get(context).isDark ? HexColor(secondaryColorD) : HexColor(greyWhite),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text( appTranslation(context).aboutUsL1,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,),
                  space20Vertical,
                  Text( appTranslation(context).aboutUsL2,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center),
                  space20Vertical,

                  Text( appTranslation(context).aboutUsL3,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center),
                  space20Vertical,

                  Text(
                      appTranslation(context).aboutUsL4,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
