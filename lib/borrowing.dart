import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/app_text_form_field.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

import 'features/account/widget/btn_my_account.dart';

class BorrowingPage extends StatelessWidget {
   BorrowingPage({Key? key}) : super(key: key);

  TextEditingController dataOfBorrowController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [


              Text(
                'Borrow Book',
                style: Theme.of(context).textTheme.headline6,
              ),

              space20Vertical,



              AppTextFormField(hint: 'Date of Borrow',   callbackHandle: (controller) {
                dataOfBorrowController = controller;
              },),


              space20Vertical,



              AppTextFormField(hint: 'Date of Return',   callbackHandle: (controller) {
                dataOfBorrowController = controller;
              },),



              space20Vertical,





              AppButton(
                // width: MediaQuery.of(context).size.width / 2,
                onPress: (){},

                label: 'SUBMIT',
              ),
              
              
              
            ],
          ),
        ), scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
//hi
