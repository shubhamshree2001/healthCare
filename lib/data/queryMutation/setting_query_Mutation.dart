import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/deleteUser_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/giftCouponRequest.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/listmyPlans_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/logoutUser.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/referUs_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/submitFeedback_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/updateUser_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/update_password_request.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapygiftCheckout/gift_checkout_screen.dart';

class SettingQueryMutation {
  static String submitEnquiry(ReferUsRequest referUsRequest) {
    return ''' mutation submitEnquiry{
  submitEnquiry(contact: {code: "${referUsRequest.code}", mobile: "${referUsRequest.mobileNo}"}, name: "${referUsRequest.name}", email: "${referUsRequest.email}", company: "${referUsRequest.company}", via: "${referUsRequest.via}",)
}''';
  }

  static String updatePassword(ChangePasswordRequest changePasswordRequest) {
    return '''mutation updatePassword{
  authMutation(token: "${changePasswordRequest.token}") {
    update {
      updatePassword(current: "${changePasswordRequest.current}", update: "${changePasswordRequest.update}")
    }
  }
}''';
  }

  static String updateUser(UpdateProfileRequest updateProfileRequest) {
    return '''mutation updateUser {
  authMutation(token: "${LocalStorage.getAccessToken()}") {
    update {
      updateUser(updateUser(dob: "",name: "${updateProfileRequest.name}", photo: "", roleDescription: "${updateProfileRequest.roleDescription}", gender: MALE)
    }
  }
}''';
  }

  static String getFeedbackQuestionsList() {
    return ''' query getFeedbackQestionsList{
  auth(token: "${LocalStorage.getAccessToken()}") {
    getSettingsMenuData {
      questions {
        app_feedback_question {
          id 
          kind
          question
        }
        star_rating_question {
          id
          kind
          question
        }
        user_feedback_question {
          id
          kind
          question
        }
      }
    }
  }
}''';
  }

  static String submitUserFeedback(SubmitFeedbackRequest submitFeedbackRequest,{String? kind="USER_SETTING"}) {
    return ''' mutation submitFeedBack{
  authMutation(token: "${submitFeedbackRequest.token}") {
    create {
      submitFeedback(answers: {question: "${submitFeedbackRequest.question}", answer: "${submitFeedbackRequest.answer}"}, id: "${submitFeedbackRequest.id}", kind: $kind)
    }
  }
}''';
  }

  static String deleteUser(DeleteUserRequest deleteUserRequest) {
    return '''mutation deleteUser{
  authMutation(token: "${deleteUserRequest.token}") {
    update {
      deleteUser
    }
  }
}''';
  }

  static String getActivePlansList(String accessToken) {
    return ''' query activePlansList {
  auth(token: "$accessToken") {
    listMyPlans(filter: "ACTIVE") {
      plans {
        buy_again_option
        heading
        is_gift
        name
        plan_id
        purchased_on
        total_credits
        valid_till
      }
      summaryCards {
        card_type
        heading
        icon
        sub_heading
        credits {
          active_credits
          expired_credits
          total_credits
          used_credits
        }
        cta {
          text
          deeplink {
            screen
          }
        }
        warning {
          color
          text
        }
      }
    }
  }
}''';
  }

  static String getPastPlansList(String acessToken) {
    return ''' query pastPlansList {
  auth(token: "$acessToken") {
    listMyPlans(filter: "PAST") {
      plans {
        valid_till
        total_credits
        buy_again_option
        heading
        is_gift
        name
        plan_id
        purchased_on
      }
      credits {
        used_credits
        expired_credits
      }
    }
  }
}''';
  }

  static String redeemGift(GiftCouponRequest giftCouponRequest) {
    return '''
  mutation redeemGift{
  authMutation(token: "${LocalStorage.getAccessToken()}") {
    update {
      redeemGiftv2(code: "${giftCouponRequest.giftCode}") {
        expiry
        success
      }
    }
  }
}''';
  }

  static String logout(LogOutUserRequest logOutUserRequest) {
    return ''' mutation logout {
  authMutation(token: "${logOutUserRequest.token}") {
    update {
      logout
    }
  }
}''';
  }

  static String getSignedUrl() {
    return '''query getSignedUrl {
  getSignedUrl(filename: "", type: USERS_PROFILE) {
    filename
    type
    uri
    url
  }
}''';
  }
}
