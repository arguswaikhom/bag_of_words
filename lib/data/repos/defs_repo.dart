import 'package:bag_of_words/data/providers/defs_cloud_provider.dart';
import 'package:bag_of_words/data/response/defs_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DefsRepo {
  final User user;
  final DefsCloudProvider cloudProvider;

  DefsRepo({
    required this.user,
    required this.cloudProvider,
  });

  Future<DefsResponse> fetchLearnedDefs({final String? url}) =>
      cloudProvider.fetchLearnedDefs(url: url, user: user);
}
