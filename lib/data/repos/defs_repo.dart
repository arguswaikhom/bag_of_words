import 'package:bag_of_words/data/providers/defs_cloud_provider.dart';
import 'package:bag_of_words/data/response/defs_response.dart';

class DefsRepo {
  final String uid;
  final DefsCloudProvider cloudProvider;

  DefsRepo({
    required this.uid,
    required this.cloudProvider,
  });

  Future<DefsResponse> fetchLearnedDefinitions({final String? url}) =>
      cloudProvider.fetchLearnedDefinitions(url: url, uid: uid);
}
