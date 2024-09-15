import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:med_loan/components/product.dart';
import 'package:med_loan/misc/constants.dart';
import 'package:med_loan/misc/providers.dart';
import 'package:med_loan/misc/widgets.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({
    super.key,
  });

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> allProducts = ref.watch(allProductsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Products",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: primary,
          ),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 10.h,
          ),
          child: Column(
            children: [
              SpecialForm(
                controller: controller,
                width: 375.w,
                height: 50.h,
                hint: "Search product",
                prefix: Icon(
                  IconsaxPlusBroken.search_normal,
                  color: const Color(0xFFA9A9A9),
                  size: 20.r,
                ),
                fillColor: const Color(0xFFF4F4F4),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: GridView.builder(
                  itemBuilder: (_, index) =>
                      ProductContainer(product: allProducts[index]),
                  padding: const EdgeInsets.all(1),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 125.r,
                    mainAxisSpacing: 10.r,
                    crossAxisSpacing: 10.r,
                  ),
                  itemCount: allProducts.length,
                  physics: const BouncingScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
