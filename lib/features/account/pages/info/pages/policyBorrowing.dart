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
      title: appTranslation(context).borrowingPolicy,
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
                              text: appTranslation(context).beforeYou,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 18)),
                          TextSpan(
                              text: appTranslation(context).borrowBold,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 19))
                        ],
                      ),
                    ),
                    Text(appTranslation(context).youSK,
                        style: Theme.of(context).textTheme.headline6)
                  ],
                ),
                Spacer(),
                Image.asset(
                  MainCubit.get(context).isDark ? 'assets/images/borrow_dark.png' : 'assets/images/constrain.png' ,
                  width: 150,
                ),
              ],
            ),
            space10Vertical,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: MainCubit.get(context).isDark
                    ? HexColor(secondaryColorD)
                    : HexColor(greyWhite),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                        text: appTranslation(context).policyLine1,
                        context: context),
                    buildText(
                        text: appTranslation(context).policyLine2,
                        context: context),
                    buildText(
                        text: appTranslation(context).policyLine3,
                        context: context),
                    buildText(
                        text: appTranslation(context).policyLine4,
                        context: context),
                    buildText(
                        text: appTranslation(context).policyLine5,
                        context: context),
                    buildText(
                        text: appTranslation(context).policyLine6,
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
