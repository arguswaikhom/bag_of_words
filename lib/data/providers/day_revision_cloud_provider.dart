import 'package:bag_of_words/data/response/day_stat_response.dart';
import 'package:bag_of_words/models/day_stat.dart';
import 'package:bag_of_words/models/definition.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/utils/enums/response_status.dart';
import 'package:bag_of_words/utils/exceptions/empty_res_exception.dart';
import 'package:bag_of_words/utils/exceptions/failed_res_exception.dart';
import 'package:http/http.dart' as http;

class DayRevisionCloudProvider {
  Future<DayStat> fetchDayStat(final String uid, final String day) async {
    final String url = '${AppString.apiDayStat}$uid/$day';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final DayStatResponse res = DayStatResponse.fromJson(response.body);
      if (res.status == ResponseStatus.SUCCESS) return res.stat;

      /// Empty response returned from the server
      /// This could happen when user didn't learned any word that day
      throw EmptyResException('Empty response :: Day stat :: $url');
    }
    throw FailedResException('Failed response :: Day stat :: $url');
  }

  Future<Definition> fetchDefinition(
    final String word,
    final String uid,
    final bool includeCall,
  ) async {
    final String query = includeCall ? '?ic=True&uid=$uid}' : '';
    final String url = AppString.apiDefinition + '${word.toLowerCase()}/$query';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return Definition.fromJson(response.body);
    throw FailedResException('Failed response :: Definition :: $url');
  }
}
