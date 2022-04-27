import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/models/book_details_model.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/app_text_form_field.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/pages/my_borrow_books/wedget/borrowBook.dart';
import 'package:hti_library/features/book/view_book.dart';
import 'package:hti_library/features/search/widgets/last_search_item.dart';

import '../../../core/models/last_search_model.dart';
import '../../../core/util/cubit/state.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key , required this.model}) : super(key: key);
  LastSearchModel model;



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
        listener: (context , state){},
        builder: (context , state){
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
                      onSubmit: (String text){
                        MainCubit.get(context).getSearch(word: text);
                      },
                      callbackHandle: (controller) {
                        MainCubit.get(context).searchController = controller;
                      },
                    ),
                    space15Vertical,
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          ...model.last_search!.map((e) => SizedBox(
                              child: Wrap(
                                children: [
                                  LastSearchItem(label: e.word,),
                                ],
                              ))).toList(),
                        ],
                      ),
                    ),
                    if (state is SearchLoading)
                      const LinearProgressIndicator(),
                    if (state is SearchSuccess)
                    Expanded(
                     child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 10),
                       child: BuildCondition(
                         condition: MainCubit.get(context).searchModel != null,
                         builder: (context)=>
                             ListView.builder(
                                 itemCount: MainCubit.get(context).searchModel!.books.length,
                                 physics: const BouncingScrollPhysics(),
                                 itemBuilder: (context, index) =>
                                     BorrowBook(data: MainCubit.get(context).searchModel!.books[index]),
                                 ),
                         fallback: (context)=> SingleChildScrollView(
                           physics: const BouncingScrollPhysics(),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 15.0),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 space10Vertical,
                                 Image.asset(
                                   'assets/images/onboarding_2.png',
                                 fit: BoxFit.cover,),
                                 space10Vertical,
                                 Text('عفوا لم نتمكن من جلب البيانات تاكد من المدخلات بشكل صحيح',
                                 textAlign: TextAlign.center,
                                 style: Theme.of(context).textTheme.headline6,)
                               ],
                             ),
                           ),
                         ),
                       ),

                       ),
                    ),
                  ],
                ),
              ),
              scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          );
        },
    );
  }
}
