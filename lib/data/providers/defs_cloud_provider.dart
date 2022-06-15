import 'package:bag_of_words/data/response/defs_response.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/utils/extensions/response_status.dart';
import 'package:bag_of_words/utils/exceptions/empty_res_exception.dart';
import 'package:bag_of_words/utils/exceptions/failed_res_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class DefsCloudProvider {
  Future<DefsResponse> fetchLearnedDefs({
    final String? url,
    required final User user,
  }) async {
    final String endpoint = url ?? AppString.apiDefinitions + user.uid;
    final res = await http.get(Uri.parse(endpoint));
    if (res.statusCode == 200) {
      final DefsResponse response = DefsResponse.fromJson(res.body);
      if (response.status == ResponseStatus.SUCCESS) return response;

      /// Empty response returned from the server
      /// This could happen when user tries to fetch their learned words
      /// (call this API) before learning any word at all
      throw EmptyResException('Empty response :: Defs Response :: $url');
    }
    throw FailedResException('Failed response :: Defs Response :: $url');
  }
}
