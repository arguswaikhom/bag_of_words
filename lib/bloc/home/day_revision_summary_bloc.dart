import 'package:bag_of_words/bloc/home/day_revision_summary_event.dart';
import 'package:bag_of_words/bloc/home/day_revision_summary_state.dart';
import 'package:bag_of_words/data/repos/day_revision_repo.dart';
import 'package:bag_of_words/models/day_stat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayRevisionSummaryBloc
    extends Bloc<DayRevisionSummaryFetchEvent, DayRevisionSummaryState> {
  final DayRevisionRepo repo;

  DayRevisionSummaryBloc(this.repo) : super(DayRevisionSummaryState());

  @override
  Stream<DayRevisionSummaryState> mapEventToState(
      DayRevisionSummaryFetchEvent event) async* {
    if (event is DayRevisionSummaryFetchEvent) {
      try {
        final List<DayStat> snapshots = await Future.wait([
          repo.fetchTodaysStat(),
          repo.fetchYesterdaysStat(),
        ]);

        yield DayRevisionSummaryState(
          status: DayRevisionSummaryStatus.SUCCESS,
          todaysDayStat: snapshots[0],
          yestDayStat: snapshots[1],
        );
      } on Exception {
        yield DayRevisionSummaryState(status: DayRevisionSummaryStatus.INITIAL);
      }
    }
  }
}
