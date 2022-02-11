import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/features/category_details/presentation/widgets/cat_details_item.dart';
import 'package:hti_library/features/saved/presentation/widgets/saved_details_item.dart';
import 'package:hti_library/features/search/presentation/search.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return ListView.builder(
        itemBuilder: (context, index) => SavedDetailsItem(),
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
      );
    });
  }
}
