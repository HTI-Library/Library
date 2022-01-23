import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';

class CalenderPage extends StatelessWidget {
  CalenderPage({Key? key}) : super(key: key);
  var date_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        scaffoldBackgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        title: 'Calender',
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: InkWell(
              onTap: () {
                    showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(Timeline.now),
                        lastDate: DateTime(2100)).
                        then((value) {
                        date_controller.text = (value.toString());
                        print(value.toString().split(' ')[0]);
                    });

              },
            ),
          ),
        ),
      ),
    );
  }
}
