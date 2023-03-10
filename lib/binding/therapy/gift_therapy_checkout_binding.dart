import 'package:get/get.dart';
import '../../repository/therapyRepo/therapy_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';
import '../../ui/therapy/therapygiftCheckout/gift_therpy_checkout_controller.dart';

class GiftTherapyCheckoutBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(GiftTherapyCheckoutController(therapyRepo: Get.put(TherapyRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}