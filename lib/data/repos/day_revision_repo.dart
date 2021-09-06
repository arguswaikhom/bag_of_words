import 'package:bag_of_words/data/providers/day_revision_cloud_provider.dart';
import 'package:bag_of_words/models/day_stat.dart';
import 'package:bag_of_words/models/definition.dart';
import 'package:bag_of_words/utils/extensions/int_x.dart';

class DayRevisionRepo {
  final String uid;
  final DayRevisionCloudProvider cloudProvider;

  DayRevisionRepo({
    required this.uid,
    required this.cloudProvider,
  });

  Future<DayStat> fetchTodaysStat() async {
    DateTime now = new DateTime.now();
    String dayId =
        now.year.toString() + now.month.dualToString() + now.day.dualToString();
    return await cloudProvider.fetchDayStat(uid, dayId);
  }

  Future<DayStat> fetchYesterdaysStat() async {
    DateTime now = new DateTime.now();
    final yst = now.subtract(Duration(days: 1));
    String dayId =
        yst.year.toString() + yst.month.dualToString() + yst.day.dualToString();
    return await cloudProvider.fetchDayStat(uid, dayId);
  }

  Future<Definition> fetchDefinition(String word, bool includeCall) {
    return cloudProvider.fetchDefinition(word, uid, includeCall);
  }
}
