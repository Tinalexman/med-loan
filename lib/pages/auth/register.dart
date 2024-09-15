import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:med_loan/misc/constants.dart';
import 'package:med_loan/misc/functions.dart';
import 'package:med_loan/misc/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final Map<String, String> _authDetails = {
    "firstName": "",
    "lastName": "",
    "email": "",
    "password": "",
  };

  bool showPassword = false;

  @override
  void dispose() {
    lastNameController.dispose();
    firstNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
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
                  "Create a new account with us",
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
                        "First Name",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: firstNameController,
                        prefix: Icon(
                          Icons.person_2_outlined,
                          size: 18.r,
                        ),
                        onValidate: (value) {
                          if (value!.isEmpty) {
                            showToast("Invalid First Name", context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["firstName"] = value!,
                        hint: "e.g John",
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Last Name",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: lastNameController,
                         prefix: Icon(
                          Icons.person_2_outlined,
                          size: 18.r,
                        ),

                        onValidate: (value) {
                          if (value!.isEmpty) {
                            showToast(
                                "Invalid Last Name",
                                context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["lastName"] = value!,
                        hint: "e.g Doe",
                      ),
                      SizedBox(height: 10.h),
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



                      SizedBox(
                        height: 100.h,
                      ),
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
                          context.router.pop();
                        },
                        child: Text(
                          "Create",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: context.textTheme.bodyMedium,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          GestureDetector(
                            onTap: () => context.router.pushNamed(Pages.login),
                            child: Text(
                              "Login",
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
