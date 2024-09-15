import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:med_loan/misc/constants.dart';
import 'package:med_loan/misc/functions.dart';
import 'package:med_loan/misc/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Map<String, String> _authDetails = {
    "email": "",
    "password": "",
  };

  bool showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 63.h,
                ),
                Text(
                  "MedLoan",
                  style: context.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: monokai,
                  ),
                ),
                Text(
                  "Welcome back",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 32.h),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        "Email",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: emailController,
                        prefix: Icon(
                          Icons.mail_outline_rounded,
                          size: 18.r,
                        ),
                        type: TextInputType.emailAddress,
                        onValidate: (value) {
                          if (value!.isEmpty || !value.contains("@")) {
                            showToast("Invalid Email Address", context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["email"] = value!,
                        hint: "e.g johndoe@mail.com",
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Password",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      SpecialForm(
                        obscure: !showPassword,
                        width: 390.w,
                        height: 40.h,
                        controller: passwordController,
                        type: TextInputType.text,
                        prefix: Icon(
                          Icons.lock_outline_rounded,
                          size: 18.r,
                        ),
                        suffix: GestureDetector(
                          onTap: () =>
                              setState(() => showPassword = !showPassword),
                          child: AnimatedSwitcherTranslation.right(
                            duration: const Duration(milliseconds: 500),
                            child: Icon(
                              !showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 18.r,
                              key: ValueKey<bool>(showPassword),
                            ),
                          ),
                        ),
                        onValidate: (value) {
                          if (value!.length < 6) {
                            showToast(
                                "Password is too short. Use at least 6 characters",
                                context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["password"] = value!,
                        hint: "********",
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Forgot your password? ",
                            style: context.textTheme.bodyMedium,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          GestureDetector(
                            // onTap: () => context.router.pushNamed(Pages.forgot),
                            child: Text(
                              "Click here",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 250.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(390.w, 50.h),
                          backgroundColor: primary,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.5.r),
                          ),
                        ),
                        onPressed: () {
                          context.router.pushReplacementNamed(Pages.home);
                        },
                        child: Text(
                          "Log In",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: context.textTheme.bodyMedium,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          GestureDetector(
                            onTap: () => context.router.pushNamed(Pages.register),
                            child: Text(
                              "Register",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
