import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: 'About Us',
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: HexColor(greyWhite)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('The Library Management System is a project that aims to develop a computerized system to maintain all the daily business of the library.',
                    style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,),
                space20Vertical,
                Text('This project contains many features that are not generally available in normal library management systems such as user login facilities and teacher login capability, it also has an administrative login feature through which the administrator can complete the book borrowing and retrieval process.',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center),
                space20Vertical,

                Text('It also has a facility where the student after logging into their account can see the list of books issued, date of issue and date of return.',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center),
                space20Vertical,

                Text(
                    'Our project is developed to help students as well as library staff in maintaining the library in the best possible time. way as well as reducehuman efforts.',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
