import 'package:bag_of_words/res/app_color.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:flutter/material.dart';

class LearnedDefsInitialFailure extends StatelessWidget {
  const LearnedDefsInitialFailure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle style = const TextStyle(
      fontSize: 16,
      color: AppColor.wordDefColor,
    );

    return Center(
      child: Text(
        AppString.failedToGetData,
        style: style,
      ),
    );
  }
}
