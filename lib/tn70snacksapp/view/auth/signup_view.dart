import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_values.dart';
import 'package:tn70snacks/tn70snacksapp/view/auth/signin_view.dart';
import '../../controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppValues.largeSpacing),
              Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: media.width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: AppValues.xLargeSpacing),

              _buildLabel("Name"),
              _buildTextField(nameController, 'Name'),

              const SizedBox(height: AppValues.mediumSpacing),
              _buildLabel("Email"),
              _buildTextField(emailController, 'Email'),

              const SizedBox(height: AppValues.mediumSpacing),
              _buildLabel("Password"),
              _buildTextField(passwordController, 'Password', isPassword: true),

              const SizedBox(height: AppValues.largeSpacing),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60),
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: AppColors.buttonTextColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppValues.borderRadius),
                  ),
                ),
                onPressed: () {
                  authController.signup(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: const Text("Sign Up", style: AppTextStyles.buttonText),
              ),

              const SizedBox(height: AppValues.largeSpacing),

              Center(
                child: TextButton(
                  onPressed: () => Get.to(() => LoginScreen()),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account", style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 10),
                      Text("Login", style: AppTextStyles.donthaveaccount),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: Text(label, style: AppTextStyles.loginlogout),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppValues.smallSpacing),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.caption,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppValues.borderRadius),
          ),
        ),
      ),
    );
  }
}
