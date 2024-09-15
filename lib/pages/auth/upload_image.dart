import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_loan/api/file_service.dart';
import 'package:med_loan/misc/constants.dart';

class UploadImage extends ConsumerStatefulWidget {
  final Map<String, String> data;

  const UploadImage({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends ConsumerState<UploadImage>
    with SingleTickerProviderStateMixin {
  Uint8List? image;

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
                  "Upload your picture",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 32.h),
                GestureDetector(
                  onTap: () async {
                    SingleFileResponse? response = await FileManager.single(
                      type: FileType.image,
                    );

                    if(response != null) {
                      setState(() => image = response.data);
                    }
                  },
                  child: CircleAvatar(
                    radius: 120.r,
                    backgroundColor: image == null ? light : null,
                    backgroundImage: image != null ? MemoryImage(image!) : null,
                    child: image == null
                        ? Icon(
                            Icons.image_outlined,
                            size: 48.r,
                            color: monokai,
                          )
                        : null,
                  ),
                ),
                SizedBox(
                  height: 250.h,
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
                    context.router.pushReplacementNamed(Pages.home);
                  },
                  child: Text(
                    "Finish",
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
          ),
        ),
      ),
    );
  }
}
