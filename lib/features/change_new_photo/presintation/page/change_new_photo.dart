import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/auth.dart';
import 'package:hti_library/core/di/injection.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache_helper.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/app_text_form_field.dart';
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
  late MainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<MainCubit>();
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
                ? buildPadding(context, state)
                : const LoadingWidget(),
          ),
        );
      },
    );
  }

  Padding buildPadding(BuildContext context, MainState state) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          if (MainCubit.get(context).imageFile != null)
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 4,
              backgroundImage: FileImage(MainCubit.get(context).imageFile!),
            ),
          if (MainCubit.get(context).imageFile == null)
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        const DialogChangePhoto());
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(MainCubit.get(context)
                            .profileModel!
                            .avatar ==
                        'empty'
                    ? 'https://alresalah.ps/uploads/images/54887b2cc2924f742f75c8c6c40d22ef.jpg'
                    : MainCubit.get(context).profileModel!.avatar),
                radius: MediaQuery.of(context).size.width / 4,
              ),
            ),
          space30Vertical,
          buildTextFormFiled(state),
          Row(
            children: [
              Text(
                'turn on finger',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacer(),
              Switch(
                value: isSwitch,
                activeColor: HexColor(mainColor),
                // switch
                // slider
                onChanged: (_) {
                  cubit.enableFinger();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTextFormFiled(MainState state) {
    return Column(
      children: [
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
              if (MainCubit.get(context).imageFile != null) space15Horizontal,
              if (MainCubit.get(context).imageFile != null)
                SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: state is UserAvatarLoading
                      ? const CupertinoActivityIndicator()
                      : Material(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.circular(10.0),
                          color: HexColor(greyWhite),
                          child: IconButton(
                            onPressed: () {
                              MainCubit.get(context).clearSelectedImage();
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
        SizedBox(
            width: double.infinity,
            child: Text(
              'email',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.start,
            )),
        space10Vertical,
        AppTextFormField(
          enabled: false,
          hint: cubit.profileModel!.email,
          callbackHandle: (controller) {},
          onChanged: (value) {},
        ),
        space10Vertical,
        SizedBox(
            width: double.infinity,
            child: Text(
              'name',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.start,
            )),
        space10Vertical,
        AppTextFormField(
          enabled: false,
          hint: cubit.profileModel!.name,
          callbackHandle: (controller) {},
          onChanged: (value) {},
        ),
        space10Vertical,
        SizedBox(
            width: double.infinity,
            child: Text(
              'phone',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.start,
            )),
        space10Vertical,
        AppTextFormField(
          enabled: false,
          hint: cubit.profileModel!.phone,
          callbackHandle: (controller) {},
          onChanged: (value) {},
        ),
        space10Vertical,
      ],
    );
  }
}
