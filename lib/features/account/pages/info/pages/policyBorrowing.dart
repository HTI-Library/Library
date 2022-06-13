import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';

class PolicyBorrowing extends StatefulWidget {
  PolicyBorrowing({Key? key}) : super(key: key);

  @override
  State<PolicyBorrowing> createState() => _PolicyBorrowingState();
}

class _PolicyBorrowingState extends State<PolicyBorrowing> {
  late MainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<MainCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: 'Borrowing policy',
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Before Yor',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 18)),
                        TextSpan(
                            text: '  BORROW',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 19))
                      ],
                    )),
                    Text('you should know...',
                        style: Theme.of(context).textTheme.headline6)
                  ],
                ),
                Spacer(),
                Image.asset(
                  'assets/images/constrain.png',
                  width: 200,
                ),
              ],
            ),
            space10Vertical,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: HexColor(greyWhite)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                        text:
                            '1• The maximum number of books available for borrowing is 3 books.',
                        context: context),
                    buildText(
                        text:
                            '2• The borrowing period is 3 working days for the Institute.',
                        context: context),
                    buildText(
                        text:
                            '3• The borrowing period can be extended, but before the date of delivery.',
                        context: context),
                    buildText(
                        text:
                            '4• The maximum number of times the borrowing can be extended is only 2 times.',
                        context: context),
                    buildText(
                        text:
                            '5• If the book is not returned on the delivery date, an email will be sent to Institute .',
                        context: context),
                    buildText(
                        text:
                            '6• You must have an ID while receiving or delivering the book.',
                        context: context),
                  ],
                ),
              ),
            ),
            if (!isReadPolicy) space20Vertical,
            if (!isReadPolicy)
              AppButton(
                  label: 'Ok',
                  onPress: () {
                    setState(() {
                      cubit.backScreen(context);
                    });
                  }),
          ],
        ),
      ),
    );
  }

  Widget buildText({required String text, required BuildContext context}) {
    return Column(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 16,
              ),
        ),
        space10Vertical,
      ],
    );
  }
}
