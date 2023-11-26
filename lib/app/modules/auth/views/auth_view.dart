import 'package:edu_care/app/routes/app_pages.dart';
import 'package:edu_care/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_controller.dart';
import 'widgets/animated_button.dart';
import 'widgets/app_logo.dart';
import 'widgets/email_field.dart';
import 'widgets/google_sign_in_button.dart';
import 'widgets/password_field.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            children: [
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppLogo(),
                      const SizedBox(
                        height: 80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Login',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: primaryTextColor.withOpacity(.8),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Please sign in to continue',
                                style: TextStyle(
                                    fontSize: 16, color: secondaryTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      EmailField(emailController: emailController),
                      const SizedBox(height: 16),
                      PasswordField(
                        passwordController: passwordController,
                        hint: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password must not be empty';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => AnimatedButton(
                              isLoading: authController.isLoading.value,
                              text: 'SIGN IN',
                              onTap: authController.isLoading.value
                                  ? () {}
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        // Validation passed, proceed with sign-in
                                        await authController
                                            .signInWithEmailAndPassword(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                        );
                                      }
                                    },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      GoogleSignInButton(
                        onTap: () async {
                          await authController.signInWithGoogle();
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
