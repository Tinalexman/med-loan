import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:med_loan/misc/constants.dart';
import 'package:med_loan/misc/functions.dart';
import 'package:med_loan/misc/widgets.dart';

class KYCPage extends ConsumerStatefulWidget {
  const KYCPage({super.key});

  @override
  ConsumerState<KYCPage> createState() => _KYCPageState();
}

class _KYCPageState extends ConsumerState<KYCPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController ninController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  final Map<String, String> _authDetails = {
    "gender": "",
    "dob": "",
    "nin": "",
    "status": "",
    "occupation": "",
  };

  DateTime? dateOfBirth;
  String? gender, occupationStatus;

  @override
  void dispose() {
    dateOfBirthController.dispose();
    ninController.dispose();
    occupationController.dispose();
    super.dispose();
  }

  Future<void> pickDOB() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dateOfBirthController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
      dateOfBirth = pickedDate;
      setState(() {});
    }
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
                  "Let's verify your identity",
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
                        "National Identification Number (NIN)",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: ninController,
                        prefix: Icon(
                          Icons.person_2_outlined,
                          size: 18.r,
                        ),
                        onValidate: (value) {
                          if (value!.isEmpty) {
                            showToast("Invalid NIN", context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["nin"] = value!,
                        hint: "e.g 01234567890",
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Date Of Birth",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: dateOfBirthController,
                        prefix: GestureDetector(
                          onTap: pickDOB,
                          child: Icon(
                            Icons.calendar_month,
                            size: 18.r,
                          ),
                        ),
                        readOnly: true,
                        onValidate: (value) {
                          if (value!.isEmpty) {
                            showToast("Invalid Date of Birth", context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["dob"] = value!,
                        hint: "e.g 01-01-1960",
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Gender",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      ComboBox(
                        hint: "Select Gender",
                        value: gender,
                        dropdownItems: const ["Male", "Female"],
                        onChanged: (e) => setState(() {
                          gender = e;
                          _authDetails["gender"] = e!;
                        }),
                        buttonHeight: 40.h,
                        buttonWidth: 390.w,
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.5.r),
                          color: light,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Occupation Status",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      ComboBox(
                        hint: "Select Status",
                        value: occupationStatus,
                        dropdownItems: const ["Employed", "Unemployed"],
                        buttonHeight: 40.h,
                        buttonWidth: 390.w,
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.5.r),
                          color: light,
                        ),
                        onChanged: (e) => setState(() {
                          occupationStatus = e;
                          _authDetails["status"] = e!;
                        }),
                      ),
                      SizedBox(height: 10.h),
                      if (occupationStatus == "Employed")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Occupation",
                              style: context.textTheme.labelLarge,
                            ),
                            SizedBox(height: 2.h),
                            SpecialForm(
                              width: 390.w,
                              height: 40.h,
                              controller: occupationController,
                              prefix: Icon(
                                Icons.work_outline,
                                size: 18.r,
                              ),
                              onValidate: (value) {
                                if (value!.isEmpty) {
                                  showToast("Invalid Occupation", context);
                                  return '';
                                }
                                return null;
                              },
                              onSave: (value) =>
                                  _authDetails["occupation"] = value!,
                              hint: "e.g Civil Servant",
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 130.h,
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
                          context.router.pushNamed(
                            Pages.uploadImage,
                            extra: _authDetails,
                          );
                        },
                        child: Text(
                          "Proceed",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
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
