import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/cubit/cubit.dart';
import 'package:hti_library/core/util/widgets/asset_svg.dart';

class DialogChangePhoto extends StatelessWidget {
  const DialogChangePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: AlertDialog(
        elevation: 10,
        shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
        title: Text("Choose option",style: TextStyle(color: HexColor(mainColor)),textAlign: TextAlign.center,),
        content: Container(
          height: MediaQuery.of(context).size.height / 7.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: (){
                    MainCubit.get(context).openCamera(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        AssetSvg(imagePath: 'ic_camera' , size: 60,color: HexColor(mainColor),),
                        const Text("Camera"),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: (){
                    MainCubit.get(context).openGallery(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        AssetSvg(imagePath: 'ic_gallery' , size: 60,),
                        const Text("gallery"),
                      ],
                    ),
                  ),
                ),
              ),
              // ListTile(
              //   onTap: (){
              //     MainCubit.get(context).openGallery(context);
              //   },
              //   title: Text("Gallery"),
              //   leading: Icon(Icons.account_box,color: Colors.blue,),
              // ),
              // ListTile(
              //   onTap: (){
              //     MainCubit.get(context).openCamera(context);
              //   },
              //   title: Text("Camera"),
              //   leading: Icon(Icons.camera,color: Colors.blue,),
              // ),
            ],
          ),
        ),),
    );

  }
}
