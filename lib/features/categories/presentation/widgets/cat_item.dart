import 'package:flutter/material.dart';

class CatItem extends StatelessWidget {
  const CatItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      margin: const EdgeInsetsDirectional.only(
          bottom: 15.0, start: 5.0, end: 5.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: const NetworkImage(
                    'https://image.freepik.com/free-vector/hand-drawn-flat-design-metaverse-illustration_23-2149245317.jpg'),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'Python',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
