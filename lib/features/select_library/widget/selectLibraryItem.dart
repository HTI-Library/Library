import 'package:flutter/material.dart';

class SelectLibraryItem extends StatelessWidget {
  const SelectLibraryItem({
    Key? key,
    required this.img,
    required this.name,
    required this.color,
    required this.callbackHandle,
  }) : super(key: key);

  final String img;
  final String name;
  final Color color;
  final Function() callbackHandle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: callbackHandle,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/$img.jpg',
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.9,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: color,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width * 0.05),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
