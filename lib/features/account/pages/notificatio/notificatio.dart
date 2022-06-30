import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hti_library/core/models/notification_model.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/app_text_button.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/loading.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/core/util/widgets/notification_items.dart';

import '../../../../core/util/cubit/state.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit.get(context).getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return MainScaffold(
          scaffold: BackScaffold(
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: appTranslation(context).notification,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: MainCubit.get(context).getNotificationsModel != null
                  ? MainCubit.get(context)
                          .getNotificationsModel!
                          .notifications
                          .isNotEmpty
                      ? buildNotification(
                          MainCubit.get(context)
                              .getNotificationsModel!
                              .notifications.reversed.toList(),
                          context,
              state)
                      : buildNotNotification(context)
                  : const LoadingWidget(),
            ),
          ),
        );
      },
    );
  }

  Widget buildNotNotification(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(MainCubit.get(context).isDark ? 'assets/images/notification_dark.png' : 'assets/images/notification_light.png'),


              space20Vertical,
              Text(
                appTranslation(context).notificationNo,
                style: Theme.of(context).textTheme.headline6!,
              ),
            ],
          ),
        ),
      );

  Widget buildNotification(
          List<NotificationData> model, BuildContext context , MainState state) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state is NotificationLoading)
            const LinearProgressIndicator(),
          AppTextButton(label: appTranslation(context).clearAll, onPress: (){MainCubit.get(context).removeNotifications();},),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                return MainCubit.get(context).getNotifications();
              } ,
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    NotificationItem(model: model[index]),
                itemCount: model.length,
              ),
            ),
          ),
        ],
      );
}
