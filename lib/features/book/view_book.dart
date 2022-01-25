import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/widgets/app_button.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';
import 'package:hti_library/core/util/widgets/available_item.dart';
import 'package:hti_library/core/util/widgets/back_scaffold.dart';
import 'package:hti_library/core/util/widgets/book_item.dart';
import 'package:hti_library/core/util/widgets/main_scaffold.dart';
import 'package:hti_library/core/util/widgets/see_more_item.dart';
import 'package:hti_library/features/account/widget/btn_my_account.dart';
import 'package:hti_library/features/borrowing/presentation/pages/borrowing_page.dart';
import 'package:hti_library/features/categories/presentation/pages/categories.dart';

class ViewBookPage extends StatelessWidget {
  const ViewBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actionIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              IconButton(onPressed: (){}, icon: AssetSvg(imagePath: 'heart'), constraints: BoxConstraints(),),
              IconButton(onPressed: (){}, icon: AssetSvg(imagePath: 'pop_mark'), constraints: BoxConstraints(),),
              IconButton(onPressed: (){}, icon: AssetSvg(imagePath: 'share'), constraints: BoxConstraints(),)
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        child: Text('View Book' , style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center,)),
                    space10Vertical,
                    Container(
                      alignment: Alignment.center,
                      child:
                      Image(
                        image: const NetworkImage(
                            'https://edit.org/images/cat/book-covers-big-2019101610.jpg'),
                        height: MediaQuery.of(context).size.width / 3.2 * 1.6,
                        width: MediaQuery.of(context).size.width / 3.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    space20Vertical,
                    Text(
                      'python code.',
                      style: Theme.of(context).textTheme.bodyText2!,
                    ),
                    Text(
                      'Fankoo.',
                      style: Theme.of(context).textTheme.bodyText2!,
                    ),
                    Text(
                      '10th Ramadan.',
                      style: Theme.of(context).textTheme.bodyText2!,
                    ),
                    space10Vertical,
                    Row(
                      children: [
                        const AvailableItem(
                          label: 'Available',
                        ),
                        Spacer(),
                        RatingBar.builder(
                            initialRating: 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemBuilder: (context, _) => Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            }
                        ),
                      ],
                    ),
                    space10Vertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AppButton(label: 'Borrow',
                              onPress: (){}),
                        ),
                        space10Horizontal,
                        Expanded(
                          child: AppButton(
                              color: HexColor(greyWhite),
                              label: 'Read',
                              textColor: HexColor(mainColor),
                              onPress: (){}),
                        ),
                      ],
                    ),
                    space15Vertical,
                    Text(
                      'Overview.',
                      style: Theme.of(context).textTheme.headline6!,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor(greyWhite),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("File tabs have been enhanced to make split views effortless, with support throughout the interface and built-in commands. The side bar, tab bar, Goto Anything, Goto Definition, auto complete and more have all been tweaked to make code navigation easier and more intuitive than ever." , maxLines: 8 ,
                          style: Theme.of(context).textTheme.bodyText1,),
                      ),
                    ),

                  ],
                ),
              ),
              SeeMoreItem(
                padding: 15,
                gestureTapCallback: () {},
                text: 'More Edition of this book',
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(
                  top: 5.0,
                  bottom: 5.0,
                ),
                color: HexColor(greyWhite),
                height: MediaQuery.of(context).size.width / 3.2 *2.2,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => BookItem(),
                    itemCount: 10),
              ),
            ],
          )
        ),
      ),
    );

  }
}
