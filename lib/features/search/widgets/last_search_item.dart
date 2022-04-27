import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';

class LastSearchItem extends StatelessWidget {
  const LastSearchItem({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
            end: 5.0,
            bottom: 5.0,
          ),
          child: InkWell(
            onTap: (){
              MainCubit.get(context).getSearch(word: label);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: HexColor(greyWhite),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(label, style: Theme
                  .of(context)
                  .textTheme
                  .caption,),
            ),
          ),
        );
      },
    );
  }
}
