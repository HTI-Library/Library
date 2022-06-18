import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/features/account/pages/info/info.dart';
import 'package:hti_library/features/account/pages/my_borrow_books/myBorrowBooks.dart';
import 'package:hti_library/features/account/pages/notificatio/notificatio.dart';
import 'package:hti_library/features/account/pages/setting/presntation/setting.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';
import 'package:hti_library/features/change_new_photo/presintation/page/change_new_photo.dart';
import 'package:hti_library/features/chat/chattingPage.dart';
import 'package:hti_library/features/login/presentation/pages/login_page.dart';
import 'package:hti_library/features/s_f_calender/widget/meeting.dart';
import 'package:hti_library/features/select_library/page/selectLibrary.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

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
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
            physics:  const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state is LogoutLoading) const LinearProgressIndicator(),
                if (state is LogoutLoading) space15Vertical,
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 75,
                  backgroundImage: NetworkImage(MainCubit.get(context).profileModel != null ? MainCubit.get(context).profileModel!.avatar :
                  'https://upload.wikimedia.org/wikipedia/commons/2/2e/Higher_Technological_Institute.jpg'),
                ),
                space20Vertical,
                  Text(
                    MainCubit.get(context).profileModel != null ?
                    MainCubit.get(context).profileModel!.name : 'HTI',
                    style: Theme.of(context).textTheme.headline6!,
                  ),
                if (MainCubit.get(context).profileModel == null && MainCubit.get(context).userSigned)
                  const CupertinoActivityIndicator(),
                space20Vertical,
                if (MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      navigateTo(context, ChangeNewPhoto());
                    },
                    text: appTranslation(context).myProfile,
                    imagePath: 'user_user_circle',
                  ),
                if (MainCubit.get(context).userSigned) space10Vertical,
                if (MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      MainCubit.get(context).getNotifications();
                      navigateTo(context, const NotificationPage());
                    },
                    text: appTranslation(context).notification,
                    imagePath: 'notification_notification_outline',
                  ),
                if (MainCubit.get(context).userSigned) space10Vertical,
                if (MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      navigateTo(context, const ChattingPage());
                    },
                    text: appTranslation(context).myMessage,
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
                    text: appTranslation(context).calender,
                    imagePath: 'calendar',
                  ),
                if (MainCubit.get(context).userSigned) space10Vertical,
                MyBtnAccount(
                  voidCallback: () {
                    navigateTo(context, const SettingPages());
                  },
                  text: appTranslation(context).setting,
                  imagePath: 'settings',
                ),
                space10Vertical,
                MyBtnAccount(
                  voidCallback: () {
                    navigateTo(context, const InfoPage());
                  },
                  text: appTranslation(context).info,
                  imagePath: 'info',
                ),
                space10Vertical,
                if (MainCubit.get(context).userSigned)
                MyBtnAccount(
                  voidCallback: () {
                    navigateTo(context, const SelectLibrary());
                  },
                  text: appTranslation(context).changeLib,
                  imagePath: 'change_lib',
                ),
                if (MainCubit.get(context).userSigned)
                space10Vertical,
                if (MainCubit.get(context).userSigned)
                MyBtnAccount(
                  voidCallback: () {
                    MainCubit.get(context).getMyBorrow(page: 1);
                    navigateTo(context, const MyBorrowBook());
                  },
                  text:  appTranslation(context).myBorrowedBooks,
                  imagePath: 'ic_borrow',
                ),
                if (MainCubit.get(context).userSigned)
                space10Vertical,
                if (MainCubit.get(context).userSigned)
                  MyBtnAccount(
                    voidCallback: () {
                      AwesomeDialog(
                        dialogBorderRadius: BorderRadius.circular(10.0),
                        buttonsBorderRadius: BorderRadius.circular(10.0),
                        context: context,
                        dialogBackgroundColor: MainCubit.get(context).isDark ? HexColor(secondaryColorD) : Colors.white,
                        keyboardAware: false,
                        headerAnimationLoop: false,
                        dismissOnBackKeyPress: true,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        btnCancelText: appTranslation(context).no,
                        btnCancelColor: HexColor(mainColor),
                        btnOkColor: HexColor(mainColor),
                        btnOkText: appTranslation(context).yes,
                        title: appTranslation(context).logOut,
                        isDense: true,
                        buttonsTextStyle:
                            Theme.of(context).textTheme.button!.copyWith(),
                        // padding: const EdgeInsets.all(5.0),
                        desc: appTranslation(context).doYouWantToLogout,
                        btnCancelOnPress: () {
                          debugPrint(appTranslation(context).no);
                        },
                        btnOkOnPress: () {
                          if (token != null) {
                            MainCubit.get(context).logOut(context: context);
                            debugPrint(appTranslation(context).yes);
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
                    text: appTranslation(context).logOut,
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
