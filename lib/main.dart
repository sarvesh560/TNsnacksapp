import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:tn70snacks/tn70snacksapp/controller/auth_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/user_controller.dart';
import 'package:tn70snacks/tn70snacksapp/routes/app_pages.dart';
import 'package:tn70snacks/tn70snacksapp/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // Eagerly put controllers
  Get.put(AuthController(), permanent: true);
  Get.put(UserController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      title: 'TN70 Snacks',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
    );
  }
}
