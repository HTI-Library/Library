import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/app_text_form_field.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/account/pages/info/pages/policyBorrowing.dart';
import 'package:intl/intl.dart';

class BorrowingPage extends StatefulWidget {
  BorrowingPage({Key? key, required this.book_id , required this.img , required this.name}) : super(key: key);
  final String book_id;
  final String img;
  final String name;

  @override
  State<BorrowingPage> createState() => _BorrowingPageState();
}

class _BorrowingPageState extends State<BorrowingPage> {
  TextEditingController dataOfBorrowController = TextEditingController();

  TextEditingController dataOfReturnController = TextEditingController();

  DateTime date = DateTime.now();

  var jiffy = DateTime.now().add(Duration(days: 3));

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is PostBorrowingBooksSuccess) {
          showToast(message: state.text, toastStates: ToastStates.SUCCESS);
        } else if (state is Error) {
          showToast(message: 'you cannot borrow more than 2 books', toastStates: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return MainScaffold(
          scaffold: BackScaffold(
            title: widget.name,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    if (state is PostBorrowingBooksLoading)
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: LinearProgressIndicator()),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: MediaQuery.of(context).size.width / 2 * 1.6,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                widget.img),
                            fit: BoxFit.fill
                          )),
                    ),
                    space20Vertical,
                    AppTextFormField(
                      enabled: false,
                      readOnly: true,
                      hint: DateFormat('yyyy-MM-dd').format(date).toString(),
                      callbackHandle: (controller) {
                        dataOfBorrowController = controller;
                      },
                    ),
                    space15Vertical,
                    AppTextFormField(
                      readOnly: true,
                      enabled: false,
                      hint: (jiffy.toString()).split(' ')[0],
                      callbackHandle: (controller) {
                        dataOfReturnController = controller;
                      },
                    ),
                    space20Vertical,
                    AppButton(
                      onPress: () {
                        MainCubit.get(context).postBorrowBook(bookID: widget.book_id);
                      },
                      label: 'SUBMIT',
                    ),
                  ],
                ),
              ),
            ),
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        );
      },
    );
  }
}
//hi
