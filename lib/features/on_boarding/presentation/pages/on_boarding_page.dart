import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/app_text_button.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/features/login/presentation/pages/login_page.dart';
import 'package:hti_library/features/main/presentation/pages/main_page.dart';
import 'package:hti_library/features/select_library/page/selectLibrary.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController boardingPageViewController = PageController();

  bool isLast = false;
  List<OnBoardingDataModel> onBoardingData = [
    OnBoardingDataModel(
      'assets/images/onboarding_1.png',
      'It’s a library, \na place to learn something new',
    ),
    OnBoardingDataModel(
      'assets/images/onboarding_2.png',
      'Learn something about everything &\neverything about something',
    ),
    OnBoardingDataModel(
      'assets/images/onboarding_3.png',
      'Keep evolving,\nThe world is in your hands',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          AppTextButton(
              label: 'SKIP',
              style: Theme.of(context).textTheme.subtitle1,
              onPress: () {
                if (libraryCache!.isNotEmpty && typeCache!.isNotEmpty) {
                  navigateAndFinish(context, MainPage(library: libraryCache, type: typeCache,));
                }  else {
                  navigateAndFinish(context, const SelectLibrary());
                }
              }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                if (index == onBoardingData.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              physics: const BouncingScrollPhysics(),
              controller: boardingPageViewController,
              itemBuilder: (context, index) => OnBoardingItem(
                boardingModel: onBoardingData[index],
              ),
              itemCount: 3,
            ),
          ),
          space70Vertical,
          IconButton(
            onPressed: () {
              if (!isLast) {
                boardingPageViewController.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn);
              } else {
                if (libraryCache!.isNotEmpty && typeCache!.isNotEmpty) {
                  navigateAndFinish(context, MainPage(library: libraryCache, type: typeCache,));
                }  else {
                  navigateAndFinish(context, const SelectLibrary());
                }
              }
            },
            icon: AssetSvg(
              imagePath: 'arrow_start',
              color: HexColor(mainColor),
            ),
          ),
          space70Vertical,
          SmoothPageIndicator(
            controller: boardingPageViewController,
            count: 3,
            effect: CustomizableEffect(
              activeDotDecoration: DotDecoration(
                width: 12,
                height: 12,
                color: HexColor(mainColor),
                rotationAngle: 180,
                verticalOffset: 0,
                borderRadius: BorderRadius.circular(16),
              ),
              dotDecoration: DotDecoration(
                width: 12,
                height: 12,
                color: const Color.fromRGBO(198, 223, 255, 1),
                borderRadius: BorderRadius.circular(16),
                verticalOffset: 0,
              ),
              spacing: 6.0,
            ),
          ),
          space80Vertical,
          // if (isLast)
          //   Padding(
          //     padding: const EdgeInsets.all(20.0),
          //   ),
        ],
      ),
    );
  }
}

class OnBoardingItem extends StatelessWidget {
  final OnBoardingDataModel boardingModel;

  const OnBoardingItem({
    Key? key,
    required this.boardingModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${boardingModel.image}'),
          ),
        ),
        space60Vertical,
        Column(
          children: [
            Text(
              boardingModel.description,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}

class OnBoardingDataModel {
  late String image;
  late String description;

  OnBoardingDataModel(
    this.image,
    this.description,
  );
}

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
