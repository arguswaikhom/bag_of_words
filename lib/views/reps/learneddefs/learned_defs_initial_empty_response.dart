import 'package:bag_of_words/res/app_color.dart';
import 'package:flutter/material.dart';

class LearnedDefsInitialEmptyResponse extends StatelessWidget {
  const LearnedDefsInitialEmptyResponse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle style = const TextStyle(
      fontSize: 16,
      color: AppColor.wordDefColor,
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You haven\'t add anything.',
            style: style,
          ),
          Text(
            'Add word(s) to display here.',
            style: style,
          ),
        ],
      ),
    );
  }
}
