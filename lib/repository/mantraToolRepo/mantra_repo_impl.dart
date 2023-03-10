import 'package:mindpeers_mobile_flutter/repository/mantraToolRepo/mantra_repo.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';

class MantraRepoImpl extends MantraRepo {
  final GraphQLConfiguration graphQLConfiguration;
  MantraRepoImpl({required this.graphQLConfiguration});
}
