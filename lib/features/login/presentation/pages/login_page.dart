import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/di/injection.dart';
import 'package:hti_library/core/network/local/cache_helper.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/app_text_form_field.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/main/presentation/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isDisabled = true;

  void enableLoginButton() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isDisabled = false;
      setState(() {});
    } else {
      isDisabled = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.token != null) {
              sl<CacheHelper>().put('token', state.token).then((value) {
                token = state.token;
                MainCubit.get(context).changeUser(true);
                navigateAndFinish(context, MainPage());
              });
            }
            navigateAndFinish(context, MainPage());
            showToast(message: state.message, toastStates: ToastStates.SUCCESS);
          } else if (state is Error) {
            showToast(message: state.error, toastStates: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/frame.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
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
                                emailController = controller;
                              },
                              onChanged: (value) {
                                enableLoginButton();
                              },
                            ),
                            space20Vertical,
                            AppTextFormField(
                              isPassword: true,
                              hint: 'Password',
                              callbackHandle: (controller) {
                                passwordController = controller;
                              },
                              onChanged: (value) {
                                enableLoginButton();
                              },
                            ),
                            space40Vertical,
                            AppButton(
                              // width: MediaQuery.of(context).size.width / 2,
                              onPress: !isDisabled
                                  ? () {
                                      print('test');
                                      MainCubit.get(context).login(
                                          email: emailController.text,
                                          password: passwordController.text);
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
              ),
            ),
          );
        },
      ),
    );
  }
}
