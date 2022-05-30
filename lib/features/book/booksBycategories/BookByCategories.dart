import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/features/book/view_book.dart';

class BookByCategories extends StatefulWidget {
  
  const BookByCategories(
      {Key? key,
      required this.category,
      required this.library,
      required this.type})
      : super(key: key);
  
  final String category;
  final String library;
  final String type;

  @override
  State<BookByCategories> createState() => _BookByCategoriesState();
}

class _BookByCategoriesState extends State<BookByCategories> {
  
  @override
  void initState() {
    super.initState();
    MainCubit.get(context).categoryDetails(
      type: widget.type,
      library: widget.library,
      categoryName: widget.category,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
  builder: (context, state) {
    return BuildCondition(
      condition: MainCubit.get(context).categoryDetailsModel != null,
      builder:(context)=> BackScaffold(
        title: MainCubit.get(context).categoryDetailsModel!.books[0].category,
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: MainCubit.get(context).categoryDetailsModel!.books.length,
            itemBuilder: (context , index) {
              return  Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: MediaQuery.of(context).size.width / 4.9 * 1.6 + 20,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsetsDirectional.only(
                  bottom: 15.0,
                  start: 15.0,
                  end:  15.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Material(
                  color: HexColor(greyWhite),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, ViewBookPage(bookId: MainCubit.get(context).categoryDetailsModel!.books[index].id));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image(
                              image: NetworkImage(
                                  MainCubit.get(context).categoryDetailsModel!.books[index].bookImage),
                              height: MediaQuery.of(context).size.width / 4.9 * 1.6,
                              width: MediaQuery.of(context).size.width / 4.9,
                              fit: BoxFit.fill,
                            ),
                          ),
                          space10Horizontal,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  MainCubit.get(context).categoryDetailsModel!.books[index].name,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  maxLines: 2,
                                ),
                                Text(
                                  'Edition : ${MainCubit.get(context).categoryDetailsModel!.books[index].edition}',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'page : ${MainCubit.get(context).categoryDetailsModel!.books[index].pages}',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      fallback: (context)=> const Scaffold(
        body: LoadingWidget(),
      ),
    );
  },
);
  }
}
