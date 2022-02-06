import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/app_text_form_field.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

class BorrowingPage extends StatelessWidget {
  BorrowingPage({Key? key}) : super(key: key);

  TextEditingController dataOfBorrowController = TextEditingController();
  TextEditingController dataOfReturnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        title: 'Borrow Book',
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: MediaQuery.of(context).size.width / 2 * 1.6,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://edit.org/images/cat/book-covers-big-2019101610.jpg'),
                      )),
                ),
                space20Vertical,
                AppTextFormField(
                  hint: 'Date of Borrow',
                  callbackHandle: (controller) {
                    dataOfBorrowController = controller;
                  },
                ),
                space15Vertical,
                AppTextFormField(
                  hint: 'Date of Return',
                  callbackHandle: (controller) {
                    dataOfReturnController = controller;
                  },
                ),
                space20Vertical,
                AppButton(
                  // width: MediaQuery.of(context).size.width / 2,
                  onPress: () {},
                  label: 'SUBMIT',
                ),
              ],
            ),
          ),
        ),
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
//hi
