import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/view/auth/signin_view.dart';
import 'package:tn70snacks/tn70snacksapp/view/auth/signup_view.dart';
import '../controller/home_controller.dart';
import '../controller/cart_controller.dart';
import '../controller/favourite_controller.dart';
import '../controller/user_controller.dart';
import '../view/cart/cart_view.dart';
import '../view/favourite/favourite_screen_view.dart';
import '../view/home/home_view.dart';
import '../view/home/snacks_view.dart';
import '../view/order/order_view.dart';
import '../view/product_details/product_details_view.dart';
import '../view/profile/profile_view.dart';
import '../view/profile/update_profile_view.dart';
import '../view/splash/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: AppRoutes.signin,
      page: () => LoginScreen(),
    ),

    GetPage(
      name: AppRoutes.signup,
      page: () => SignUpScreen(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      bindings: [
        BindingsBuilder(() {
          Get.lazyPut(() => HomeController());
          Get.lazyPut(() => CartController());
          Get.lazyPut(() => FavouriteController());
          Get.lazyPut(() => UserController());
        }),
      ],
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.viewAll,
      page: () => SnackGridScreen(),
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.favourite,
      page: () => FavoriteScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FavouriteController());
      }),
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.cart,
      page: () => CartScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
      }),
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.productDetails,
      page: () => ProductDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
      }),
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.orderdetails,
      page: () => OrderView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
        Get.lazyPut(() => HomeController());
      }),
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserController());
      }),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserController());
      }),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 500),
    ),

  ];
}
