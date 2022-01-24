import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/app_text_button.dart';
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: const NetworkImage(
                      'http://prod-upp-image-read.ft.com/a4e8f394-313b-11ea-a329-0bcf87a328f2'),
                  radius: MediaQuery.of(context).size.width / 4,
                ),
                space30Vertical,
                AppTextButton(
                  label: 'Choose new image',
                  onPress: () {},
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
