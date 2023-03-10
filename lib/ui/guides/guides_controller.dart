import 'package:get/get.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/getModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleFIlterResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/guides_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/guidesRepo/guides_repo.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class GuidesController extends GetxController {
  final GuidesRepo guidesRepo;
  GuidesController({required this.guidesRepo});
  var listModules = <ListModule>[].obs; //forSearchText
  var listofFilters = <ListModuleFilter>[].obs;
  var listOfModuleTopics = <TopicElement>[].obs;
  var listOfStories = <Story>[].obs;
  PageController pageViewController = PageController();
  final searchController = TextEditingController();
  var filterText = "".obs;
  var searchText = "".obs;
  var initial = 0.0.obs;

  @override
  void onInit() {
    getListModules();
    getListModulesFilters();
    //getModulesLastSession();
    //getModules();
    debounce(filterText, (callback) => {getListModules()},
        time: const Duration(milliseconds: 300));
  }

  Future<void> getListModulesFilters() async {
    try {
      final either = await guidesRepo
          .getListModulesFilters(GuidesQueryMutation.getListModulesFilters());
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null) {
          listofFilters.value = r.auth!.listModuleFilters!;
        } else {}
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getListModules() async {
    try {
      final either = await guidesRepo.getListModules(
          GuidesQueryMutation.getListModules(searchText: filterText.value));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null &&
            r.auth!.listModules != null &&
            r.auth!.listModules!.isNotEmpty) {
          //listModules.value = r.auth!.listModules!;
          listModules.clear();
          listModules.addAll(r.auth!.listModules!);
        } else {}
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getModules(String slug) async {
    try {
      final either =
          await guidesRepo.getModules(GuidesQueryMutation.getModules(slug));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null) {
          listOfModuleTopics.value = r.auth!.getModule!.module!.topics!;
          listOfStories.value =
              r.auth!.getModule!.module!.contents![1].stories!;
          print(listOfStories.length);
        } else {}
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getModulesLastSession(String slug) async {
    try {
      final either = await guidesRepo.getListModulesFilters(
          GuidesQueryMutation.getModulesLastSession(slug));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null) {
        } else {}
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> submitModuleStatistics() async {
    try {
      final either = await guidesRepo
          .getListModulesFilters(GuidesQueryMutation.sumbmitModuleStatistics());
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null) {
        } else {}
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> submitModuleFeedback() async {
    try {
      final either = await guidesRepo
          .getListModulesFilters(GuidesQueryMutation.submitModuleResponse());
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null) {
        } else {}
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> submitModuleResponse() async {
    try {
      final either = await guidesRepo
          .getListModulesFilters(GuidesQueryMutation.submitModuleFeedback());
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null) {
        } else {}
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }
}
