import 'package:bag_of_words/models/day_stat.dart';
import 'package:equatable/equatable.dart';

enum DayRevisionSummaryStatus { INITIAL, SUCCESS }

class DayRevisionSummaryState extends Equatable {
  final DayRevisionSummaryStatus status;
  final DayStat? todaysDayStat;
  final DayStat? yestDayStat;

  const DayRevisionSummaryState({
    this.status = DayRevisionSummaryStatus.INITIAL,
    this.todaysDayStat,
    this.yestDayStat,
  });

  DayRevisionSummaryState copyWith({
    DayRevisionSummaryStatus? status,
    DayStat? todaysDayStat,
    DayStat? yestDayStat,
  }) {
    return DayRevisionSummaryState(
      status: status ?? this.status,
      todaysDayStat: todaysDayStat ?? this.todaysDayStat,
      yestDayStat: yestDayStat ?? this.yestDayStat,
    );
  }

  @override
  List<Object?> get props => [
        this.status,
        this.todaysDayStat,
        this.yestDayStat,
      ];
}
