import 'package:get/get.dart';
import '../../repository/therapyRepo/therapy_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';
import '../../ui/therapy/giftRecipientDetails/gift_recipients_details_controller.dart';

class GiftRecipientsDetailsBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(GiftRecipientsDetailsController(therapyRepo: Get.put(TherapyRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}