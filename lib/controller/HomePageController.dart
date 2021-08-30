import 'dart:convert';

import 'package:bag_of_words/controller/Application.dart';
import 'package:bag_of_words/model/DayStat.dart';
import 'package:bag_of_words/model/DayStatResponse.dart';
import 'package:bag_of_words/model/Definition.dart';
import 'package:bag_of_words/model/DefinitionsResponse.dart';
import 'package:bag_of_words/res/AppString.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class HomePageController {
  static HomePageController? _instance;

  static getInstance() => _instance ?? HomePageController();

  Future<DayStat?> fetchTodaysStat() async {
    DateTime now = new DateTime.now();
    String dayId = now.year.toString() + dualNum(now.month) + dualNum(now.day);
    return await fetchDayStat(dayId);
  }

  Future<DayStat?> fetchYesterdaysStat() async {
    DateTime now = new DateTime.now();
    final yst = now.subtract(Duration(days: 1));
    String dayId = yst.year.toString() + dualNum(yst.month) + dualNum(yst.day);
    return await fetchDayStat(dayId);
  }

  Future<DayStat?> fetchDayStat(final String day) async {
    User user = Application.getInstance().getFirebaseUser()!;
    final String url = AppString.apiDayStat + "${user.uid}/" + day;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> resMap = json.decode(response.body);
      if (resMap[AppString.keyStatus] == AppString.statusEmpty) {
        return DayStat(total: 0);
      }
      DayStatResponse resDayStat = DayStatResponse.fromJson(response.body);
      return resDayStat.stat;
    }
    return null;
  }

  Future<Definition?> fetchDefinition(
    final String word,
    final bool includeCall,
  ) async {
    final String query = includeCall
        ? "?ic=True&uid=${(Application.getInstance().getFirebaseUser())!.uid}"
        : "";
    final String url = AppString.apiDefinition + '${word.toLowerCase()}/$query';
    print("Fetching def: $url");
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return Definition.fromJson(response.body);
    return null;
  }

  Future<DefinitionsResponse?> fetchLearnedDefinitions({
    final String? url,
  }) async {
    final uid = (Application.getInstance().getFirebaseUser())!.uid;
    final endpoint = url == null ? AppString.apiDefinitions + uid : url;
    print(endpoint);
    final res = await http.get(Uri.parse(endpoint));
    if (res.statusCode != 200) return null;
    final DefinitionsResponse defsRes = DefinitionsResponse.fromJson(res.body);
    return defsRes;
  }

  String dualNum(number) {
    if (number.toString().length == 1) {
      return "0" + number.toString();
    }
    return number.toString();
  }
}
