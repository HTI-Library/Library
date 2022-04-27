import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';

class PdfDetails extends StatelessWidget {
  const PdfDetails({Key? key, required this.bookId}) : super(key: key);
  final String bookId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BackScaffold(
          title: MainCubit.get(context).bookModel!.book.name,
            scaffoldBackgroundColor: Theme
                .of(context)
                .scaffoldBackgroundColor,
          body: PDF(
          ).cachedFromUrl(
              MainCubit.get(context).bookModel!.book.bookLink,
              placeholder: (progress) =>Center(child: Text('$progress %'))));
      },
    );
  }
}
