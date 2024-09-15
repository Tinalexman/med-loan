import 'package:badges/badges.dart' as bg;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:med_loan/components/cart.dart';
import 'package:med_loan/misc/constants.dart';
import 'package:med_loan/misc/providers.dart';

class MedLoanDrawer extends ConsumerWidget {
  final VoidCallback onCloseDrawer;

  const MedLoanDrawer({
    super.key,
    required this.onCloseDrawer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<CartOrder> orders = ref.watch(cartProvider);

    return Drawer(
      width: 270.w,
      elevation: 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                "MedLoan",
                style: context.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            ListTile(
              onTap: onCloseDrawer,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.home,
                size: 26.r,
                color: monokai,
              ),
              title: Text(
                "Home",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                onCloseDrawer();
                context.router.pushNamed(Pages.products);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.gift,
                size: 26.r,
                color: monokai,
              ),
              title: Text(
                "Products",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                onCloseDrawer();
                // context.router.pushNamed(Pages.report);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.receipt,
                size: 26.r,
                color: monokai,
              ),
              title: Text(
                "Orders",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                onCloseDrawer();
                context.router.pushNamed(Pages.cart);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.shopping_cart,
                size: 26.r,
                color: monokai,
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Cart",
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  if (orders.isNotEmpty)
                    bg.Badge(
                      badgeStyle: const bg.BadgeStyle(
                        badgeColor: primary,
                        elevation: 1.0,
                      ),
                      badgeContent: Text(
                        '${orders.length}',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: light,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                ],
              ),
            ),
            ListTile(
              onTap: () {
                onCloseDrawer();
                // context.router.pushNamed(Pages.profile);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.profile,
                size: 26.r,
                color: monokai,
              ),
              title: Text(
                "Profile",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                onCloseDrawer();
                // context.router.pushNamed(Pages.profile);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.setting,
                size: 26.r,
                color: monokai,
              ),
              title: Text(
                "Settings",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            ListTile(
              onTap: () {
                onCloseDrawer();
                // logout(ref);
                context.router.goNamed(Pages.login);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.logout,
                size: 26.r,
                color: monokai,
              ),
              title: Text(
                "Logout",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
