import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/features/change_new_photo/widget/dialog_change_photo.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

class ChangeNewPhoto extends StatelessWidget {
  ChangeNewPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                          ),
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
}
