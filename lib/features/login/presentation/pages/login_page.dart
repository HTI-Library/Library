import 'dart:async';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/auth.dart';
import 'package:hti_library/core/di/injection.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache_helper.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/app_text_form_field.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/features/main/presentation/pages/main_page.dart';
import 'package:hti_library/features/select_library/page/selectLibrary.dart';

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
  bool isLoad = false;
  final FingerPrint _fingerPrint = FingerPrint();
  late MainCubit cubit;

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
  void initState() {
    super.initState();
    cubit = context.read<MainCubit>();

    sl<CacheHelper>().get('finger').then((value) {
      debugPrint('finger ------------- $value');
      if (value != null) {
        isSwitch = value;
      } else {
        isSwitch = false;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.loginModel.token != null) {
            sl<CacheHelper>()
                .put('token', state.loginModel.token)
                .then((value) {
              token = state.loginModel.token;
              if (libraryCache!.isNotEmpty && typeCache!.isNotEmpty) {
                navigateAndFinish(context, const SelectLibrary());
              }
            });
          }
          if (libraryCache!.isNotEmpty && typeCache!.isNotEmpty) {
            navigateAndFinish(
                context,
                MainPage(
                  library: libraryCache,
                  type: typeCache,
                ));
          } else {
            navigateAndFinish(context, const SelectLibrary());
          }
          showToast(
              message: state.loginModel.message!,
              toastStates: ToastStates.SUCCESS);
        }
        else if (state is Error) {
          showToast(message: state.error, toastStates: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return BackScaffold(
            body: Container(
              height: MediaQuery.of(context).size.height -
                  MainCubit.get(context).appBarHeight -
                  MediaQuery.of(context).viewPadding.top,
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
                            appTranslation(context).loginToLibrary,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                              color:MainCubit.get(context).isDark ? Colors.white: HexColor(mainColor),
                              fontWeight: FontWeight.w700,
                                ),
                          ),
                          space60Vertical,
                          AppTextFormField(
                            icon: AssetSvg(
                              imagePath: 'sms',
                                color:MainCubit.get(context).isDark ? Colors.white: HexColor(mainColor),
                            ),
                            hint: appTranslation(context).id,
                            callbackHandle: (controller) {
                              emailController = controller;
                            },
                            type: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              enableLoginButton();
                            },
                          ),
                          space20Vertical,
                          AppTextFormField(
                            isPassword: true,
                            hint: appTranslation(context).password,
                            callbackHandle: (controller) {
                              passwordController = controller;
                            },
                            onChanged: (value) {
                              enableLoginButton();
                            },
                          ),
                          space40Vertical,
                          BuildCondition(
                            condition: state is LoginLoading,
                            builder: (context) => Container(
                              width: double.infinity,
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: HexColor(greyWhite),
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: const CupertinoActivityIndicator(),
                            ),
                            fallback: (context) =>
                              Row(
                              children: [
                                if (isSwitch)
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        color:
                                            Theme.of(context).primaryColor),
                                    child: IconButton(
                                      color: Colors.white,
                                      iconSize: 28,
                                      icon: const Icon(Icons.fingerprint_rounded),
                                      splashRadius: 20,
                                      onPressed: () {
                                        fingerLogin();
                                      },
                                    ),
                                  ),
                                if (isSwitch) space10Horizontal,
                                Expanded(
                                  child: AppButton(
                                    // width: MediaQuery.of(context).size.width / 2,
                                    onPress: !isDisabled
                                        ? () {
                                            MainCubit.get(context).login(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                          }
                                        : null,
                                    label: appTranslation(context).logIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor);
      },
    );
  }

  void fingerLogin() async {
    bool isFinished = await _fingerPrint.isFingerPrintEnable();
    if (isFinished) {
      bool isAuth = await _fingerPrint.isAuth('login finger print');
      if (isAuth) {
        String mail = CacheHelper2.getData(key: 'email');
        String pass = CacheHelper2.getData(key: 'password');
        cubit.login(email: mail, password: pass);
      }
    }
  }
}
