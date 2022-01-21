import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/my_button.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image.asset('assets/images/hti_logo.png'),
              radius: 55,
            ),
            space20Vertical,
            MyButton(
              voidCallback: () {},
              text: "text",
              color: Colors.blue,
              radius: 10,
              height: 55,
              width: 336,
            ),
            space10Vertical,
            MyButton(
              voidCallback: () {},
              text: "text",
              color: Colors.blue,
              radius: 10,
              height: 55,
              width: 336,
            ),
            space10Vertical,
            MyButton(
              voidCallback: () {},
              text: "text",
              color: Colors.blue,
              radius: 10,
              height: 55,
              width: 336,
            ),
            space10Vertical,
            MyButton(
              voidCallback: () {},
              text: "text",
              color: Colors.blue,
              radius: 10,
              height: 55,
              width: 336,
            ),
            space10Vertical,
            MyButton(
              voidCallback: () {},
              text: "text",
              color: Colors.blue,
              radius: 10,
              height: 55,
              width: 336,
            ),
          ],
        ),
      ),
    );
  }
}
