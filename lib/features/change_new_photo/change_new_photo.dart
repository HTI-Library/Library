import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

class ChangeNewPhoto extends StatelessWidget {
  const ChangeNewPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: 'Picture',
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Image.network(
                    'http://prod-upp-image-read.ft.com/a4e8f394-313b-11ea-a329-0bcf87a328f2'),
                radius: 75,
              ),
              space20Vertical,
              Text(
                'Choose new image',
                style: Theme.of(context).textTheme.bodyText2!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
