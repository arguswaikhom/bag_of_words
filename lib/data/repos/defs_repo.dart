import 'package:bag_of_words/data/providers/defs_cloud_provider.dart';
import 'package:bag_of_words/data/response/defs_response.dart';

class DefsRepo {
  final DefsCloudProvider cloudProvider;

  DefsRepo(this.cloudProvider);

  Future<DefsResponse> fetchLearnedDefinitions(
          {final String? url, required final String uid}) =>
      cloudProvider.fetchLearnedDefinitions(url: url, uid: uid);
}
