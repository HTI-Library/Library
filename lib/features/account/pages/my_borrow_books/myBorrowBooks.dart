import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/features/account/pages/my_borrow_books/wedget/borrowBook.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyBorrowBook extends StatelessWidget {
  const MyBorrowBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BackScaffold(
          title:  appTranslation(context).myBorrowedBooks,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BuildCondition(
            condition: MainCubit.get(context).myBorrowBooks != null,
            builder: (context)=>
            MainCubit.get(context).myBorrowBooks!.books.isEmpty ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/onboarding_2.png'),
                Text('You do not have any borrowing books' , style: Theme.of(context).textTheme.bodyText1,),
              ],
            ) : ListView.builder(
                itemCount: MainCubit.get(context).myBorrowBooks!.books.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => BorrowBook(model: MainCubit.get(context).myBorrowBooks!.books[index],)
            )
            ,
            fallback: (context)=> const LoadingWidget(),
          )
        );
      },
    );
  }
}
