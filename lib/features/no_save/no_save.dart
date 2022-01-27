import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: 'Saved',
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/saved.png"),
              space30Vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Saved',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  space5Horizontal,
                  AssetSvg(
                    imagePath: 'info',
                    size: 14.0,
                    color: HexColor(mainColor),
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
