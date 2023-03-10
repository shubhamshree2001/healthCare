import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/binding/authBinding/account_list_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/authBinding/login_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/authBinding/welcome_screenBinding.dart';
import 'package:mindpeers_mobile_flutter/binding/club/events_details_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/club/expand_post_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/club/more_club_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/club/my_vents_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/club/new_post_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/club/plan_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/club/worksheet_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/guidesBinding/guideBreathingBinding.dart';
import 'package:mindpeers_mobile_flutter/binding/guidesBinding/guidesAudioTempelateBinding.dart';
import 'package:mindpeers_mobile_flutter/binding/guidesBinding/guides_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/mantraBinding/mantraBinding.dart';
import 'package:mindpeers_mobile_flutter/binding/mciBinding/mciReportProgress_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/mciBinding/mci_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/settingsBinding/profile_screen_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/booking_confirmed_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/gift_therapy_checkout_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/gift_therapy_session_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/homework_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/match_therapy_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/search_therapists_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/therapy_booking_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/therapy_payment_summary_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/therapy_slot_details_binding.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/accountList/account_list_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/login/loginScreenDarkMode.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/otpScreen/otpVerifyEmailScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/resetPassword/resetPasswordDarkMode.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/sendResetLink/send_resetLinkDarkModeScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/pastPlans/past_plans.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/signup/privacyPolicyWebWiewScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/signup/signupScreenDarkMode.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/signup/signup_screen.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/doctor_details_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/therapy/gift_recipient_details_binding.dart';
import 'package:mindpeers_mobile_flutter/ui/club/eventDetails/event_details.dart';
import 'package:mindpeers_mobile_flutter/ui/club/expandPost/expand_post_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/club/more_clubs/more_club_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/club/myVents/my_vents_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/club/worksheets/worksheets_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/welcomeScreen/welcomeScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideAudioTemppelate/guideAudioTemelate.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideBreathing/guideBoxBreathing.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideBreathing/guidesBaloonBreathing.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideBreathing/guidesTranquilizerBreathing.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideModule/guideModule.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideModule/guideSelectFIlter.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guidesCaptionTempelate/guidesCaptionTempelate.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guides_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/mantraTool/mantraLandingScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciBeginQuestion/mciQuestionScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciBeginQuestion/mciScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciReportGenerated/mciReportGenerated.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciReportProgree/mciReportProcessingScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/bookingConfirmed/booking_confirmed_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/matchTherapy/match_therapy_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/search/search_therapists_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapyBooking/therapy_booking_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapyPaymentSummary/therapy_payment_summary_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapySlotDetails/therapy_slot_details.dart';
import 'package:mindpeers_mobile_flutter/widgets/animation_demo.dart';
import '../binding/settingsBinding/setting_binnding.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/doctorDetails/doctor_details_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/giftCheckoutSuccess/gift_checkout_success_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/giftRecipientDetails/gift_recipient_details.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/giftTherapySessions/gift_therapy_sessions_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/previouslyMatchedTherapy/previouslyMatchedTherapyScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapyHomework/therapy_homework_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapygiftCheckout/gift_checkout_screen.dart';
import 'package:mindpeers_mobile_flutter/binding/authBinding/otp_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/authBinding/send_reset_link_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/webviewBinding/webview_binding.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/resetPassword/reset_password_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/sendResetLink/send_reset_link_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/dashboard/home_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/webView/webview_screen.dart';
import '../binding/authBinding/reset_password_binding.dart';
import '../binding/authBinding/signup_binding.dart';
import '../binding/dashboard/dashboard_binding.dart';
import '../ui/authentication/login/login_screen.dart';
import '../ui/authentication/settings/profile/profile_screen.dart';
import '../ui/authentication/settings/referUs/refer_screen.dart';
import '../ui/authentication/settings/settingScreen/settings_screen.dart';
import '../ui/authentication/otpScreen/otp_screen.dart';
import '../ui/club/newPost/new_post_screen.dart';
import '../ui/club/plan/plan_screen.dart';
import '../ui/dashboard/dashboard_screen.dart';
import 'package:mindpeers_mobile_flutter/binding/settingsBinding/settingResetPassword_binding.dart';
import 'package:mindpeers_mobile_flutter/binding/settingsBinding/myPlans_binding.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/ActivePlans/activePlans.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/communityPlans/communityPlans_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/myPlans_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/plan_Purchased.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/therapyPlans/therapyPlansScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/setingResetPassword/settingResetPassword_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/settingAbout/about.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.animation,
      page: () => const MciReportProgressScreen(),
    ),
    GetPage(
        name: Routes.initial,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
      name: Routes.signup,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.accountList,
      page: () => const AccountListScreen(),
      binding: AccountListBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.setting,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.refer,
      page: () => const ReferScreen(),
      binding: SettingBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.otp,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.sendResetLink,
      page: () => const SendResetLinkScreen(),
      binding: SendResetLinkBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      //binding: SendResetLinkBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.webView,
      page: () => const WebViewScreen(),
      binding: WebViewBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.settingResetPassword,
      page: () => const SettingResetPasswordScreen(),
      binding: SettingResetPasswordBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.myPlans,
      page: () => const MyPlansScreen(),
      binding: MyPlansBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.therapyPlans,
      page: () => const TherapyPlansScreen(),
      binding: MyPlansBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.communityPlans,
      page: () => const CommunityPlansScreen(),
      binding: MyPlansBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.activePlans,
      page: () => const ActivePlansScreen(),
      binding: MyPlansBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.planPurchased,
      page: () => const PlanPurchasedScreen(),
      binding: MyPlansBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.about,
      page: () => const AboutScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.doctorDetails,
      page: () => const DoctorDetailsScreen(),
      binding: DoctorDetailsBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.giftTherapySession,
      page: () => const GiftTherapySessions(),
      binding: GiftTherapySessionBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.giftRecipientDetails,
      page: () => const GiftRecipientDetails(),
      binding: GiftRecipientsDetailsBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.giftTherapyCheckout,
      page: () => const GiftCheckoutScreen(),
      binding: GiftTherapyCheckoutBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.giftTherapyCheckoutSuccess,
      page: () => const GiftCheckoutSuccessScreen(),
      // binding: GiftRecipientsDetailsBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.therapyHomework,
      page: () => const TherapyHomework(),
      binding: HomeWorkBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.previouslyMatchedTherapy,
      page: () => const PreviouslyMatchedTherapyScreen(),
      // binding: GiftRecipientsDetailsBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.pastPlans,
      page: () => const PastPlansScreen(),
      binding: MyPlansBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.therapyBooking,
      page: () => const TherapyBookingScreen(),
      binding: TherapyBookingBinding(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.therapySlotDetails,
      page: () => const TherapySlotDetails(),
      binding: TherapySlotDetailsBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.therapyPaymentSummary,
      page: () => const TherapyPaymentSummaryScreen(),
      binding: TherapyPaymentSummaryBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.bookingConfirmed,
      page: () => const BookingConfirmedScreen(),
      binding: BookingConfirmedBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.matchedTherapy,
      page: () => MatchTherapyScreen(),
      binding: MatchTherapyBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.searchTherapists,
      page: () => const SearchTherapistsScreen(),
      binding: SearchTherapistsBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.mciScreen,
      page: () => const MciScreen(),
      binding: MciBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.mciQuestionScreen,
      page: () => const MciQuestionScreen(),
      binding: MciBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.mciReportScreen,
      page: () => const MciReportScreen(),
      binding: MciBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.reportProgress,
      page: () => const MciReportProgressScreen(),
      binding: MciReportProgressBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.moreClub,
      page: () => const MoreClubScreen(),
      binding: MoreClubBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.myVents,
      page: () => const MyVentsScreen(),
      binding: MyVentsBinding(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.newPost,
      page: () => const NewPostScreen(),
      binding: NewPostBinding(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.expandPost,
      page: () => const ExpandPostScreen(),
      binding: ExpandPostBinding(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.plan,
      page: () => const PlanScreen(),
      binding: PlanBinding(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.worksheets,
      page: () => const WorkSheetsScreen(),
      binding: WorksheetBinding(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      fullscreenDialog: true,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.eventsDetails,
      page: () => const EventDetails(),
      binding: EventsDetailsBinding(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: Routes.signupDarkMode,
      page: () => const SignupDarkModeScreen(),
      binding: SignupBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.privacyPolicyScreen,
      page: () => const PrivacyPolicyDarkModeScreen(),
      binding: SignupBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.welcomeScreen,
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.emailOtpScreen,
      page: () => const OtpEmailScreen(),
      binding: OtpBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.sendResetLinkDarkMode,
      page: () => const SendResetLinkDarkModeScreen(),
      binding: SendResetLinkBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.resetPasswordDarkMode,
      page: () => const ResetPasswordDarkModeScreen(),
      binding: ResetPasswordBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.loginDarkModeScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.guidesScreen,
      page: () => const GuidesScreen(),
      binding: GuidesBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.demoScreen,
      page: () => SampleAnimation(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: Routes.guideModule,
      page: () => const GuidesModuleScreen(),
      binding: GuidesBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: Routes.guidesSelectFIlterScreen,
      page: () => const GuidesSelectFilterScreen(),
      binding: GuidesBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
        name: Routes.guideCaptionScreen,
        page: () => const GuidesCaptionScreen(),
        binding: GuidesBinding(),
        transition: Transition.leftToRight),
    GetPage(
      name: Routes.guideAudioModule,
      binding: GuidesAudioTemelateBinding(),
      page: () => const GuidesAudioTempelateScreen(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: Routes.guidesBoxBreathing,
      page: () => const GuidesBoxBreathingScreen(),
      binding: GuidesAudioTemelateBinding(),
    ),
    GetPage(
      name: Routes.guidesBalloonBreathing,
      page: () => const GuidesBalloonBreathingScreen(),
      binding: GuidesBreathingBinding(),
    ),
    GetPage(
      name: Routes.guidesTranquilizerBreathing,
      page: () => const GuidesTranquilizerBreathingScreen(),
      binding: GuidesBreathingBinding(),
    ),
    GetPage(
      name: Routes.mantraLandingScreen,
      page: () => const MantraLandingScreen(),
      binding: MantraBinding(),
      transition: Transition.leftToRight,
    ),
  ];
}
