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
    const BorderRadius radius = const BorderRadius.all(Radius.circular(16));

    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: float ? EdgeInsets.all(16) : EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: float
                ? radius
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
                  borderRadius: radius,
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
