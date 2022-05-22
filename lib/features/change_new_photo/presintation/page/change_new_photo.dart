import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/auth.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/features/change_new_photo/widget/dialog_change_photo.dart';

class ChangeNewPhoto extends StatefulWidget {
  ChangeNewPhoto({Key? key}) : super(key: key);

  @override
  State<ChangeNewPhoto> createState() => _ChangeNewPhotoState();
}

class _ChangeNewPhotoState extends State<ChangeNewPhoto> {
  final FingerPrint _fingerPrint = FingerPrint();
  late String isSwitch;
  late bool click;
  late MainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<MainCubit>();
    isSwitch = CacheHelper2.getData(key: 'finger') ?? '' ;
    click = CacheHelper2.getData(key: 'click') ?? false ;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is UserAvatarSuccess) {
          showToast(
              message: 'تم رفع الصورة بنجاح', toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return MainScaffold(
          scaffold: BackScaffold(
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: appTranslation(context).myProfile,
            body: MainCubit.get(context).profileModel != null
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (MainCubit.get(context).imageFile != null)
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 4,
                              backgroundImage:
                                  FileImage(MainCubit.get(context).imageFile!),
                            ),
                          if (MainCubit.get(context).imageFile == null)
                            CircleAvatar(
                              backgroundImage: NetworkImage(MainCubit.get(
                                              context)
                                          .profileModel!
                                          .avatar ==
                                      'empty'
                                  ? 'https://alresalah.ps/uploads/images/54887b2cc2924f742f75c8c6c40d22ef.jpg'
                                  : MainCubit.get(context)
                                      .profileModel!
                                      .avatar),
                              radius: MediaQuery.of(context).size.width / 4,
                            ),
                          space30Vertical,
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                if (MainCubit.get(context).imageFile != null)
                                  Expanded(
                                    child: AppButton(
                                      textColor: HexColor(surface),
                                      label: 'Upload',
                                      color: HexColor(mainColor),
                                      onPress: () {
                                        MainCubit.get(context).userAvatar();
                                      },
                                    ),
                                  ),
                                if (MainCubit.get(context).imageFile == null)
                                  Expanded(
                                    child: AppButton(
                                      textColor: HexColor(surface),
                                      label: 'Choose new image',
                                      color: HexColor(mainColor),
                                      onPress: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                const DialogChangePhoto());
                                      },
                                    ),
                                  ),
                                if (MainCubit.get(context).imageFile != null)
                                  space15Horizontal,
                                if (MainCubit.get(context).imageFile != null)
                                  SizedBox(
                                    height: 40.0,
                                    width: 40.0,
                                    child: state is UserAvatarLoading
                                        ? const CupertinoActivityIndicator()
                                        : Material(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: HexColor(greyWhite),
                                            child: IconButton(
                                              onPressed: () {
                                                MainCubit.get(context)
                                                    .clearSelectedImage();
                                              },
                                              icon: Icon(
                                                Icons.delete_rounded,
                                                size: 16.0,
                                                color: HexColor(red),
                                              ),
                                            ),
                                          ),
                                  ),
                              ],
                            ),
                          ),
                          space15Vertical,
                          Row(
                            children: [
                              Text(
                                'turn on finger',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const Spacer(),
                              Switch(
                                value: click,
                                activeColor: HexColor(mainColor),
                                // switch
                                // slider
                                onChanged: (value) {
                                  enableFinger(value);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : const LoadingWidget(),
          ),
        );
      },
    );
  }

  void enableFinger(bool value) async {
    if (value) {
      bool isFingerEnabled = await _fingerPrint.isFingerPrintEnable();
      if (isFingerEnabled) {
        CacheHelper2.saveData(
            key: 'email', value: cubit.profileModel!.email.split('@')[0]);
        CacheHelper2.saveData(key: 'password', value: '123456789');
      }
    } else {
      CacheHelper2.removeData(key: 'email');
      CacheHelper2.removeData(key: 'password');
      CacheHelper2.removeData(key: 'finger');
    }
    setState(() {
      click = value;
      CacheHelper2.saveData(key: 'finger', value: 'check');
      CacheHelper2.saveData(key: 'click', value: value);
      print('------------------------------ $isSwitch');
      print(
          'mail ------------------------------ ${CacheHelper2.getData(key: 'email')}');
      print(
          'pass ------------------------------ ${CacheHelper2.getData(key: 'password')}');
    });
  }
}
