import 'package:bag_of_words/data/providers/day_revision_cloud_provider.dart';
import 'package:bag_of_words/models/day_stat.dart';
import 'package:bag_of_words/models/definition.dart';
import 'package:bag_of_words/utils/extensions/int_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DayRevisionRepo {
  final User user;
  final DayRevisionCloudProvider cloudProvider;

  DayRevisionRepo({
    required this.user,
    required this.cloudProvider,
  });

  Future<DayStat?> fetchTodaysStat() async {
    DayStat? dayStat;
    DateTime now = new DateTime.now();
    String dayId =
        now.year.toString() + now.month.dualToString() + now.day.dualToString();
    try {
      dayStat = await cloudProvider.fetchDayStat(user, dayId);
    } on Exception {}
    return Future<DayStat?>.value(dayStat);
  }

  Future<DayStat?> fetchYesterdaysStat() async {
    DayStat? dayStat;
    DateTime now = new DateTime.now();
    final yst = now.subtract(Duration(days: 1));
    String dayId =
        yst.year.toString() + yst.month.dualToString() + yst.day.dualToString();
    try {
      dayStat = await cloudProvider.fetchDayStat(user, dayId);
    } on Exception {}
    return Future<DayStat?>.value(dayStat);
  }

  Future<Definition> fetchDefinition(String word, bool includeCall) {
    return cloudProvider.fetchDefinition(word, user, includeCall);
  }
}
