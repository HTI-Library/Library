import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/auth.dart';
import 'package:hti_library/core/di/injection.dart';
import 'package:hti_library/core/error/exceptions.dart';
import 'package:hti_library/core/models/allTypeModel.dart';
import 'package:hti_library/core/models/book_details_model.dart';
import 'package:hti_library/core/models/categories_model.dart';
import 'package:hti_library/core/models/getAllReturnedBooks.dart';
import 'package:hti_library/core/models/get_saved_books_model.dart';
import 'package:hti_library/core/models/last_search_model.dart';
import 'package:hti_library/core/models/login_model.dart';
import 'package:hti_library/core/models/messageModel.dart';
import 'package:hti_library/core/models/old/search_model.dart';
import 'package:hti_library/core/models/profile_model.dart';
import 'package:hti_library/core/models/remove_save_books_model.dart';
import 'package:hti_library/core/models/save_books_model.dart';
import 'package:hti_library/core/models/top_borrow_model.dart';
import 'package:hti_library/core/models/userModel.dart';
import 'package:hti_library/core/network/local/cache.dart';
import 'package:hti_library/core/network/local/cache_helper.dart';
import 'package:hti_library/core/network/repository.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/translation.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/myBorrowBookModel.dart';
import '../../models/notification_model.dart';
import '../constants.dart';

class MainCubit extends Cubit<MainState> {
  final Repository _repository;

  MainCubit({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());

  static MainCubit get(context) => BlocProvider.of(context);

  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  int currentIndex = 0;
  List<Map> mainPageTitles = [
    {
      'ar': 'الرئيسية',
      'en': 'Home',
    },
    {
      'ar': 'الأقسام',
      'en': 'Categories',
    },
    {
      'ar': 'المحفوظات',
      'en': 'Saved',
    },
    {
      'ar': 'حسابي',
      'en': 'Account',
    },
  ];

  void bottomChanged(int index) {
    if (index == 3) {
      currentIndex = index;
      emit(BottomChanged());
    }
    currentIndex = index;
    emit(BottomChanged());
  }

  // dark colors
  String scaffoldBackground = '11202a';

  String mainColorDark = 'ffffff';
  String mainColorVariantDark = '8a8a89';

  int currentParentCategorySelected = 0;

  void changeParentCategorySelection(int index) {
    currentParentCategorySelected = index;
    emit(CategoriesChangeParentCategoryState(
      index: currentParentCategorySelected,
    ));
  }

  // dark colors
  String secondaryDark = 'ffffff';
  String secondaryVariantDark = '8a8a89';

  late ThemeData lightTheme;
  late ThemeData darkTheme;

  late String family;

  bool isRtl = false;
  bool isDark = false;

  void setThemes({
    required bool dark,
    required bool rtl,
  }) {
    isDark = dark;
    isRtl = rtl;

    debugPrint('dark mode ------------- $isDark');

    changeTheme();

    emit(ThemeLoaded());
  }

  void changeTheme() {
    family = isRtl ? 'Cairo' : 'Poppins';

    lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20.0,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(grey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        // headline5: TextStyle(
        //   fontSize: 24.0,
        //   fontFamily: family,
        //   fontWeight: FontWeight.w400,
        //   color: HexColor(secondary),
        //   height: 1.4,
        // ),
        headline6: TextStyle(
          fontSize: 18.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: HexColor(secondary),
          height: 1.3,
        ),
        // appbarTitle: TextStyle(
        //   fontSize: 20.0,
        //   fontFamily: family,
        //   fontWeight: FontWeight.w500,
        //   color: secondaryVariant,
        //   height: 1.4,
        // ),
        // mainTitle: TextStyle(
        //   fontSize: 35.0,
        //   fontFamily: family,
        //   fontWeight: FontWeight.w500,
        //   color: secondaryVariant,
        //   height: 1.4,
        // ),
        bodyText1: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryVariant,
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 25.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: secondaryVariant,
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(mainColor),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
          height: 1.4,
        ),
        button: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );

    darkTheme = ThemeData(
      scaffoldBackgroundColor: HexColor(scaffoldBackground),
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : SystemUiOverlayStyle(
                statusBarColor: HexColor(scaffoldBackground),
                statusBarIconBrightness: Brightness.light,
              ),
        backgroundColor: HexColor(scaffoldBackground),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: HexColor(grey),
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor(scaffoldBackground),
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(grey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        // headline5: TextStyle(
        //   fontSize: 24.0,
        //   fontFamily: family,
        //   fontWeight: FontWeight.w400,
        //   color: HexColor(secondaryDark),
        //   height: 1.4,
        // ),
        headline6: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: HexColor(surface),
          height: 1.3,
        ),
        // mainTitle: TextStyle(
        //   fontSize: 35.0,
        //   fontFamily: family,
        //   fontWeight: FontWeight.w500,
        //   color: secondaryVariant,
        //   height: 1.4,
        // ),
        // appbarTitle: TextStyle(
        //   fontSize: 25.0,
        //   fontFamily: family,
        //   fontWeight: FontWeight.w500,
        //   color: secondaryVariant,
        //   height: 1.4,
        // ),
        bodyText1: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(surface),
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 25.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(surface),
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(surface),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(surface),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(surface),
          height: 1.4,
        ),
        button: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(surface),
          height: 1.4,
        ),
      ),
    );
  }

  void changeMode({required bool value}) {
    isDark = value;

    sl<CacheHelper>().put('isDark', isDark);

    emit(ChangeModeState());
  }

  void changeLanguage({required bool value}) async {
    isRtl = value;

    sl<CacheHelper>().put('isRtl', isRtl);

    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

    setTranslation(
      translation: translation,
    );

    changeTheme();

    emit(ChangeLanguageState());
  }

  late TranslationModel translationModel;

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));

    emit(LanguageLoaded());
  }

  bool noInternetConnection = false;

  void checkConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      debugPrint('Internet Connection ------------------------');
      debugPrint('${result.index}');
      debugPrint(result.toString());
      if (result.index == 0 || result.index == 1) {
        noInternetConnection = false;
      } else if (result.index == 2) {
        noInternetConnection = true;
      }

      emit(InternetState());
    });
  }

  void checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      noInternetConnection = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      noInternetConnection = false;
    } else {
      noInternetConnection = true;
    }
    emit(InternetState());
  }

  // PickedFile? imageFile;
  //
  // void openGallery(BuildContext context) async {
  //   await ImagePicker()
  //       .getImage(
  //     source: ImageSource.gallery,
  //   )
  //       .then((value) {
  //     imageFile = value;
  //     emit(ChangeImageSuccessState());
  //   }).catchError((onError) {
  //     debugPrint(onError.toString());
  //     emit(ChangeImageLoadingState());
  //   });
  //   Navigator.pop(context);
  // }
  //
  // void openCamera(BuildContext context) async {
  //   await ImagePicker()
  //       .getImage(
  //     source: ImageSource.camera,
  //   )
  //       .then((value) {
  //     imageFile = value;
  //     emit(ChangeImageSuccessState());
  //   }).catchError((onError) {
  //     debugPrint(onError.toString());
  //     emit(ChangeImageLoadingState());
  //   });
  //   Navigator.pop(context);
  // }

  ///TODO pick photo ------------ start
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  void selectImage(context) async {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      imageFile = File(value!.path);
      emit(PickImageSuccessState());
    });
    Navigator.pop(context);
  }

  void selectCamera(context) async {
    _picker.pickImage(source: ImageSource.camera).then((value) {
      imageFile = File(value!.path);
      emit(PickImageSuccessState());
    });

    Navigator.pop(context);
  }

  void clearSelectedImage() {
    imageFile = null;
    emit(ClearImageSuccessState());
  }

  ///TODO pick photo ------------ end

  // login ------------------- start

  bool userSigned = false;

  void changeUser(bool user) {
    userSigned = user;
    emit(SignInState());
  }

  LoginModel? loginModel;

  void login({
    required String email,
    required String password,
  }) async {
    debugPrint('login------------loading');
    emit(LoginLoading());
    await _repository.login(email: email, password: password).then((value) {
      // success
      debugPrint(value.data['message']);
      debugPrint('success');
      loginModel = LoginModel.fromJson(value.data);
      changeUser(true);
      currentIndex = 0;
      debugPrint('login------------success');
      token = loginModel!.token;
      getUserDate();
      getSavedBooks();
      emit(LoginSuccess(loginModel: loginModel!));
      CacheHelper2.saveData(key: 'password', value: password);
      sl<CacheHelper>().put('email', loginModel!.user!.email);
    }).catchError((error) {
      // error
      debugPrint(error.toString());
      debugPrint('login------------error');
      emit(Error(error.toString()));
    });
  }

// login ------------------- end

  // logOut ------------------- start

  void logOut({required BuildContext context}) async {
    emit(LogoutLoading());
    await _repository.logOut().then((value) {
      // success
      signOut(context);
      changeUser(false);
      profileModel = null;
      savedBooksModel = null;
      emit(LogoutSuccess());
    }).catchError((error) {
      // error
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// logOut ------------------- end

  num appBarHeight = AppBar().preferredSize.height;

  var currentMonth = DateTime.now().month;

  void setSelectedMonth(int value) {
    currentMonth = value;
    emit(SelectMonth(value: currentMonth));
  }

  int currentDay = 0;

  void setSelectedDay(int value) {
    currentDay = value;
    emit(SelectDay(value: currentDay));
  }

  // topBorrow ------------------- start

  TopBorrowModel? topBorrowModel;
  List paginationBooks = [];
  int pageCounter = 1;

  void topBorrow({
    required bool isFirst,
    TopBorrowModel? model,
  }) async {
    if (isFirst) {
      pageCounter = 1;
      paginationBooks = [];
      emit(TopBorrowLoading());
    } else {
      pageCounter++;
      emit(SetPaginationLoading());
    }
    if (model != null) {
      for (var element in model.books) {
        paginationBooks.add(element);
        emit(TopBorrowSuccess());
      }
    } else {
      print('paginationBooks: ${paginationBooks.length}');
      print('pageCounter: $pageCounter');
      debugPrint('topBorrow------------loading');

      await _repository.topBorrowRepo(page: pageCounter).then((value) {
        // success
        if (isFirst) {
          topBorrowModel = TopBorrowModel.fromJson(value.data);
        }
        for (var element in TopBorrowModel.fromJson(value.data).books) {
          paginationBooks.add(element);
        }
        debugPrint('topBorrow------------success');
        emit(TopBorrowSuccess());
      }).catchError((error) {
        // error
        debugPrint('topBorrow------------error');
        debugPrint(error.toString());
        emit(Error(error.toString()));
      });
    }
  }

// topBorrow ------------------- end

  // bookDetails ------------------- start

  BookDetailsModel? bookModel;

  void bookDetails({required String bookId}) async {
    debugPrint('bookDetails------------loading');
    bookModel = null;
    emit(BookDetailsLoading());
    await _repository
        .bookDetailsRepo(
      bookId: bookId,
    )
        .then((value) {
      // success
      bookModel = BookDetailsModel.fromJson(value.data);
      debugPrint(bookModel!.book.bookImage);
      debugPrint('bookDetails------------success');
      emit(BookDetailsSuccess());
    }).catchError((error) {
      // error
      debugPrint('bookDetails------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

  // bookDetails ------------------- end

  // categories ------------------- start

  CategoriesModel? categoriesModel;

  void categories({
    required String library,
    required String type,
  }) async {
    debugPrint('categories------------loading');
    emit(CategoriesLoading());
    await _repository
        .categoriesRepo(library: library, type: type)
        .then((value) {
      // success
      categoriesModel = CategoriesModel.fromJson(value.data);
      debugPrint('categories------------success');
      emit(CategoriesSuccess());
    }).catchError((error) {
      // error
      debugPrint('categories------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

  // categories ------------------- end

  // categoryDetails ------------------- start

  TopBorrowModel? categoryDetailsModel;

  void categoryDetails({
    required String categoryName,
    required String library,
    required String type,
  }) async {
    debugPrint('categoryDetails------------loading');
    emit(CategoryLoading());
    await _repository
        .categoryDetailsRepo(
            categoryName: categoryName, library: library, type: type)
        .then((value) {
      // success
      categoryDetailsModel = TopBorrowModel.fromJson(value.data);
      debugPrint('categoryDetails------------success');
      emit(CategorySuccess());
    }).catchError((error) {
      // error
      debugPrint('categoryDetails------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// categoryDetails ------------------- end

  // categoryDetails ------------------- start

  TopBorrowModel? categoryDetailsModelHti;

  void categoryDetailsHti({
    required String categoryName,
    required String library,
    required String type,
  }) async {
    debugPrint('categoryDetails------------loading');
    emit(CategoryLoading());
    await _repository
        .categoryDetailsRepo(
            categoryName: categoryName,
            library: 'hti matrial',
            type: 'hti matrial')
        .then((value) {
      // success
      categoryDetailsModelHti = TopBorrowModel.fromJson(value.data);
      debugPrint('categoryDetails------------success');
      emit(CategorySuccess());
    }).catchError((error) {
      // error
      debugPrint('categoryDetails------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// categoryDetails ------------------- end

  /// start project exit .
  TopBorrowModel? categoriesModelProject;

  void categoryProject({
    required String categoryName,
    required String library,
    required String type,
  }) async {
    debugPrint('categoriesModelProject------------loading');
    emit(CategoryLoading());
    await _repository
        .categoryDetailsRepo(
            categoryName: 'graduation projects', library: library, type: type)
        .then((value) {
      // success
      categoriesModelProject = TopBorrowModel.fromJson(value.data);
      debugPrint('categoriesModelProject------------success');
      emit(CategorySuccess());
    }).catchError((error) {
      // error
      debugPrint('categoriesModelProject------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

  // end project exit .

  // getNotifications ------------------- start

  NotificationModel? getNotificationsModel;

  Future<void> getNotifications() async {
    debugPrint('getNotifications------------loading');
    emit(NotificationLoading());
    await _repository.getNotificationsRepo().then((value) {
      // success
      getNotificationsModel = NotificationModel.fromJson(value.data);
      debugPrint('getNotifications------------success');
      print(getNotificationsModel!.notifications.length);
      print(value.data['notifications']);
      emit(NotificationSuccess());
    }).catchError((error) {
      // error
      debugPrint('getNotifications------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// getNotifications ------------------- end

  // getNotifications ------------------- start
  NotificationModel? removeNotificationsModel;

  void removeNotifications() async {
    debugPrint('getNotifications------------loading');
    emit(NotificationLoading());
    await _repository.removeNotificationsRepo().then((value) {
      // success
      removeNotificationsModel = NotificationModel.fromJson(value.data);
      debugPrint('getNotifications------------success');
      // print(getNotificationsModel!.notifications.length);
      // print(value.data['notifications']);
      getNotifications();
      emit(NotificationSuccess());
    }).catchError((error) {
      // error
      debugPrint('getNotifications------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// getNotifications ------------------- end

  // getSavedBooksModel ------------------- start

  GetSavedBooksModel? savedBooksModel;

  void getSavedBooks() async {
    if (userSigned) {
      debugPrint('getSavedBooks------------loading');
      emit(SavedBooksLoading());
      await _repository.booksSavedRepo().then((value) {
        // success
        savedBooksModel = GetSavedBooksModel.fromJson(value.data);
        debugPrint('getSavedBooks------------success');
        // print(savedBooksModel!.books![0].name);
        emit(SavedBooksSuccess());
      }).catchError((error) {
        // error
        debugPrint('getSavedBooks------------error');
        debugPrint(error.toString());
        emit(Error(error.toString()));
      });
    }
  }

// getSavedBooksModel ------------------- end

  // removeSavedBooksModel ------------------- start

  RemoveSavedBooksModel? removeSavedBooksModel;

  void postRemoveBookSave({
    required String bookID,
  }) async {
    debugPrint('removeBookSave------------loading');
    emit(RemoveSavedBooksLoading());
    await _repository.removeSaveBookRepo(bookID: bookID).then((value) {
      // success
      // removeSavedBooksModel = RemoveSavedBooksModel.fromJson(value.data);
      debugPrint('removeBookSave------------success');
      // print(removeSavedBooksModel!.message);
      emit(RemoveSavedBooksSuccess());
      getSavedBooks();
    }).catchError((error) {
      // error
      debugPrint('removeBookSave------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// removeSavedBooksModel ------------------- end
  /// getUserDate ------------------- start
  ProfileModel? profileModel;

  void getUserDate() async {
    if (userSigned) {
      debugPrint('getUserDate------------loading');
      emit(GetUserDataLoading());
      await _repository.getUserDateRepo().then((value) {
        // success
        profileModel = ProfileModel.fromJson(value.data);

        debugPrint(profileModel!.avatar);
        debugPrint('getUserDate------------success');
        emit(GetUserDataSuccess());
      }).catchError((error) {
        // error
        debugPrint('getUserDate------------error');
        debugPrint(error.toString());
        emit(Error(error.toString()));
      });
    }
  }

// getUserDate ------------------- end

  // SavedBooksModel ------------------- start

  void postSaveBook({
    required String bookID,
  }) async {
    debugPrint('postSaveBook------------loading');
    emit(PostSavedBooksLoading());
    await _repository.saveBooksRepo(bookID: bookID).then((value) {
      // success
      // removeSavedBooksModel = RemoveSavedBooksModel.fromJson(value.data);
      debugPrint('postSaveBook------------success');
      // print(removeSavedBooksModel!.message);
      emit(PostSavedBooksSuccess(value.data['message']));
      getSavedBooks();
    }).catchError((error) {
      // error
      debugPrint('postSaveBook------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// SavedBooksModel ------------------- end

  // postBorrowBook ------------------- start
  SavedBooksModel? borrowBookModel;

  void postBorrowBook({
    required String bookID,
  }) async {
    debugPrint('postBorrowBook------------loading');
    emit(PostBorrowingBooksLoading());
    await _repository.postBorrowBookRepo(bookID: bookID).then((value) {
      // success
      borrowBookModel = SavedBooksModel.fromJson(value.data);
      debugPrint('postBorrowBook------------success');
      emit(PostBorrowingBooksSuccess(value.data['message']));
    }).catchError((error) {
      // error
      debugPrint('postBorrowBook------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// postBorrowBook ------------------- end

  // chickTime ------------------- start

  void chickTime({
    required String userID,
  }) async {
    if (userSigned) {
      debugPrint('chickTime------------loading');
      emit(ChickTimeLoading());
      await _repository.chickTimeRepo(userID: userID).then((value) {
        // success
        debugPrint('chickTime------------success');
        emit(ChickTimeSuccess());
      }).catchError((error) {
        // error
        debugPrint('chickTime------------error');
        debugPrint(error.toString());
        emit(Error(error.toString()));
      });
    }
  }

// chickTime ------------------- end

  // AllReturned ------------------- start

  GetAllReturnedBooks? allReturnedBook;

  void getAllReturned(
      {required bool isFirst, GetAllReturnedBooks? data}) async {
    if (isFirst) {
      pageCounter = 1;
      paginationBooks = [];
      emit(AllReturnedLoading());
    } else {
      pageCounter++;
      emit(SetPaginationLoading());
    }
    if (data != null) {
      for (var element in data.books) {
        paginationBooks.add(element);
        emit(AllReturnedSuccess());
      }
    } else {
      debugPrint('getAllReturned------------loading');
      await _repository.getAllReturnedRepo(page: pageCounter).then((value) {
        // success
        debugPrint('getAllReturned------------success');

        if (isFirst) {
          allReturnedBook = GetAllReturnedBooks.fromJson(value.data);
        }
        for (var element in GetAllReturnedBooks.fromJson(value.data).books) {
          paginationBooks.add(element);
        }
        emit(AllReturnedSuccess());
      }).catchError((error) {
        // error
        debugPrint('getAllReturned------------error');
        debugPrint(error.toString());
        emit(Error(error.toString()));
      });
    }
  }

// AllReturned ------------------- end

  // AllReturned ------------------- start

  TopBorrowModel? myReturnedBooks;

  void getMyReturned() async {
    if (userSigned) {
      debugPrint('getMyReturned------------loading');
      emit(MyReturnedLoading());
      await _repository.getMyReturnedBooksRepo().then((value) {
        // success
        debugPrint('getMyReturned------------success');
        myReturnedBooks = TopBorrowModel.fromJson(value.data);
        emit(MyReturnedSuccess());
      }).catchError((error) {
        // error
        debugPrint('getMyReturned------------error');
        debugPrint(error.toString());
        emit(Error(error.toString()));
      });
    }
  }

// AllReturned ------------------- end

  // myBorrowBook ------------------- start

  MyBorrowBookModel? myBorrowBooks;

  void getMyBorrow({
    required int page,
  }) async {
    debugPrint('getMyBorrow------------loading');
    emit(MyBorrowBookLoading());
    await _repository.myBorrowBooksRepo(page: page).then((value) {
      // success
      debugPrint('getMyBorrow------------success');
      myBorrowBooks = MyBorrowBookModel.fromJson(value.data);
      emit(MyBorrowBookSuccess());
    }).catchError((error) {
      // error
      debugPrint('getMyBorrow------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// myBorrowBook ------------------- end

  // LastSearch ------------------- start

  LastSearchModel? lastSearchModel;

  void lastSearch() async {
    if (userSigned) {
      debugPrint('lastSearch------------loading');
      emit(LastSearchLoading());
      await _repository.getMyLastSearchRepo().then((value) {
        // success
        debugPrint('lastSearch------------success');
        lastSearchModel = LastSearchModel.fromJson(value.data);
        emit(LastSearchSuccess());
      }).catchError((error) {
        // error
        debugPrint('lastSearch------------error');
        debugPrint(error.toString());
        emit(Error(error.toString()));
      });
    }
  }

// LastSearch ------------------- end

  // Search ------------------- start
  TextEditingController searchController = TextEditingController();

  SearchModel? searchModel;

  void getSearch({
    required String word,
  }) async {
    if (userSigned) {
      debugPrint('getSearch------------loading');
      emit(SearchLoading());
      await _repository.searchRepo(word: word).then((value) {
        // success

        searchModel = SearchModel.fromJson(value.data);
        debugPrint('getSearch------------loading ');
        emit(SearchSuccess());
      }).catchError((error) {
        // error
        debugPrint('getSearch------------error');
        debugPrint(error.toString());
        emit(Error(error.toString()));
      });
    }
  }

// Search ------------------- end

  /// userAvatar ------------------- start

  void userAvatar() async {
    if (userSigned) {
      debugPrint('userAvatar------------loading');
      emit(UserAvatarLoading());
      await _repository.userAvatarRepo(image: imageFile).then((value) {
        // success
        debugPrint('userAvatar ------------ success');
        emit(UserAvatarSuccess());
        getUserDate();
      }).catchError((error) {
        // error
        debugPrint('userAvatar------------error');
        debugPrint(error.toString());
        emit(Error(error.toString()));
      });
    }
  }

// userAvatar ------------------- end

  /// get All Type ------------------- start
  AllTypeModel? allTypeModel;

  void getAllType({
    required String library,
    required int page,
  }) async {
    debugPrint('getAllLibrary------------loading');
    emit(GetTypeLoading());
    await _repository
        .getAllTypeRepo(library: library, page: page)
        .then((value) {
      // success
      allTypeModel = AllTypeModel.fromJson(value.data);
      debugPrint('getAllLibrary ------------ success');
      emit(GetTypeSuccess());
    }).catchError((error) {
      // error
      debugPrint('getAllLibrary------------error');
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// get All Type ------------------- end

  /// ----------------------- finger Print - start
  final FingerPrint _fingerPrint = FingerPrint();

  void enableFinger() async {
    isSwitch = !isSwitch;
    if (isSwitch) {
      bool isFingerEnabled = await _fingerPrint.isFingerPrintEnable();
      if (isFingerEnabled) {
        CacheHelper2.saveData(
            key: 'email', value: profileModel!.email.split('@')[0]);
        sl<CacheHelper>().put('finger', true);
      }
    } else {
      CacheHelper2.removeData(key: 'email');
      sl<CacheHelper>().put('finger', false);
    }
    print(
        'mail ------------------------------ ${CacheHelper2.getData(key: 'email')}');
    print(
        'pass ------------------------------ ${CacheHelper2.getData(key: 'password')}');
    print('finger ------------------------------ $isSwitch');
    emit(FingerPrintSuccess());
  }

  // ----------------------- finger Print - end

  /// ----------------------- return back abd save data - start
  void backScreen(BuildContext context) {
    sl<CacheHelper>()
        .put('isReadPolicy', true)
        .then((value) => isReadPolicy = value);
    Navigator.of(context).pop();
    emit(ChangeReadSuccess());
  }

// ----------------------- return back abd save data - end

  /// ----------------------- firebase (Start)
  ///
  List<MessageModel> messages = [];

  void sendMessage(MessageModel message) async {
    // go collection users_instagram +
    await FirebaseFirestore.instance
        .collection("users")
        // sendId to user (unique every user)
        .doc(profileModel!.email)
        // collection chats
        .collection("chats")
        // receiveId to user (unique every user)
        .doc('admin')
        // message collection
        .collection("messages")
        // messageId .
        .doc(message.messageId)
        // set data .
        .set(message.toJson());

    uploadData();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(message.reciverId)
        .collection("chats")
        .doc(message.senderId)
        .collection("messages")
        .doc(message.messageId)
        .set(message.toJson());

    emit(SendMessageSuccess());
  }

  bool isLoad = false;
  void getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(profileModel!.email)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy('time')
        .get()
        .then((value) {
      messages.clear();

      for (var element in value.docs) {
        MessageModel message = MessageModel.fromJson(element.data());
        messages.add(message);
      }
      isLoad = true;
      emit(GetMessagesSuccessState());
      print('messagw ---------------- ${messages.length}');
    });
  }

  void listenToMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(profileModel!.email)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        // sort data
        .orderBy("time")
        // stream snapshots
        .snapshots()
        // listen to message .
        .listen((event) {
      // messages.clear();

      print('Docs => ${event.docs.length}');

      // another method
      // MessageModel message = MessageModel.fromJson(event.docs[0].data());
      for (var element in event.docs) {
        MessageModel model = MessageModel.fromJson(element.data());
        messages.add(model);
      }
      emit(GetMessagesSuccessState());
    });
  }

  void uploadData() {
    UserModelFirebase model = UserModelFirebase(
        email: profileModel!.email.split('@')[0],
        name: profileModel!.name,
        phone: profileModel!.phone,
        avatar: profileModel!.avatar);

    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set(model.toMap())
        .then((value) {
      UserUploadDataSuccess();
    }).catchError((error) {
      emit(UserUploadDataError());
    });
  }

// ----------------------- firebase (end)

}
