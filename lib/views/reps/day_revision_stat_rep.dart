import 'package:bag_of_words/models/day_stat.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/utils/extensions/int_x.dart';
import 'package:bag_of_words/widget/DayStatEntry.dart';
import 'package:flutter/material.dart';

typedef OnTapDayRevisionStat = Function(DayStat?);

class DayRevisionStatRep extends StatelessWidget {
  final DayStat? todaysDayStat;
  final DayStat? yestDayStat;
  final OnTapDayRevisionStat? onTapDayRevisionStat;

  const DayRevisionStatRep({
    Key? key,
    this.todaysDayStat,
    this.yestDayStat,
    this.onTapDayRevisionStat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DayStatEntry(
          count: todaysDayStat == null
              ? null
              : todaysDayStat!.total.dualToString(),
          label: AppString.wordLearnedToday,
          onTap: () => onTapDayRevisionStat?.call(todaysDayStat),
        ),
        SizedBox(height: 16),
        DayStatEntry(
          count: yestDayStat == null ? null : yestDayStat!.total.dualToString(),
          label: AppString.wordsLearnedYesterday,
          onTap: () => onTapDayRevisionStat?.call(yestDayStat),
        ),
      ],
    );
  }
}
