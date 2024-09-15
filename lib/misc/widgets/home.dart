import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_loan/components/product.dart';
import 'package:med_loan/misc/constants.dart';

class ProductContainer extends StatelessWidget {
  final Product product;

  const ProductContainer({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.productDetail,
        extra: product,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 100.r,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(product.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(7.5.r),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            product.name,
            style: context.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
