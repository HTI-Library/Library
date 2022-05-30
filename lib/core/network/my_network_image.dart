import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hti_library/core/util/constants.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage({
    required this.image,
    required this.height,
    required this.width,
    required this.radius,
  });

  final String image;
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        height: responsiveValue(context, height),
        width: responsiveValue(context, width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsiveValue(context, radius)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        height: responsiveValue(context, height),
        width: responsiveValue(context, width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsiveValue(context, radius)),
        ),
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: responsiveValue(context, height),
        width: responsiveValue(context, width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsiveValue(context, radius)),
          image: const DecorationImage(
            image: AssetImage('assets/images/s_library.jpg'),
            fit: BoxFit.fitWidth,

          ),
        ),
      ),
    );
  }
}
