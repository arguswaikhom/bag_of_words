import 'package:bag_of_words/res/app_style.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:flutter/material.dart';

class AppBottomSheet {
  final child;
  final context;
  final float;

  const AppBottomSheet({
    @required this.context,
    @required this.child,
    this.float: false,
  });

  void show() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: float ? EdgeInsets.all(16) : EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: float
                ? AppStyle.brCircular16
                : BorderRadius.vertical(top: Radius.circular(16)),
            color: AppColor.dark2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Container(
                height: 8,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: AppStyle.brCircular16,
                  color: AppColor.dark4,
                ),
              ),
              child
            ],
          ),
        );
      },
    );
  }
}
