import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/di/injection.dart';
import 'package:hti_library/core/error/exceptions.dart';
import 'package:hti_library/core/models/login_model.dart';
import 'package:hti_library/core/network/local/cache_helper.dart';
import 'package:hti_library/core/network/repository.dart';
import 'package:hti_library/core/util/cubit/state.dart';
import 'package:hti_library/core/util/translation.dart';
import 'package:image_picker/image_picker.dart';

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

  void bottomChanged(int index) {
    if (index == 3) {
      currentIndex = index;
      emit(BottomChanged());
    }

    currentIndex = index;

    emit(BottomChanged());
  }

  // dark colors
  String scaffoldBackground = '333739';

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

    print('dark mode ------------- $isDark');

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
        headline5: TextStyle(
          fontSize: 24.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
          height: 1.4,
        ),
        headline6: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
          height: 1.4,
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryVariant,
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: secondaryVariant,
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 11.0,
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
        headline5: TextStyle(
          fontSize: 24.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        headline6: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariantDark),
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariantDark),
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 11.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
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
  }

  void changeMode() {
    isDark = !isDark;

    sl<CacheHelper>().put('isDark', isDark);

    emit(ChangeModeState());
  }

  void changeLanguage() async {
    isRtl = !isRtl;

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

    // if(translation == null) {
    //   translationModel = TranslationModel.fromJson(json.decode(
    //     _translation,
    //   ));
    // } else {
    //   translationModel = TranslationModel.fromJson(json.decode(
    //     translation,
    //   ));
    // }

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

  PickedFile? imageFile = null;

  void openGallery(BuildContext context) async {
    await ImagePicker()
        .getImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      imageFile = value;
      emit(ChangeImageSuccessState());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(ChangeImageLoadingState());
    });
    Navigator.pop(context);
  }

  void openCamera(BuildContext context) async {
    await ImagePicker()
        .getImage(
      source: ImageSource.camera,
    )
        .then((value) {
      imageFile = value;
      emit(ChangeImageSuccessState());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(ChangeImageLoadingState());
    });
    Navigator.pop(context);
  }

  ///TODO pick photo ------------ start
  // final ImagePicker _picker = ImagePicker();
  // File? imageFile;
  //
  // void selectImage() async {
  //   _picker.pickImage(source: ImageSource.gallery).then((value) {
  //     imageFile = File(value!.path);
  //   });
  //
  //   emit(PickImageSuccessState());
  // }
  //
  // File? cameraFile;
  //
  // void selectCamera() async {
  //   _picker.pickImage(source: ImageSource.camera).then((value) {
  //     cameraFile = File(value!.path);
  //   });
  //
  //   emit(PickImageSuccessState());
  // }
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
    emit(LoginLoading());
    await _repository.login(email: email, password: password).then((value) {
      // success
      debugPrint(value.data['message']);
      debugPrint('success');
      loginModel = LoginModel.fromJson(value.data);
      changeUser(true);
      currentIndex = 0;
      emit(LoginSuccess(loginModel: loginModel!));
    }).catchError((error) {
      // error
      debugPrint(error.toString());
      debugPrint('error');
      ServerException exception = error as ServerException;
      debugPrint(exception.error);
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
      emit(LogoutSuccess());
    }).catchError((error) {
      // error
      debugPrint(error.toString());
      emit(Error(error.toString()));
    });
  }

// logOut ------------------- end

// // changeMode ------------------- start
//
//   void changeMode() {
//     isDark = !isDark;
//
//     sl<CacheHelper>().put('isDark', isDark);
//
//     emit(ChangeModeState());
//   }
//
//   // changeMode ------------------- end
//
//   // changeLanguage ------------------- start
//
//   late TranslationModel translationModel;
//
//   void setTranslation({
//     required String translation,
//   }) {
//     translationModel = TranslationModel.fromJson(json.decode(
//       translation,
//     ));
//
//     emit(LanguageLoaded());
//   }
//
//   void changeLanguage() async {
//     isRtl = !isRtl;
//
//     sl<CacheHelper>().put('isRtl', isRtl);
//
//     String translation = await rootBundle
//         .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');
//
//     setTranslation(
//       translation: translation,
//     );
//
//     changeTheme();
//
//     emit(ChangeLanguageState());
//   }
// // changeLanguage ------------------- end

  num appBarHeight = AppBar().preferredSize.height ;
}

//   CategoriesModel? categoriesModel;
//
//   void getCategories() async {
//     emit(CategoriesLoadingState());
//
//     await _repository.getCategories().then((value) {
//       categoriesModel = CategoriesModel.fromJson(value.data);
//       emit(
//         CategoriesSuccessState(),
//       );
//     }).catchError((error) {
//       debugPrint('can not get categories');
//       debugPrint(error.toString());
//       emit(Error());
//     });
//   }
//
//   BrandsModel? brandsModel;
//
//   void getBrands() async {
//     await _repository.getBrands().then((value) {
//       brandsModel = BrandsModel.fromJson(value.data);
//       debugPrint('brands ------------------------------------------------------');
//       debugPrint(brandsModel!.brands.brands[0].image);
//       emit(
//         HomeSuccessState(),
//       );
//     }).catchError((error) {
//       emit(HomeErrorState());
//     });
//   }
//
//   BlogModel? bLogModel;
//
//   void getBlogs() async {
//     emit(BlogsLoadingState());
//     await _repository.getBlogs().then((value) {
//       bLogModel = BlogModel.fromJson(value.data);
//       debugPrint('blogs ------------------------------------------------------');
//       debugPrint(bLogModel!.data.blog[0].title);
//       emit(BlogsSuccessState());
//     }).catchError((error) {
//       emit(Error());
//     });
//   }
//
//   HomeFeedModel? homeFeedModel;
//
//   void getHomeFeed() async {
//     emit(HomeLoadingState());
//
//     await _repository.getHome().then((value) {
//       debugPrint('home --------');
//       debugPrint(value.data);
//       homeFeedModel = HomeFeedModel.fromJson(value.data);
//       emit(
//         HomeSuccessState(),
//       );
//     }).catchError((error) {
//       emit(Error());
//     });
//   }
//
// // wishlist ---------------- start
//
//   List<int> wishlistId = [];
//
//   WishlistModel? wishlistModel;
//
//   void getWishListModel() async {
//     if (userSigned) {
//       emit(WishlistLoadingState());
//       await _repository.getWishList().then((value) {
//         debugPrint('wishlis --------');
//         debugPrint(value.data);
//         wishlistModel = WishlistModel.fromJson(value.data);
//         for (var element in wishlistModel!.products) {
//           if(!wishlistId.contains(element.id)) {
//             wishlistId.add(element.id);
//           }
//         }
//         emit(
//           WishlistSuccessState(),
//         );
//       }).catchError((error) {
//         debugPrint('Wishlist Error -------- ${error.toString()}');
//         emit(WishlistErrorState());
//       });
//     }
//   }
//
//   void addToWishList(
//       {required int productId, required BuildContext context}) async {
//     if (wishlistId.contains(productId)) {
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return TwoOptionsDialog(
//               pushButtonVoidCallback: () {
//                 debugPrint(wishlistId.toString());
//
//                 wishlistId.remove(productId);
//
//                 debugPrint(wishlistId.toString());
//
//                 removeFromWishList(productId: productId);
//                 Navigator.pop(context);
//               },
//               popButtonVoidCallback: () {
//                 Navigator.pop(context);
//               },
//               message: appTranslation(context).are_you_sure_to_remove,
//               // title: 'title',
//               pushButtonText: appTranslation(context).remove,
//               popButtonText: appTranslation(context).cancel,
//             );
//           });
//     } else {
//       wishlistId.add(productId);
//       emit(WishlistLoadingState());
//       await _repository.addToWishList(productId: productId).then((value) {
//         debugPrint('wishlis --------');
//         debugPrint(value.data);
//         getWishListModel();
//       }).catchError((error) {
//         emit(WishlistErrorState());
//       });
//     }
//   }
//
//   void removeFromWishList({required int productId}) async {
//     emit(WishlistLoadingState());
//
//     await _repository.deleteFromWishList(productId: productId).then((value) {
//       debugPrint('wishlis --------');
//       debugPrint(value.data);
//       getWishListModel();
//     }).catchError((error) {
//       emit(WishlistErrorState());
//     });
//   }
//
//   // wishlist ---------------- start
//
// // change grid to list ---------------- start
//   bool gridNotList = true;
//
//   void changeGridToList(bool value) {
//     gridNotList = value;
//     emit(ChangeGridToList());
//   }
//
// // change grid to list ---------------- end
//
// // login ---------------- start
//
//   SimpleModel? simpleModelLogin;
//
//   void login({
//     required String email,
//     required String password,
//   }) async {
//     emit(LoginLoading());
//     await _repository.login(email: email, password: password).then((value) {
//       simpleModelLogin = SimpleModel.fromJson(value.data);
//       // debugPrint('login ------------------------------------------------------');
//       // debugPrint(simpleModelLogin!.token);
//       // debugPrint(simpleModelLogin!.status);
//       token = simpleModelLogin!.token;
//       userSigned = true;
//       getWishListModel();
//       getAccount();
//       emit(LoginSuccess(simpleModelLogin!));
//     }).catchError((error) {
//       debugPrint(
//           'login error ------------------------------------------------------');
//       debugPrint(error.toString());
//       debugPrint(
//           'login error ------------------------------------------------------');
//       emit(Error());
//     });
//   }
//
// // login ---------------- end
//
//   // register ---------------- start
//
//   SimpleModel? simpleModelRegister;
//
//   void register({
//     required String name,
//     required String phone,
//     required String email,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     emit(RegisterLoading());
//     await _repository
//         .register(
//       name: email,
//       phone: email,
//       email: email,
//       password: password,
//       confirmPassword: confirmPassword,
//     )
//         .then((value) {
//       simpleModelRegister = SimpleModel.fromJson(value.data);
//       debugPrint('register ------------------------------------------------------');
//       debugPrint(simpleModelRegister!.status);
//       emit(RegisterSuccess(simpleModelRegister!));
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(
//           'error is here ------------------------------------------------------');
//       emit(Error());
//     });
//   }
//
// // register ---------------- end
//
//   //product details----------------------start
//
//   int currentSize = -1;
//
//   void selectSize(int index) {
//     currentSize = index;
//
//     num sizePrice =
//         productFeedModel!.data.product.size_attributes![currentSize].price;
//
//     storedPrice = productFeedModel!.data.product.price;
//
//     if (currentColor != -1) {
//       num colorPrice =
//           productFeedModel!.data.product.color_attributes![currentColor].price;
//
//       if (colorPrice > sizePrice) {
//         productFeedModel!.data.product.price = colorPrice.toString();
//         productMainPrice = colorPrice.toString();
//       } else {
//         productFeedModel!.data.product.price = sizePrice.toString();
//         productMainPrice = sizePrice.toString();
//       }
//     } else {
//       productFeedModel!.data.product.price = sizePrice.toString();
//       productMainPrice = sizePrice.toString();
//     }
//
//     itemCount = 1;
//
//     emit(SelectSize());
//   }
//
//   int currentColor = -1;
//
//   List<String> storedGallery = [];
//   String storedImage = '';
//   String storedPrice = '';
//
//   void selectColor(int index) {
//     currentColor = index;
//
//     num colorPrice =
//         productFeedModel!.data.product.color_attributes![currentColor].price;
//     String colorImage =
//         productFeedModel!.data.product.color_attributes![currentColor].image;
//     // String colorImage = productFeedModel!.data.product
//     //     .color_attributes![currentColor].image;
//
//     storedPrice = productFeedModel!.data.product.price;
//
//     if (currentSize != -1) {
//       num sizePrice =
//           productFeedModel!.data.product.size_attributes![currentSize].price;
//
//       if (colorPrice > sizePrice) {
//         productFeedModel!.data.product.price = colorPrice.toString();
//         productMainPrice = colorPrice.toString();
//       } else {
//         productFeedModel!.data.product.price = sizePrice.toString();
//         productMainPrice = sizePrice.toString();
//       }
//     } else {
//       productFeedModel!.data.product.price = colorPrice.toString();
//       productMainPrice = colorPrice.toString();
//     }
//
//     if (productFeedModel!.data.product.gallery != null) {
//       debugPrint('has a gallery');
//
//       productFeedModel!.data.product.gallery!.clear();
//       productFeedModel!.data.product.gallery!.add(colorImage);
//     } else {
//       debugPrint('has an image');
//
//       productFeedModel!.data.product.image = colorImage;
//     }
//
//     itemCount = 1;
//
//     emit(SelectColor());
//   }
//
//   void clearVariations() {
//     currentColor = -1;
//     currentSize = -1;
//
//     productFeedModel!.data.product.price = storedPrice;
//     productMainPrice = storedPrice;
//
//     debugPrint(storedImage);
//     debugPrint(storedGallery);
//
//     productFeedModel!.data.product.image = storedImage;
//     productFeedModel!.data.product.gallery = storedGallery;
//     itemCount = 1;
//
//     emit(ClearVariationsState());
//   }
//
//   int itemCount = 1;
//
//   void addition() {
//     if (productFeedModel!.data.product.quantityInStock == itemCount) {
//       itemCount = productFeedModel!.data.product.quantityInStock;
//     } else {
//       itemCount++;
//       productFeedModel!.data.product.price =
//           (int.parse(productFeedModel!.data.product.price) +
//                   int.parse(productMainPrice))
//               .toString();
//       productFeedModel!.data.product.price =
//           (int.parse(productFeedModel!.data.product.price) +
//                   int.parse(productMainPrice))
//               .toString();
//       emit(Addition());
//     }
//   }
//
//   void subtraction() {
//     if (itemCount <= 1) {
//       itemCount = 1;
//     } else {
//       itemCount--;
//       productFeedModel!.data.product.price =
//           (int.parse(productFeedModel!.data.product.price) -
//                   int.parse(productMainPrice))
//               .toString();
//       productFeedModel!.data.product.price =
//           (int.parse(productFeedModel!.data.product.price) -
//                   int.parse(productMainPrice))
//               .toString();
//     }
//     emit(Subtraction());
//   }
//
//   void cartAddition({
//     required int id,
//   }) {
//     if (cartMap[id]!.quantity < cartMap[id]!.stock) {
//       cartMap[id]!.quantity = cartMap[id]!.quantity + 1;
//
//       for (int i = 0; i < cartListData!.length; i++) {
//         if (cartListData![i].id == id) {
//           cartListData![i] = cartMap[id]!;
//         }
//       }
//
//       MainCartModel model = MainCartModel(
//         data: cartListData!,
//       );
//
//       sl<CacheHelper>()
//           .put(
//         'cart',
//         model.toJson(),
//       )
//           .then((value) {
//         debugPrint('cart inserted !!!');
//       });
//     }
//
//     sumSubTotalCart();
//
//     emit(CartAddition());
//   }
//
//   void cartSubtraction({
//     required int id,
//   }) {
//     if (cartMap[id]!.quantity > 1) {
//       cartMap[id]!.quantity = cartMap[id]!.quantity - 1;
//
//       for (int i = 0; i < cartListData!.length; i++) {
//         if (cartListData![i].id == id) {
//           cartListData![i] = cartMap[id]!;
//         }
//       }
//
//       MainCartModel model = MainCartModel(
//         data: cartListData!,
//       );
//
//       sl<CacheHelper>()
//           .put(
//         'cart',
//         model.toJson(),
//       )
//           .then((value) {
//         debugPrint('cart inserted !!!');
//       });
//     }
//
//     sumSubTotalCart();
//
//     emit(CartSubtraction());
//   }
//
//   num subtotalCart = 0;
//
//   void sumSubTotalCart() {
//     subtotalCart = 0;
//
//     cartMap.forEach((key, value) {
//       subtotalCart = subtotalCart + (value.quantity * int.parse(value.price));
//     });
//
//     emit(CartSubTotal());
//   }
//
//   Map<int, CartModel> cartMap = {};
//
//   void fillCartMap() {
//     if (cartListData != null && cartListData!.isNotEmpty) {
//       for (var element in cartListData!) {
//         cartMap.addAll({
//           element.id: element,
//         });
//       }
//
//       sumSubTotalCart();
//
//       emit(FillCartMapState());
//     }
//   }
//

//
//   void checkInternet() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.mobile) {
//       noInternetConnection = false;
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       noInternetConnection = false;
//     } else {
//       noInternetConnection = true;
//     }
//     emit(InternetState());
//   }
//
//   void removeFromCartMap(int id) {
//     cartMap.removeWhere((key, value) => key == id);
//
//     emit(RemoveFromCartMapState());
//   }
//
//   void addToCartMap(CartModel model) {
//     cartMap.addAll({
//       model.id: model,
//     });
//
//     emit(AddToCartMapState());
//   }
//
//   ProductFeedModel? productFeedModel;
//   String productMainPrice = '';
//
//   // bool isProductInCart = false;
//
//   void getProductFeed({
//     required String slug,
//   }) async {
//     productFeedModel = null;
//     storedImage = '';
//     storedGallery = [];
//     itemCount = 1;
//     currentColor = -1;
//     currentSize = -1;
//
//     emit(ProductDetailsLoading());
//
//     await _repository
//         .getProductDetails(
//       // slug: '50',
//       slug: slug,
//     )
//         .then((value) {
//       debugPrint('------------ ProductDetails --------');
//       debugPrint(slug);
//       // debugPrint(value.data);
//       productFeedModel = ProductFeedModel.fromJson(value.data);
//       productMainPrice = productFeedModel!.data.product.price;
//       storedGallery = productFeedModel!.data.product.gallery!;
//       storedImage = productFeedModel!.data.product.image;
//
//       // for(int i = 0 ; i < model.length ; i ++) {
//       //   if(model[i].id == productFeedModel!.data.product.id) {
//       //     isProductInCart = true;
//       //   }
//       // }
//
//       // debugPrint(productFeedModel!.data.product.gallery[0]);
//       // debugPrint(productFeedModel!.data.product.gallery[1]);
//       emit(
//         ProductDetailsSuccess(),
//       );
//     }).catchError((error) {
//       debugPrint('ProductDetailsError --------$error');
//       emit(ProductDetailsError());
//     });
//   }
//
//   // void changeCartState(bool state) {
//   //   isProductInCart = state;
//   //
//   //   emit(ChangeCartState());
//   // }
//
// //product details----------------------end
//
//   CategoriesDetails? gridModel;
//
//   int categoryProductCurrentPage = 1;
//   int categoryProductTotalPages = 0;
//
//   void getCategoryProduct({
//     required int id,
//     bool isFirst = false,
//   }) async {
//     if (isFirst) {
//       productsList = [];
//       categoryProductCurrentPage = 1;
//       emit(CategoryProductsLoadingState());
//     } else {
//       emit(CategoryProductsLoadingMoreState());
//     }
//
//     await _repository
//         .getCategoryProducts(
//       id: id,
//       page: categoryProductCurrentPage,
//     )
//         .then((value) {
//       gridModel = CategoriesDetails.fromJson(value.data);
//       productsList.addAll(gridModel!.data.products.productsList);
//
//       categoryProductCurrentPage++;
//       hasEnd = true;
//
//       if (categoryProductTotalPages == 0) {
//         categoryProductTotalPages = gridModel!.data.products.lastPage;
//       }
//
//       emit(CategoryProductsSuccessState());
//     }).catchError((error) {
//       debugPrint('getCategoryProduct error');
//       debugPrint(error.toString());
//       emit(CategoryProductsErrorState(error.toString()));
//     });
//   }
//
//   bool hasEnd = false;
//
//   void changeHasEnd() {
//     hasEnd = false;
//
//     emit(ChangeHasEndState());
//   }
//

//
// //my Address----------------------start
//   AddressFeedModel? addressFeedModel;
//   GovernmentModel? selectedGovernment;
//   CitiesModel? selectedCity;
//
//   void selectGovernment(GovernmentModel model) {
//     selectedGovernment = model;
//     selectedCity = selectedGovernment!.cities[0];
//     emit(SelectedGovernmentState());
//   }
//
//   void selectCity(CitiesModel model) {
//     selectedCity = model;
//     emit(SelectedCityState());
//   }
//
//   void getMyAddress() async {
//     emit(MyAddressLoadingState());
//     await _repository.getAddress().then((value) {
//       addressFeedModel = AddressFeedModel.fromJson(value.data);
//       selectedGovernment = addressFeedModel!.data.governoraties
//           .singleWhere((element) => element.name == 'Cairo');
//       selectedCity = selectedGovernment!.cities[0];
//       emit(MyAddressSuccessState());
//     }).catchError((error) {
//       debugPrint('my Address Error------------------------');
//       debugPrint(error.toString());
//       emit(MyAddressErrorState(error.toString()));
//     });
//   }
//
//   void addMyAddress({
//     required String buildingNumber,
//     required int city,
//     required int governorate,
//     required String specialMarker,
//     required String streetName,
//   }) async {
//     emit(AddAddressLoadingState());
//     await _repository
//         .addAddress(
//       building_number: buildingNumber,
//       city: city,
//       governorate: governorate,
//       special_marker: specialMarker,
//       street_name: streetName,
//     )
//         .then((value) {
//       SimpleModel model = SimpleModel.fromJson(value.data);
//       emit(AddAddressSuccessState(model.message!));
//       getMyAddress();
//     }).catchError((error) {
//       debugPrint('Add Address Error------------------------');
//       debugPrint(error.toString());
//       emit(AddAddressErrorState(error.toString()));
//     });
//   }
//
//   void deleteMyAddress({
//     required int addressId,
//   }) async {
//     emit(DeleteAddressLoadingState());
//     await _repository.deleteAddress(addressId: addressId).then((value) {
//       SimpleModel model = SimpleModel.fromJson(value.data);
//       emit(DeleteAddressSuccessState(model.message!));
//       getMyAddress();
//     }).catchError((error) {
//       debugPrint('Delete Address Error------------------------');
//       debugPrint(error.toString());
//       emit(DeleteAddressErrorState(error.toString()));
//     });
//   }
//
// //my Address----------------------end
//
// // Get all brands ----------------------start
// //   BrandsModel? allBrands;
// //
// //   void getAllBrands() async {
// //     emit(GetAllBrandsLoading());
// //     await _repository.getAllBrands().then((value) {
// //       allBrands = BrandsModel.fromJson(value.data);
// //       debugPrint(' --------------------------------------------all brands');
// //       //debugPrint(allBrands!.brands.brands[0].name);
// //       emit(GetAllBrandsSuccess());
// //     }).catchError((error) {
// //       debugPrint(error.toString());
// //       debugPrint(' --------------------------------------------all brands error');
// //       emit(Error());
// //     });
// //   }
//
// // Get all brands----------------------end
//
//   // Get brand details  ----------------------start
//   BrandsDetailsModel? brandDetails;
//   List<ProductModel> productsList = [];
//
//   void getBrandDetails({
//     required int id,
//   }) async {
//     productsList.clear();
//     emit(GetBrandDetailsLoading());
//     await _repository.getBrandDetails(id: id).then((value) {
//       brandDetails = BrandsDetailsModel.fromJson(value.data);
//       productsList =
//           brandDetails!.brandsDetailsDataModel.productsDataModel.productsList;
//       debugPrint(' --------------------------------------------brand details');
//       //debugPrint(allBrands!.brands.brands[0].name);
//       emit(GetBrandDetailsSuccess());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(' --------------------------------------------brand details error');
//       emit(Error());
//     });
//   }
//
// // Get brand details ----------------------end
//
//   // Get blog details  ----------------------start
//   BLogDetailsModel? bLogDetailsModel;
//
//   void getBlogDetails({
//     required int id,
//   }) async {
//     bLogDetailsModel = null;
//     emit(GetBlogDetailsLoading());
//     await _repository.getBlogDetails(id: id).then((value) {
//       bLogDetailsModel = BLogDetailsModel.fromJson(value.data);
//       debugPrint(
//           ' --------------------------------------------blog details success');
//       emit(GetBlogDetailsSuccess());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(' --------------------------------------------blog details error');
//       emit(Error());
//     });
//   }
//
// // Get blog details ----------------------end
//
//   //Search----------------------start
//   SearchFeedsModel? searchFeedsModel;
//
//   void getSearch({
//     required String productName,
//      int? categoryId,
//      int? brandId,
//   }) async {
//     debugPrint('----------------search------------------');
//     emit(SearchLoadingState());
//     await _repository.getSearch(productName: productName, categoryId: categoryId, brandId: brandId).then((value) {
//       searchFeedsModel = SearchFeedsModel.fromJson(value.data);
//       emit(SearchSuccessState());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       emit(SearchErrorState(error.toString()));
//     });
//   }
//
//   void clearSearch() {
//     searchFeedsModel = null;
//     emit(ClearSearchState());
//   }
//
//   int currentBrand = -1;
//   int? brandId;
//
//   void selectBrand(int index, brand_id) {
//     currentBrand = index;
//     brandId = brand_id;
//     emit(SelectBrand());
//   }
//
//   int currentCategories = -1;
//   int? categoryId;
//
//   void selectCategories(int index, categoriesId) {
//     currentCategories = index;
//     categoryId = categoriesId;
//     emit(SelectBrand());
//   }
//
//   // List<String> brandSelected =[];
//   //
//   // void addBrandSelected(String item) {
//   //   brandSelected =[];
//   //   brandSelected.add(item);
//   //   emit(AddBrandSelected());
//   // }
//
//   // List<String> categoriesSelected =[];
//
//   // void addCategoriesSelected(String item) {
//   //   brandSelected =[];
//   //   brandSelected.add(item);
//   //   emit(AddCategoriesSelected());
//   // }
//
// //Search----------------------end
//
//   //Edit Account----------------------start
//   MyAccountModel? myAccountModel;
//
//   void getAccount() async {
//     if (userSigned) {
//       debugPrint('----------------My Account------------------');
//       emit(MyAccountLoadingState());
//       await _repository.getMyAccount().then((value) {
//         myAccountModel = MyAccountModel.fromJson(value.data);
//         emit(MyAccountSuccessState());
//         debugPrint('----------------My Account------------------ Success');
//       }).catchError((error) {
//         emit(MyAccountErrorState(error.toString()));
//         debugPrint(
//             '----------------My Account------------------ Error${error.toString()}');
//       });
//     }
//   }
//
//   void updateAccount({
//     required String name,
//     required String email,
//     required String phone,
//   }) async {
//     debugPrint('----------------update Account------------------');
//     emit(UpdateAccountLoadingState());
//     await _repository
//         .updateAccount(
//       name: name,
//       email: email,
//       phone: phone,
//       image: imageFile,
//     )
//         .then((value) {
//       SimpleModel model = SimpleModel.fromJson(value.data);
//       emit(UpdateAccountSuccessState(model.message!));
//       getAccount();
//       debugPrint('----------------update Account------------------ Success');
//     }).catchError((error) {
//       emit(UpdateAccountErrorState(error.toString()));
//       debugPrint(
//           '----------------update Account------------------ Error${error.toString()}');
//     });
//   }
//
// //Edit Account----------------------end
//
// //notification----------------------start
//
//   NotificationFeedModel? notificationFeedModel;
//
//   void getNotification() async {
//     notificationFeedModel = null;
//     debugPrint('----------------Notification------------------');
//     emit(NotificationLoadingState());
//     await _repository.getNotification().then((value) {
//       notificationFeedModel = NotificationFeedModel.fromJson(value.data);
//       emit(NotificationSuccessState());
//       debugPrint('----------------Notification------------------ Success');
//     }).catchError((error) {
//       emit(NotificationErrorState(error.toString()));
//       debugPrint(
//           '----------------Notification------------------ Error ${error.toString()}');
//     });
//   }
//
// //notification----------------------end
//
// //get about us----------------------start
//
//   AboutUsModel? aboutUsModel;
//
//   void getAboutUs() async {
//     debugPrint('----------------About Us loading------------------');
//     emit(AboutUsLoadingState());
//     await _repository.getAboutUs().then((value) {
//       aboutUsModel = AboutUsModel.fromJson(value.data);
//       debugPrint(aboutUsModel!.data.name);
//       debugPrint('----------------About Us success ------------------ Success');
//       emit(AboutUsSuccessState());
//     }).catchError((error) {
//       emit(AboutUsErrorState(error.toString()));
//       debugPrint(
//           '----------------About Us error------------------ Error ${error.toString()}');
//       debugPrint(
//           '----------------About Us error------------------ Error ${error.toString()}');
//     });
//   }
//
// //get about us----------------------end
//
// //Compares----------------------start
//
//   ComparesModel? comparesModel;
//
//   void getCompares() async {
//     debugPrint('----------------Compares------------------');
//     emit(ComparesLoadingState());
//     await _repository.getCompares().then((value) {
//       comparesModel = ComparesModel.fromJson(value.data);
//       emit(ComparesSuccessState());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       emit(ComparesErrorState(error.toString()));
//     });
//   }
//
//   void addCompares({
//     required int productId,
//   }) async {
//     debugPrint('----------------Add Compares------------------');
//     emit(AddComparesLoadingState());
//     await _repository.addCompares(productId: productId).then((value) {
//       SimpleModel model = SimpleModel.fromJson(value.data);
//       emit(AddComparesSuccessState(model.message!));
//       getCompares();
//     }).catchError((error) {
//       debugPrint(error.toString());
//       emit(AddComparesErrorState(error.toString()));
//     });
//   }
//
//
//   void removeFromCompares({
//     required int compareId,
//   }) async {
//     debugPrint('----------------RemoveCompare------------------');
//     emit(RemoveComparesLoadingState());
//     await _repository.removeCompare(compareId: compareId).then((value) {
//       SimpleModel model = SimpleModel.fromJson(value.data);
//       debugPrint('----------------RemoveCompare------------------ success');
//       emit(RemoveComparesSuccessState(model.message!));
//       getCompares();
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint('----------------RemoveCompare------------------ error');
//       emit(RemoveComparesErrorState(error.toString()));
//     });
//   }
//
// //Compares----------------------end
//
//   // contact us ---------------- start
//
//   // String? responseMessage;
//   // int? responseState;
//
//   void contactUs({
//     required String name,
//     required String phone,
//     required String email,
//     required String subject,
//     required String message,
//   }) async {
//     emit(ContactUsLoadingState());
//     await _repository
//         .contactUs(
//       name: name,
//       phone: phone,
//       email: email,
//       subject: subject,
//       message: message,
//     )
//         .then((value) {
//       // responseMessage = value.data['message'];
//       // responseState = value.data['state'];
//       debugPrint(
//           'contact us ------------------------------------------------------');
//       debugPrint(value.data['message']);
//       emit(ContactUsSuccessState(value.data['message']));
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(
//           'error is here ------------------------------------------------------');
//       emit(Error());
//     });
//   }
//
// // contact us ---------------- end
//
// // get FAQs ------------------ start
//   FAQsModel? faqsModel;
//
//   void getFAQs() async {
//     debugPrint('----------------Compares------------------');
//     emit(FAQsLoadingState());
//     await _repository.getFAQs().then((value) {
//       faqsModel = FAQsModel.fromJson(value.data);
//       debugPrint(faqsModel!.faqs[0].question);
//       emit(FAQsSuccessState());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       emit(Error());
//     });
//   }
//
// // get FAQs ------------------ end
//
//   // news letter ------------------ start
//
//   void newsLetter({
//     required String email,
//   }) async {
//     debugPrint('----------------news letter------------------');
//     emit(NewsLetterLoadingState());
//     await _repository.newsLetter(email: email).then((value) {
//       debugPrint('----------------news letter success------------------');
//       emit(NewsLetterSuccessState(value.data['message']));
//     }).catchError((error) {
//       debugPrint(error.toString());
//       emit(Error());
//     });
//   }
//
// // news letter ------------------ end
//
// //Used Market----------------------start
//
//   UsedProductFeedModel? usedProductFeedModel;
//
//   void getUsedProduct({
//     required int productId,
//   }) async {
//     debugPrint('----------------Used Product------------------');
//     emit(UsedProductLoadingState());
//     await _repository.usedMarketProduct(productId: productId).then((value) {
//       debugPrint('----------------Used Product- no parsing -----------------');
//       usedProductFeedModel = UsedProductFeedModel.fromJson(value.data);
//       emit(UsedProductSuccessState());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       emit(UsedProductErrorState(error.toString()));
//     });
//   }
//
// //Used Market----------------------end
//
// //Get Used Market----------------------start
//
//   UsedMarketModel? usedMarketModel;
//
//   void getUsedMarket() async {
//     debugPrint('---------------------------------- Used Product Loading');
//     emit(GetUsedMarketLoadingState());
//     await _repository.getUsedMarket().then((value) {
//       usedMarketModel = UsedMarketModel.fromJson(value.data);
//       debugPrint('---------------------------------- Used Product Success');
//       emit(GetUsedMarketSuccessState());
//     }).catchError((error) {
//       debugPrint('---------------------------------- Used Product Error');
//       debugPrint(error.toString());
//       emit(Error());
//     });
//   }
//
// //Get Used Market----------------------end
//
//   // get UsedMarketCat details  ----------------------start
//   UsedMarketCatDetailsModel? usedMarketCatDetailsModel;
//
//   void getUsedMarketCatDetails({
//     required int id,
//   }) async {
//     usedMarketCatDetailsModel = null;
//     debugPrint(
//         ' --------------------------------------------getUsedMarketCatDetails loading');
//     emit(GetUsedMarketDetailsLoading());
//     await _repository.getUsedMarketCatDetails(id: id).then((value) {
//       usedMarketCatDetailsModel =
//           UsedMarketCatDetailsModel.fromJson(value.data);
//       debugPrint(
//           ' --------------------------------------------getUsedMarketCatDetails success');
//       //debugPrint(allBrands!.brands.brands[0].name);
//       emit(GetUsedMarketDetailsSuccess());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(
//           ' --------------------------------------------getUsedMarketCatDetails error');
//       emit(Error());
//     });
//   }
//
// // get UsedMarketCat details ----------------------end
//
// //Add Review----------------------start
//
//   void addReview({
//     required int productId,
//     required double rating,
//     required String review,
//   }) async {
//     debugPrint('----------------Add Review------------------');
//     emit(AddReviewLoadingState());
//     await _repository
//         .addReview(
//       productId: productId,
//       rating: rating,
//       review: review,
//     )
//         .then((value) {
//       SimpleModel model = SimpleModel.fromJson(value.data);
//       emit(AddReviewSuccessState(model.message!));
//     }).catchError((error) {
//       debugPrint(error.toString());
//       emit(AddReviewErrorState(error.toString()));
//     });
//   }
//
// //Add Review----------------------end
//
//   // Get orders details  ----------------------start
//   OrdersModel? ordersModel;
//
//   void getOrders() async {
//     debugPrint(' --------------------------------------------get orders loading');
//     emit(GetOrdersLoading());
//     await _repository.getOrders().then((value) {
//       ordersModel = OrdersModel.fromJson(value.data);
//       debugPrint(' --------------------------------------------get orders success');
//       emit(GetOrdersSuccess());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(' --------------------------------------------get orders error');
//       emit(Error());
//     });
//   }
//
// // Get orders details ----------------------end
//
//   int shippingAddressIndex = 0;
//
//   void changeShippingAddressIndex({
//     required int index,
//   }) {
//     shippingAddressIndex = index;
//     emit(ChangeShippingAddressIndex());
//   }
//
//   int paymentMethodIndex = 0;
//
//   void changePaymentMethodIndex({
//     required int index,
//   }) {
//     paymentMethodIndex = index;
//     emit(ChangePaymentMethodIndex());
//   }
//
//   // getCheckout  ----------------------start
//   AddressFeedModel? checkoutModel;
//
//   void getCheckout() async {
//     debugPrint(' -------------------------------------------getCheckout loading');
//     emit(GetCheckoutLoading());
//     await _repository.getCheckout().then((value) {
//       checkoutModel = AddressFeedModel.fromJson(value.data);
//       debugPrint(checkoutModel!.data.addresses[0].street_name);
//       debugPrint(' -------------------------------------------getCheckout success');
//       emit(GetCheckoutSuccess());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(' -------------------------------------------getCheckout error');
//       emit(Error());
//     });
//   }
//
// // getCheckout ----------------------end
//
//   // getOrderDetails  ----------------------start
//   OrderDetailsModel? orderDetailsModel;
//
//   void getOrderDetails({
//     required int id,
//   }) async {
//     orderDetailsModel = null;
//     debugPrint(' --------------------------------------------getOrderDetails error');
//     emit(GetOrderDetailsLoading());
//     await _repository.getOrderDetails(id: id).then((value) {
//       orderDetailsModel = OrderDetailsModel.fromJson(value.data);
//       debugPrint(
//           ' --------------------------------------------getOrderDetails success');
//       debugPrint(orderDetailsModel!.data.orderItems[0].price);
//       emit(GetOrderDetailsSuccess());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(
//           ' --------------------------------------------getOrderDetails error');
//       emit(Error());
//     });
//   }
//
// // getOrderDetails ----------------------end
//
// // select profile image
//
//   final ImagePicker _picker = ImagePicker();
//   File? imageFile;
//
//   void selectImage() async {
//     _picker.pickImage(source: ImageSource.gallery).then((value) {
//       imageFile = File(value!.path);
//     });
//
//     emit(SelectProfileImage());
//   }
//
//   void clearSelectedImage() async {
//     imageFile = null;
//
//     emit(ClearProfileImage());
//   }
//
//   // readNotification  ----------------------start
//   ReadNotificationModel? readNotificationModel;
//
//   void readNotification({
//     required String notificationId,
//   }) async {
//     readNotificationModel = null;
//     debugPrint(
//         ' --------------------------------------------readNotification loading');
//     emit(ReadNotificationLoading());
//     await _repository
//         .readNotification(notificationId: notificationId)
//         .then((value) {
//       readNotificationModel = ReadNotificationModel.fromJson(value.data);
//       debugPrint(
//           ' --------------------------------------------readNotification success');
//       debugPrint(readNotificationModel!.data.order.name);
//       emit(ReadNotificationSuccess());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(
//           ' --------------------------------------------readNotification error');
//       emit(Error());
//     });
//   }
//
// // readNotification ----------------------end
//
//   // changePassword  ----------------------start
//   SimpleModel? changePasswordModel;
//
//   void changePassword({
//     required String oldPassword,
//     required String newPassword,
//     required String confirmPassword,
//   }) async {
//     changePasswordModel = null;
//     debugPrint(
//         ' --------------------------------------------changePassword loading');
//     emit(ChangePasswordLoading());
//     await _repository
//         .changePassword(
//       oldPassword: oldPassword,
//       newPassword: newPassword,
//       confirmPassword: confirmPassword,
//     )
//         .then((value) {
//       debugPrint('done');
//       changePasswordModel = SimpleModel.fromJson(value.data);
//       debugPrint(changePasswordModel!.message);
//       debugPrint(
//           ' --------------------------------------------changePassword success');
//       emit(ChangePasswordSuccess(changePasswordModel!.message!));
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint(
//           ' --------------------------------------------changePassword error');
//       emit(Error());
//     });
//   }
//
// // changePassword ----------------------end
//
//
// //Drawer --------------------------start
//
//   bool defaultExpansionTile = false;
//
//   void changeExpansionTile(bool state){
//     defaultExpansionTile = state;
//     emit(ChangeExpansionTile());
//   }
//
// //Drawer --------------------------end
//
//   // getCheckout  ----------------------start
//   // AddressFeedModel? checkoutModel;
//
//   void createCheckout({
//     required String name,
//     required String email,
//     required String phone,
//     required String government,
//     required String city,
//     required String streetName,
//     required String buildingNumber,
//     required String paymentMethod,
//   }) async {
//     debugPrint(' -------------------------------------------createCheckout loading');
//     emit(CreateCheckoutLoading());
//     await _repository
//         .createCheckout(
//       city: city,
//       buildingNumber: buildingNumber,
//       streetName: streetName,
//       phone: phone,
//       email: email,
//       specialMarker: 'ميدان الشهداء',
//       government: government,
//       name: name,
//       paymentMethod: paymentMethod,
//       extraShipping: '10',
//       items: [
//         CreateCheckoutItemModel(
//           price: 400,
//           id: 297,
//           quantity: 3,
//           attributes: CreateCheckoutItemModelAttributes(
//             image: 'attr_1631631853.jpg',
//             size: null,
//             type: 'color',
//             color: LanguageModel(ar: 'اخضر فاتح', en: 'Green'),
//           ),
//         ),
//         CreateCheckoutItemModel(
//           price: 220,
//           id: 456,
//           quantity: 2,
//           attributes: CreateCheckoutItemModelAttributes(
//             image: '',
//             size: LanguageModel(ar: 'اكس لارج', en: 'X-Large'),
//             type: 'size',
//             color: null,
//           ),
//         ),
//         CreateCheckoutItemModel(
//           price: 2325,
//           id: 106,
//           quantity: 1,
//           attributes: CreateCheckoutItemModelAttributes(
//             image: '',
//             size: null,
//             type: '',
//             color: null,
//           ),
//         ),
//       ],
//       notes: 'test order api',
//       overweightPrice: '55',
//       promoCode: 'Empire 50',
//       shippingPrice: '50',
//     )
//         .then((value) {
//       // checkoutModel = AddressFeedModel.fromJson(value.data);
//       // debugPrint(checkoutModel!.data.addresses[0].street_name);
//       debugPrint(
//           '-------------------------------------------createCheckout success');
//       emit(CreateCheckoutSuccess());
//     }).catchError((error) {
//       debugPrint(error.toString());
//       debugPrint('-------------------------------------------createCheckout error');
//       emit(Error());
//     });
//   }
//
// // createCheckout ----------------------end
