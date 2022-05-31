import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';

class GetHelpPage extends StatelessWidget {
  const GetHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: 'Get Help',
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How do you log in?',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            space10Vertical,
            Text(
                'At the login step, you must enter your email and password to create your account that allows you to borrow and read books.',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.black87
                ),),
            space30Vertical,
            Text(
              'How do you borrow the book?',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            space10Vertical,
            Text(
                "We implement our system in a simple way that does not require you any steps to borrow the book, if you don't have any restrictions preventing you from borrowing the book, the book is automatically borrowed just click the 'BORROW' button",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black87
                ),),
            space30Vertical,
          ],
        ),
      ),
    );
  }
}
