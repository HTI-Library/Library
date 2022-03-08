import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:hti_library/core/models/notification_model.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: '${appTranslation(context).notification}',
        body: BuildCondition(
          condition:  MainCubit.get(context).getNotificationsModel!= null,
          builder: (context)=> buildNotification(MainCubit.get(context).getNotificationsModel!.notifications , context),
          fallback: (context)=> buildNotNotification(context),
        )
      ),
    );
  }

  Widget buildNotNotification(BuildContext context)=> Padding(
    padding: const EdgeInsets.all(15.0),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/notification.png"),
          space20Vertical,
          Text(
            'You don’t have any notifications',
            style: Theme.of(context).textTheme.headline6!,
          ),
        ],
      ),
    ),
  );


  Widget buildNotification(NotificationModel model,BuildContext context)=>
  //     ListView.builder(
  //   itemBuilder: (context, index) => SavedItem(model: MainCubit.get(context).savedBooksModel!.books![index]),
  //   physics: const BouncingScrollPhysics(),
  //   itemCount: MainCubit.get(context).savedBooksModel!.books!.length,
  // );


}
