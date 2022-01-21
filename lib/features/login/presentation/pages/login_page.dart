import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/app_text_form_field.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login to library',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: HexColor(mainColor),
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        space60Vertical,
                        AppTextFormField(
                          icon: AssetSvg(
                            imagePath: 'sms',
                            color: HexColor(mainColor),
                          ),
                          hint: 'Email',
                          callbackHandle: (controller) {
                            MainCubit.get(context).emailController = controller;
                          },
                          // onChanged: (value) {
                          //   MainCubit.get(context).enableLoginButton();
                          // },
                        ),
                        space20Vertical,
                        AppTextFormField(
                          isPassword: true,
                          hint: 'Password',
                          callbackHandle: (controller) {
                            MainCubit.get(context).passwordController =
                                controller;
                          },
                          onChanged: (value) {
                            MainCubit.get(context).enableLoginButton();
                          },
                        ),
                        space40Vertical,
                        AppButton(
                          width: MediaQuery.of(context).size.width / 2,
                          onPress: !MainCubit.get(context).isDisabled
                              ? () {
                                  print('test');
                                }
                              : null,
                          label: 'SUBMIT',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
