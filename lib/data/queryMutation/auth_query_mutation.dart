import '../localStorage/local_storage.dart';
import '../models/authModel/request/signup_request.dart';

class AuthQueryMutation {
  static String getListOfAllAccounts(String email) {
    return ''' query listAllAccounts {
  listAllAccounts(email:"$email") {                
    orgName
    userEmail
    userName
    logo 
    orgId
  }
}
''';
  }

  static String getCountryCodeList(String accessCode) {
    return ''' query listCountryCodesV2 {
  listCountryCodesV2(accessCode: "$accessCode") {
    code
    flag
  }
}''';
  }

  static String userSignup(SignupRequest signupRequest) {
    return ''' mutation signupUser {
  signupUser(contact: {code: "${signupRequest.code}", mobile: "${signupRequest.mobileNo}"}, email: "${signupRequest.email}", name: "${signupRequest.name}", password: "${signupRequest.password}") {
    accessToken
    refreshToken
    verifyToken
  }
}
''';
  }

  static String userSignupCorporate(SignupRequest signupRequest) {
    return ''' mutation signupUser {
  signupUser(contact: {code: "${signupRequest.code}", mobile: "${signupRequest.mobileNo}"}, email: "${signupRequest.email}", name: "${signupRequest.name}", password: "${signupRequest.password}", org: "${signupRequest.org}") {
    accessToken
    refreshToken
    verifyToken
  }
}
''';
  }

  static String verifyOtp(String otp, String verifyToken) {
    return ''' mutation verify {
  verify(otp: "$otp", verifyToken: "$verifyToken") {
    accessToken
    refreshToken
    verifyToken
  }
}
''';
  }

  static String userLogin(String email, String password) {
    return ''' query login {
  login(email: "$email", password: "$password") {
    accessToken
    refreshToken
    verifyToken
  }
}''';
  }

  static String sendLinkForgotPass(String email) {
    return '''query forgotPassword {
  forgotPassword(email: "$email")
}''';
  }

  static String getOrganization(String accessCode) {
    return '''query getOrganisation {
 getOrganisation(accessCode: "$accessCode") {
    id
  }
}''';
  }

  static String getUser() {
    return '''query {
            auth(token: "${LocalStorage.getAccessToken()}") {
              getUser(offset: -330, timezone: "Asia/Calcutta"){
                id
                contact{
                  mobile
                  code
                }
                name
                is_gift_sending_enabled
                is_profile_exists
                email
                profile
                app_update {
                  force_update
                  update
                }
                gender
                role
                dob {
                  date
                  year
                  month
                  day
                }
                organisation{
                  chat_widget_links{
                    tawk_to_embed_link
                    tawk_to_direct_link
                  }
                  is_boat_enabled
                  is_therapy_enabled
                  is_self_care_enabled
                  branding_logo
                }
                designation
                region{
                  id
                }
                is_b2c
                units {
                  session
                }
              }
            }
        }''';
  }
}
