import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/giftRecipientDetails/gift_recipients_details_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class GiftRecipientDetails extends GetView<GiftRecipientsDetailsController>{
  const GiftRecipientDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundScreen,
      appBar: CustomAppbar(
        voidCallback: ()=>Get.back(),
      ),
      body: Obx(() => giftRecipientDetails()),
    );
  }

  Widget giftRecipientDetails()
  {
    return [
      [
        85.h.toSizedBoxVertical,
        StringsConstant.enterRecipientDetails.toHeading1(),
        9.7.h.toSizedBoxVertical,
        StringsConstant.getCouponViaEmail.toHeading3(fontFamily: FontsConstant.appRegularFont),
        29.57.h.toSizedBoxVertical,
        StringsConstant.name.toHeading2(color: AppColors.colorDavyGray,fontFamily: FontsConstant.appRegularFont),
        10.h.toSizedBoxVertical,
        toTextFormField(controller: controller.nameController,validator:(value)=>TherapyRecipientFormValidation.validateName(value!)),
        19.29.h.toSizedBoxVertical,
        StringsConstant.email.toHeading2(color: AppColors.colorDavyGray,fontFamily: FontsConstant.appRegularFont),
        10.h.toSizedBoxVertical,
        toTextFormField(controller: controller.emailController,validator:(value)=>TherapyRecipientFormValidation.validateEmail(value!),keyboardType: TextInputType.emailAddress),
        19.29.h.toSizedBoxVertical,
        StringsConstant.confirmEmail.toHeading2(color: AppColors.colorDavyGray,fontFamily: FontsConstant.appRegularFont),
        10.h.toSizedBoxVertical,
        toTextFormField(controller: controller.confirmEmailController,validator:(value)=>TherapyRecipientFormValidation.validateConfirmEmail(email: controller.emailController.text, confirmEmail: value!),keyboardType: TextInputType.emailAddress),
        19.29.h.toSizedBoxVertical,
        StringsConstant.phone.toHeading2(color: AppColors.colorDavyGray,fontFamily: FontsConstant.appRegularFont),
        10.h.toSizedBoxVertical,
        [
          controller.countryCodeList.toMobileCodeDropdown(selectedCountryCode: controller.selectedCountryCode.value, onChange: (countryCodeItem) {controller.selectedCountryCode.value=countryCodeItem!;}).toSizedBox(47.h, 90.w),
          15.85.w.toSizedBoxHorizontal,
          toTextFormField(controller: controller.phoneController,validator:(value)=>TherapyRecipientFormValidation.validateMobile(value!),keyboardType: TextInputType.phone).toExpanded(),
        ].toRow(crossAxisAlignment: CrossAxisAlignment.start)
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toSingleChildScrollView.toExpanded(),

      30.h.toSizedBoxVertical,
      "Proceed To Payment".toHeading2(fontFamily: FontsConstant.appRegularFont).toRoundedButtonMatchParent(()=>controller.checkTherapyRecipientValidation()),
      30.h.toSizedBoxVertical
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toSafeArea.toForm(globalKey: controller.giftRecipientFormKey).toHorizontalPadding(33.w);
  }

}