import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/features/account/pages/info/info.dart';
import 'package:hti_library/features/account/pages/message/message.dart';
import 'package:hti_library/features/account/pages/notificatio/notificatio.dart';
import 'package:hti_library/features/account/pages/setting/presntation/setting.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';
import 'package:hti_library/features/change_new_photo/presintation/page/change_new_photo.dart';
import 'package:hti_library/features/login/presentation/pages/login_page.dart';
import 'package:hti_library/features/s_f_calender/widget/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  var _width = 230.0;

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Meeting appointment = calendarAppointmentDetails.appointments.first;
    return Container(
      width: calendarAppointmentDetails.bounds.width,
      height: calendarAppointmentDetails.bounds.height,
      // color: appointment.background,
      decoration: BoxDecoration(
        color: appointment.background,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 0, 0, 5.0),
            child: Text(
              appointment.eventName,
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(2.0, 0, 0, 0),
            child: Text(
              "Phòng",
              style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state is LogoutLoading) const LinearProgressIndicator(),
                if (state is LogoutLoading) space15Vertical,
                CircleAvatar(
                  child: Image.asset('assets/images/hti_logo.png'),
                  radius: 55,
                ),
                space20Vertical,
                Text('Htian Here',
                    style: Theme.of(context).textTheme.headline6!),
                space20Vertical,
                if (MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      navigateTo(context, ChangeNewPhoto());
                    },
                    text: 'My Profile',
                    imagePath: 'user_user_circle',
                  ),
                if (MainCubit.get(context).userSigned) space10Vertical,
                if (MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      navigateTo(context, NotificationPage());
                    },
                    text: 'Notification',
                    imagePath: 'notification_notification_outline',
                  ),
                if (MainCubit.get(context).userSigned) space10Vertical,
                if (MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      navigateTo(context, MessagePage());
                    },
                    text: 'My Message',
                    imagePath: 'message_account',
                  ),
                if (MainCubit.get(context).userSigned) space10Vertical,
                if (MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      // navigateTo(context, SFCalenderPage());
                      showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          builder: (context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: SfCalendar(
                                view: CalendarView.month,
                                showDatePickerButton: true,
                                showCurrentTimeIndicator: false,
                                showNavigationArrow: true,

                                viewNavigationMode: ViewNavigationMode.snap,
                                appointmentBuilder: appointmentBuilder,
                                initialDisplayDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    00,
                                    45,
                                    0),
                                monthViewSettings:
                                    const MonthViewSettings(showAgenda: true),
                                // monthViewSettings: const MonthViewSettings(
                                //     appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
                              ),
                            );
                          });
                    },
                    text: 'calender',
                    imagePath: 'calendar',
                  ),
                if (MainCubit.get(context).userSigned) space10Vertical,
                MyBtnAccount(
                  voidCallback: () {
                    navigateTo(context, SettingPages());
                  },
                  text: 'Setting',
                  imagePath: 'settings',
                ),
                space10Vertical,
                MyBtnAccount(
                  voidCallback: () {
                    navigateTo(context, InfoPage());
                  },
                  text: 'Info',
                  imagePath: 'info',
                ),
                space10Vertical,
                if (MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      AwesomeDialog(
                        dialogBorderRadius: BorderRadius.circular(10.0),
                        buttonsBorderRadius: BorderRadius.circular(10.0),
                        context: context,
                        keyboardAware: false,
                        headerAnimationLoop: false,
                        dismissOnBackKeyPress: true,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        btnCancelText: "Cancel",
                        btnCancelColor: HexColor(mainColor),
                        btnOkColor: HexColor(secondaryVariantDark),
                        btnOkText: "Yes",
                        title: 'log out ',
                        isDense: true,
                        // padding: const EdgeInsets.all(5.0),
                        desc: 'Do you want to log out ?',
                        btnCancelOnPress: () {
                          debugPrint('Cancel' );
                        },
                        btnOkOnPress: () {
                          if (token != null) {
                            MainCubit.get(context).logOut(context: context);
                            debugPrint('Yes--------------------------------');
                            debugPrint('${MainCubit.get(context).userSigned}');
                            debugPrint(token);
                          } else {
                            debugPrint('${MainCubit.get(context).userSigned}');
                            showToast(
                                message: 'Please login first',
                                toastStates: ToastStates.WARNING);
                          }
                        },
                      ).show();
                    },
                    text: 'Log Out',
                    imagePath: 'sign_out',
                  ),
                if (MainCubit.get(context).userSigned) space10Vertical,
                if (!MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      navigateTo(context, LoginPage());
                    },
                    text: appTranslation(context).logIn,
                    imagePath: 'arrow_start',
                  ),
                if (!MainCubit.get(context).userSigned) space10Vertical,
                space10Vertical,
              ],
            ),
          ),
        );
      },
    );
  }
}
