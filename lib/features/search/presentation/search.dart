import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/app_text_form_field.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/search/widgets/last_search_item.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  List<LastSearchItem> items = [
    LastSearchItem(label: 'python',),
    LastSearchItem(label: 'Java',),
    LastSearchItem(label: 'C++',),
    LastSearchItem(label: 'Ehabsdasdas',),
    LastSearchItem(label: 'Betar',),
    LastSearchItem(label: 'Betar',),
    LastSearchItem(label: 'Betar',),
    LastSearchItem(label: 'Betar',),
    LastSearchItem(label: 'Betar',),
  ];

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        title: 'Search',
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              AppTextFormField(

                hint: 'Search',
                icon: AssetSvg(
                  imagePath: 'search',
                  color: HexColor(mainColor),
                ),
                callbackHandle: (controller) {
                  searchController = controller;
                },
              ),
              space15Vertical,
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    ...items,
                  ],
                ),
              ),
            ],
          ),
        ),
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
