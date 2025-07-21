import 'package:flutter/material.dart';
import 'app_colours.dart';

class AppTextStyles {
  /// Main screen titles – "My Cart", "TN Snacks"
  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  /// Section titles – "Daily Needs", "Featured Items"
  static const TextStyle subHeadings = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  /// View all link, subtle tappable links
  static const TextStyle view = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  /// Labels in Login/Signup like "Email", "Password"
  static const TextStyle loginlogout = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  /// TextButton like “Don’t have an account? Sign up”
  static const TextStyle donthaveaccount = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  /// Item name in list or card
  static const TextStyle itemName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
    color: Colors.black,
  );

  /// Price text like ₹45
  static const TextStyle price = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  /// Quantity or extra info (like "1kg • ₹45")
  static const TextStyle itemSubtitle = TextStyle(
    fontSize: 14,
    color: Colors.black54,
  );

  /// Cart empty message or minor UI
  static const TextStyle body = TextStyle(
    fontSize: 15,
    color: Colors.black87,
  );

  /// Very small labels – "Remember Me", etc.
  static const TextStyle labelSmall = TextStyle(
    fontSize: 13,
    color: Colors.black54,
  );

  /// Button Text – like "Place Order"
  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonTextColor,
  );

  /// Light grey captions like hint or optional text
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
}
