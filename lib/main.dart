import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mindpeers_mobile_flutter/paymentGatway/razorpayService/razorpay_client.dart';
import 'package:mindpeers_mobile_flutter/pushNotification/notification_service.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:skeletons/skeletons.dart';
import 'data/localStorage/local_storage.dart';

import 'routes/app_pages.dart';

/// This is a starting points of app

/// This method is called when application is in background.
Future<void> backgroundHandler(RemoteMessage remoteMessage) async {
  await Firebase.initializeApp();
  if (remoteMessage != null) {
    print("Title==${remoteMessage.notification!.title}");
    print("Body==${remoteMessage.notification!.body}");
    NotificationService.displayNotification(remoteMessage);
  }
}

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  NotificationService.initialize();

  /// Making GraphQLConfiguration class as singleton
  Get.create<GraphQLConfiguration>(() => GraphQLConfiguration());
  Get.create<RazorPayClient>(() => RazorPayClient());
  runApp(
    GraphQLProvider(
      client: Get.find<GraphQLConfiguration>().client,
      child: const CacheProvider(child: MindPeersApp()),
    ),
  );
}

class MindPeersApp extends StatelessWidget {
  const MindPeersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) => SkeletonTheme(
              themeMode: ThemeMode.dark,
              shimmerGradient: const LinearGradient(
                colors: [
                  Color(0xFFD8E3E7),
                  Color(0xFFC8D5DA),
                  Color(0xFFD8E3E7),
                ],
                stops: [
                  0.1,
                  0.5,
                  0.9,
                ],
              ),
              darkShimmerGradient: const LinearGradient(
                colors: [
                  Color(0xFF222222),
                  Color(0xFF242424),
                  Color(0xFF2B2B2B),
                  Color(0xFF242424),
                  Color(0xFF222222),
                ],
                stops: [
                  0.0,
                  0.2,
                  0.5,
                  0.8,
                  1,
                ],
                begin: Alignment(-2.4, -0.2),
                end: Alignment(2.4, 0.2),
                tileMode: TileMode.repeated,
              ),
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Mindpeers',
                onInit: () {},
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                // initialRoute: LocalStorage.getIsLogin()
                //     ? Routes.dashboard
                //     : Routes.welcomeScreen,
                initialRoute: Routes.guidesScreen,
                //initialRoute: Routes.guideCaptionScreen,
                //initialRoute: Routes.guidesSelectFIlterScreen,
                //initialRoute: Routes.guideModule,
                //initialRoute: Routes.mantraLandingScreen,
                //initialRoute: Routes.demoScreen,
                //initialRoute: Routes.guidesTranquilizerBreathing,

                getPages: AppPages.pages,
                builder: EasyLoading.init(),
              ),
            ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
