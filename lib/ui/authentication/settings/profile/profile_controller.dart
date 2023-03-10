import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/updateUser_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/getSignedUrlResponse.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/auth_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/setting_query_Mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import '../../../../data/models/authModel/country_code_list_response.dart';
import '../../../../widgets/common_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final SettingRepo settingRepo;
  ProfileController({required this.settingRepo});

  final nameController = TextEditingController();
  var user = GetUser().obs;
  var signedUrl = GetSignedUrl().obs;
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  var isProfilePicPathSet = false.obs;
  var profilePicPath = "".obs;
  var selectedRoleDrowpdown = 'Student'.obs;
  List roleDropdownItem = [
    'Student',
    'Intern',
    'Freelancer',
    'Full-Time Employee',
    'Homemaker',
    'Entrepreneur',
    'Other'
  ].obs;
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  var dateOfBirth = "dd/MM/yyyy".obs;
  var selectedCountryCode = CountryCodeItem().obs;
  var countryCodeList = <CountryCodeItem>[].obs;
  List<String> genderList = ["MALE", "FEMALE", "NON-BINARY"].obs;
  var selectedGender = "".obs;
  var selectedImagePath = "".obs;
  var selectedImageSize = "".obs;
  var isChanged = false.obs;
  var profileImage = "".obs;
  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();
  @override
  void onInit() {
    initEasyLoading();
    getCountryCodeList();
    getUser();
    getTheSignedUrl();
    super.onInit();
  }

  // Future<void> getImage(ImageSource imageSource) async {
  //   final pickedFile = await ImagePicker().pickImage(source: imageSource);
  //   if (pickedFile != null) {
  //     selectedImagePath.value = pickedFile.path;
  //     //selectedImageSize.value =
  //     //  ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
  //     //        .toStringAsFixed(2) +
  //     //  "Mb";
  //   } else {
  //     Get.snackbar(
  //       'Error',
  //       'No image selected',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  Future<void> getImage(ImageSource imageSource) async {
    final pickedImage =
        await imagePicker.pickImage(source: imageSource, imageQuality: 100);
    pickedFile = File(pickedImage!.path);
    setProfileImagePath(pickedFile!.path);
    // print(pickedFile);
  }

  void setProfileImagePath(String path) {
    profilePicPath.value = path;
    isProfilePicPathSet.value = true;
  }

  // Future<void> uploadImage() async {
  //   var uploadUrl = signedUrl.value.uri!;
  //   try {
  //     List<int> imageBytes = pickedFile!.readAsBytesSync();
  //     String baseImage = base64Encode(imageBytes);
  //     var response = await http.post(uploadUrl, body: {
  //       'image': baseImage,
  //     });
  //     if (response.statusCode == 200) {
  //       var jsondata = jsonDecode(response.body);
  //       if (jsondata["error"]) {
  //         print(jsondata["msg"]);
  //       }
  //     } else {
  //       print("Upload successful");
  //     }
  //   } catch (e, stacktrace) {
  //     print("Exception==$e");
  //     print("Stacktrace==${stacktrace.toString()}");
  //     EasyLoading.dismiss();
  //   }
  // }

  Future<void> getCountryCodeList() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await settingRepo
          .getCountryCodeList(AuthQueryMutation.getCountryCodeList(""));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.countryCodeList != null && r.countryCodeList!.isNotEmpty) {
          selectedCountryCode.value = r.countryCodeList![0];
          countryCodeList.value = r.countryCodeList!;
        }

        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> getTheSignedUrl() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either =
          await settingRepo.getSignedUrl(SettingQueryMutation.getSignedUrl());
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.getSignedUrl != null)
        // r.getSignedUrl!.filename!.isNotEmpty &&
        // r.getSignedUrl!.type!.isNotEmpty &&
        // r.getSignedUrl!.uri!.isNotEmpty &&
        // r.getSignedUrl!.url!.isNotEmpty
        {
          signedUrl.value = r.getSignedUrl!;
          //showSnackBar("success", "Thank you for updating us", false);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> updateProfileRequest(String query) async {
    try {
      //EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await settingRepo.updateUser(query);
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.authMutation != null) {
          showSnackBar("success", "Thank you for updating us", false);
          isChanged.value = false;
        }

        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void profileUpdateValidation() {
    hideSoftKeyboard(Get.context!);
    var updateProfielRequest = UpdateProfileRequest(
      token: LocalStorage.getAccessToken(),
      photo: pickedFile.toString(),
      name: nameController.text.toString(),
      dob: dateOfBirth.value,
      gender: selectedGender.value,
      roleDescription: selectedRoleDrowpdown.value,
    );

    updateProfileRequest(SettingQueryMutation.updateUser(updateProfielRequest));
  }

  Future<void> getUser() async {
    try {
      final either = await settingRepo.getUser(AuthQueryMutation.getUser());
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth?.getUser != null) {
          user.value = r.auth!.getUser!;
          emailController.text = user.value.email!;
          nameController.text = user.value.name!;
          mobileController.text = user.value.contact!.mobile!;
          selectedRoleDrowpdown.value = user.value.role!;
          selectedGender.value = user.value.gender!;
          dateOfBirth.value = AppUtil.convertStringToDateFormat(
              user.value.dob!.date,
              format: AppUtil.dateTimeDDMMYYYY);
          //profileImage.value = user.value.profile!;

          //selectedCountryCode.value = user.value.contact.code;
          // getTherapyPlanByType();  uncommentIt
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");

      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      dateOfBirth.value =
          DateFormat("dd-MM-yyyy").format(pickedDate).toString();
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    mobileController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
