import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';

class Borrowing extends StatelessWidget {
  const Borrowing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Borrow Book',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Date of Borrow',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Date of Borrow',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.grey,
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                    color: Colors.indigoAccent

                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//hi
