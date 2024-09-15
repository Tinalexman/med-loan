import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:med_loan/components/product.dart';
import 'package:med_loan/misc/constants.dart';
import 'package:med_loan/misc/providers.dart';
import 'package:med_loan/misc/widgets.dart';
import 'package:med_loan/pages/home/drawer.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<Product> hotDeals = ref.watch(hotDealsProvider);
    List<Product> topProducts = ref.watch(topProductsProvider);
    List<Product> recentlyAdded = ref.watch(recentlyAddedProvider);

    return Scaffold(
      key: scaffoldKey,
      drawer: MedLoanDrawer(
        onCloseDrawer: () => scaffoldKey.currentState?.closeDrawer(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => scaffoldKey.currentState?.openDrawer(),
                  child: Icon(
                    IconsaxPlusLinear.menu,
                    color: primary,
                    size: 26.r,
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Emmy!",
                      style: context.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Welcome back",
                      style: context.textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Icon(
                  IconsaxPlusLinear.notification,
                  color: primary,
                  size: 26.r,
                ),
              ),
            ],
            floating: true,
            snap: true,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 390.w,
                    height: 120.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get What You Need, When You Need It",
                          style: context.textTheme.titleLarge!.copyWith(
                            color: light,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "Flexible access to food, pharmaceuticals and more",
                          style: context.textTheme.bodySmall!.copyWith(
                            color: light,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "HOT DEALS",
                        style: context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "View All",
                        style: context.textTheme.bodyMedium,
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 125.r,
                mainAxisSpacing: 10.r,
                crossAxisSpacing: 10.r,
              ),
              itemBuilder: (_, index) =>
                  ProductContainer(product: hotDeals[index]),
              itemCount: hotDeals.length,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TOP PRODUCTS",
                        style: context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "View All",
                        style: context.textTheme.bodyMedium,
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 125.r,
                mainAxisSpacing: 10.r,
                crossAxisSpacing: 10.r,
              ),
              itemBuilder: (_, index) =>  ProductContainer(product: topProducts[index]),
              itemCount: topProducts.length,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "RECENTLY ADDED",
                        style: context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "View All",
                        style: context.textTheme.bodyMedium,
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 125.r,
                mainAxisSpacing: 10.r,
                crossAxisSpacing: 10.r,
              ),
              itemBuilder: (_, index) => ProductContainer(product: recentlyAdded[index]),
              itemCount: recentlyAdded.length,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
              child: SizedBox(height: 20.h),
            ),
          ),
        ],
      ),
    );
  }
}
