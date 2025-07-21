import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_values.dart';
import 'package:tn70snacks/tn70snacksapp/controller/auth_controller.dart';
import 'package:tn70snacks/tn70snacksapp/view/auth/signup_view.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email / Phone", style: AppTextStyles.loginlogout),
                const SizedBox(height: AppValues.smallSpacing),
                _buildTextField(emailController, 'demo@gmail.com'),

                const SizedBox(height: AppValues.mediumSpacing),
                Text("Password", style: AppTextStyles.loginlogout),
                const SizedBox(height: AppValues.smallSpacing),
                _buildTextField(passwordController, 'Password', isPassword: true),

                const SizedBox(height: AppValues.smallSpacing),
                Row(
                  children: [
                    Obx(() => Checkbox(
                      value: authController.isremember.value,
                      onChanged: (value) {
                        authController.isremember.value = value ?? false;
                      },
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                            (states) => states.contains(MaterialState.selected)
                            ? AppColors.primary
                            : Colors.white,
                      ),
                    )),
                    const Text("Remember me", style: AppTextStyles.labelSmall),
                    const Spacer(),
                    const Text("Forgot password?", style: AppTextStyles.labelSmall),
                  ],
                ),

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
                    authController.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  },
                  child: const Text("Sign In", style: AppTextStyles.buttonText),
                ),

                const SizedBox(height: AppValues.largeSpacing),
                Center(
                  child: Column(
                    children: [
                      const Text("Or"),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sign in with"),
                          TextButton(
                            onPressed: () {
                            },
                            child: const Text("OTP", style: TextStyle(fontSize: 18))
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => SignUpScreen()),
                        child: Text(
                          "Don't have an account? Sign up",
                          style: AppTextStyles.donthaveaccount,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Continue as"),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: authController.loginAsGuest,
                            child: Text("Guest", style: TextStyle(color: AppColors.primary)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.caption,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppValues.borderRadius),
        ),
      ),
    );
  }
}
