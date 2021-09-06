import 'package:bag_of_words/res/app_color.dart';
import 'package:bag_of_words/res/AppStyle.dart';
import 'package:flutter/material.dart';

class DayStatEntry extends StatelessWidget {
  final void Function() onTap;
  final count;
  final String label;

  const DayStatEntry({
    Key? key,
    this.count,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.wordWidgetBg,
          borderRadius: AppStyle.brCircular16,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                this.count == null ? '##' : this.count.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: AppColor.wordDefColor),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.wordDefBg),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              this.label,
              style: TextStyle(fontSize: 16, color: AppColor.wordDefColor),
            ),
            Expanded(child: Container()),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.wordHintColor,
            )
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}
