import 'package:bag_of_words/res/app_asset.dart';
import 'package:flutter/material.dart';

class AppCircleLogo extends StatelessWidget {
  final double radius;
  const AppCircleLogo({
    Key? key,
    this.radius = 48.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(AppAsset.iconWordCloud),
    );
  }
}
