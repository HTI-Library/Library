import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/item_borrow_book.dart';

class MyBorrowBook extends StatelessWidget {
  const MyBorrowBook({Key? key}) : super(key: key);
  final String txt = "fsdsadasdsdfsdfsdfsdfsdfsdfgasdasd";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>
      (builder: (context, state) {
      return BackScaffold(
          title: 'My Borrow Book',
          scaffoldBackgroundColor:Theme.of(context).scaffoldBackgroundColor,
          body: ListView.builder(
              itemCount: 10,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context , index)=> ItemBorrowBook()),
          );
    });
  }
}
