import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/models/notification_model.dart';

import '../constants.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData model;

  const NotificationItem({Key? key ,
    required this.model });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Container(
            color: HexColor(greyWhite),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(12),
            //   border: Border.all(color: HexColor(mainColor)),
            // ),
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1646904043595-5c3f6b0fe13b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80"),
                    radius: 32,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text('${model.message}' , style: Theme.of(context).textTheme.bodyText1,),
                        Text('12:23 PM ' , style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(icon: Icon(Icons.remove),
                  onPressed: () {},),
                ],

              ),
            ),
          ),
        ),
      ],
    );
  }
}
